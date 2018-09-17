#include<stdio.h>
#include<unistd.h>
#include<string.h>
#include<stdlib.h>
#include<signal.h>
#include<sys/types.h>
#include<fcntl.h>
#include <sys/stat.h>


#define BUFFER 80
#define READ_END 0
#define WRITE_END 1
#define clear() printf("\x1b[H\x1b[J");

int parent_wait;
int BACKGROUND_PROCESS = 0;
int PIPE_PRESENT = 0;
int REDIRECTION_IN = 0;
int REDIRECTION_OUT = 0;
char *command[BUFFER];
char *pipe_left;
char *pipe_right;
char *redirection_input ;
char *redirection_output;
char *command_redirection_left[BUFFER];
char *command_redirection_right[BUFFER];
char *command_pipe[2][BUFFER];



void sigint_handler(int sig){
    write(1,"\nmini-shell terminated\n",80);
    exit(0);
}

void read_command(char* arg){
    fgets(arg, BUFFER, stdin);
    int len = strlen(arg);
    arg[len-1] = '\0';
    return;
}
void print_prompt(){
    printf("mini-shell>");
    return;
}

int built_in(char *par){
    if ((strcmp("cd",par) == 0) || (strcmp("help",par) == 0) || (strcmp("clear",par) == 0)){
        return 1;
    }
    return 0;
}

void parse_command(char *com[], char *arg){
    char delim[2] = " ";
    char *token;
    token = strtok(arg, delim);
    int i = 0;
    
    while( token != NULL ) {
        com[i] = strdup( token );
        i++;
        token = strtok(NULL, delim);
    }
    if (com[0] != NULL && strcmp(com[i-1],"&") == 0){
        com[i-1] = NULL;
        BACKGROUND_PROCESS = 1;
    }
    
    com[i] = NULL;
    
}

void execute_command_cd(char *par){
    if (strcmp(par,"~") == 0){
        chdir(getenv("HOME"));
    } else if (strcmp(par,"--help") == 0){
        printf("Help for cd\n");
        printf("Usage cd ~       Changes directory to home directiory\n");
        printf("Usage cd .       Changes directory to the current directory\n");
        printf("Usage cd ..      Changes directory to the parent directory\n");
        printf("Usage cd <path>  Changes directory to the given path\n");
    } else if (chdir(par) != 0){
        printf("mini-shell: cd %s: No such file or directory\n", par);
    }
}

void execute_system(char *com[]){
    pid_t pid;
    pid = fork();
    if (pid == 0){
        execv(com[0],com);
        printf("mini-shell>Command not found--Did you mean something else?\n");
        exit(0);
    }
    else{
        if(BACKGROUND_PROCESS == 0){
            waitpid(pid, NULL,0);
        }
        BACKGROUND_PROCESS = 0;
    }
}

void execute_command(char *com[]){
    if (strcmp(com[0],"cd") == 0 && com[0] != NULL){
        if ( com[1] != NULL){
            execute_command_cd(com[1]);
        }
    }
    else if (strcmp(com[0],"help") == 0 && com[0] != NULL){
        if ( com[1] != NULL && strcmp(com[1],"--help") == 0){
            printf("The help command gives you the built in functions and commands to get their help\n");
        } else {
            printf("The Build in commands that this shell supports are:\n");
            printf("1. cd         changes directory,for more help type cd --help\n");
            printf("2. help       Gets you the information about the shell, to about help type help --help\n");
            printf("3. clear      clear the screen, for more type clear --help\n");
            printf("4. exit       exits the shell\n");
            printf("It also supports system commands from the bin:\n");
            printf("Eg. /bin/ps\n");
        }
        
    }
    else if (strcmp(com[0],"clear") == 0  && com[0] != NULL){
        if ( com[1] != NULL && strcmp(com[1],"--help") == 0){
            printf("The clear command clears up the screen\n");
        } else {
            clear();
        }
    }
    else{
        execute_system(com);
    }
}

void parse_pipe(char* arg){
    char delim[2] = "|";
    char *token;
    token = strtok(arg, delim);
    int i = 0;
    while( token != NULL ) {
        command_pipe[i][0] = strdup( token );
        i++;
        token = strtok(NULL, delim);
    }
    command_pipe[i][0] = NULL;
    char *temp = strdup(*command_pipe[0]);
    pipe_left = strdup(temp);
    if (strchr(temp, '<') == NULL && strchr(temp, '>') == NULL){
        parse_command(command_pipe[0],temp);
    }
    temp = strdup(*command_pipe[1]);
    pipe_right = strdup(temp);
    if (strchr(temp, '<') == NULL && strchr(temp, '>') == NULL){
        parse_command(command_pipe[1],temp);
    }
    free(temp);
}

void execute_pipe(char *command_pipe_exec[3][BUFFER]){
    int pipefd[2];
    pid_t pid1, pid2;
    
    if (pipe(pipefd) == -1) {
        printf("parent: Failed to create pipe\n");
        return;
    }
    
    pid1 = fork();
    if (pid1<0) {
        perror("First fork() failed!");
        exit(0);
    }
    if (pid1==0) {
        if (dup2(pipefd[WRITE_END], STDOUT_FILENO) == -1) {
            printf("dup2 failed\n");
            return;
        }
        close(pipefd[READ_END]);
        close(pipefd[WRITE_END]);
        
        if(built_in(command_pipe_exec[0][0])){
            execute_command(command_pipe_exec[0]);
            exit(0);
        }else{
            execvp(command_pipe_exec[0][0],command_pipe_exec[0]);
            perror("First command failed to execute");
            exit(0);
        }
    }
    
    pid2 = fork();
    if (pid2<0) {
        perror("Second fork() failed!");
        exit(0);
    }
    if (pid2==0) {
        if (dup2(pipefd[READ_END], STDIN_FILENO) == -1) {
            printf("child: dup2 failed\n");
            return;
        }
        close(pipefd[READ_END]);
        close(pipefd[WRITE_END]);
        if(built_in(command_pipe_exec[1][0])){
            execute_command(command_pipe_exec[1]);
            exit(0);
        } else{
            execvp(command_pipe_exec[1][0],command_pipe_exec[1]);
            perror("Second command failed to execute");
            exit(0);
        }
        
    }else{
        if(BACKGROUND_PROCESS == 0){
            close(pipefd[0]);
            close(pipefd[1]);
            waitpid(pid2,NULL,0);
            waitpid(pid1,NULL,0);
            
            
        }
    }
    BACKGROUND_PROCESS = 0;
    PIPE_PRESENT = 0;
    
}

void execute_pipe_redirection(){
    int pipefd[2];
    int fileDescriptor;
    pid_t pid1, pid2;
    if (pipe(pipefd) == -1) {
        printf("parent: Failed to create pipe\n");
        return;
    }
    
    pid1 = fork();
    if (pid1 == 0){
        if (dup2(pipefd[WRITE_END], STDOUT_FILENO) == -1) {
            printf("child: dup2 failed\n");
            return;
        }
        close(pipefd[READ_END]);
        close(pipefd[WRITE_END]);
        
        if(built_in(command_pipe[0][0])){
            execute_command(command_pipe[0]);
            exit(0);
        } else {
            execvp(command_pipe[0][0],command_pipe[0]);
            perror("Second first failed to execute");
            exit(0);
        }
    }
    
    pid2 = fork();
    if (pid2 == 0){
        fileDescriptor = open(redirection_output, O_CREAT | O_TRUNC | O_WRONLY, 0600);
        dup2(fileDescriptor, STDOUT_FILENO);
        close(fileDescriptor);
        if (dup2(pipefd[READ_END], STDIN_FILENO) == -1) {
            printf("dup2 failed\n");
            return;
        }
        close(pipefd[READ_END]);
        close(pipefd[WRITE_END]);
        
        if(built_in(command_redirection_right[0])){
            execute_command(command_redirection_left);
            exit(0);
        }else{
            execvp(command_redirection_right[0],command_redirection_right);
            perror("exec");
        }
        
    }
    
    
    
    close(pipefd[READ_END]);
    close(pipefd[WRITE_END]);
    if(BACKGROUND_PROCESS == 0){
        close(pipefd[0]);
        close(pipefd[1]);
        waitpid(pid2,NULL,0);
        waitpid(pid1,NULL,0);
    }
    REDIRECTION_IN = 0;
    REDIRECTION_OUT = 0;
    PIPE_PRESENT = 0;
    BACKGROUND_PROCESS = 0;
    command_redirection_right[0] = NULL;
    command_redirection_left[0] = NULL;
    redirection_output = NULL;
    redirection_input = NULL;
}

void execute_redirection_pipe(){
    int pipefd[2];
    int fileDescriptor;
    pid_t pid1, pid2;
    if (pipe(pipefd) == -1) {
        printf("parent: Failed to create pipe\n");
        return;
    }
    
    pid1 = fork();
    if (pid1 == 0){
        fileDescriptor = open(redirection_input, O_RDONLY, 0600);
        dup2(fileDescriptor, STDIN_FILENO);
        close(fileDescriptor);
        if (dup2(pipefd[WRITE_END], STDOUT_FILENO) == -1) {
            printf("dup2 failed\n");
            return;
        }
        close(pipefd[READ_END]);
        close(pipefd[WRITE_END]);
        
        if(built_in(command_redirection_left[0])){
            execute_command(command_redirection_left);
        }else{
            execvp(command_redirection_left[0],command_redirection_left);
            perror("exec");
        }
        
    }
    
    pid2 = fork();
    if (pid2 == 0){
        if (dup2(pipefd[READ_END], STDIN_FILENO) == -1) {
            printf("child: dup2 failed\n");
            return;
        }
        close(pipefd[READ_END]);
        close(pipefd[WRITE_END]);
        
        if(built_in(command_pipe[1][0])){
            execute_command(command_pipe[1]);
            exit(0);
        } else {
            execvp(command_pipe[1][0],command_pipe[1]);
            perror("Second command failed to execute");
            exit(0);
        }
    }
    
    close(pipefd[READ_END]);
    close(pipefd[WRITE_END]);
    if(BACKGROUND_PROCESS == 0){
        close(pipefd[0]);
        close(pipefd[1]);
        waitpid(pid2,NULL,0);
        waitpid(pid1,NULL,0);
    }
    REDIRECTION_IN = 0;
    REDIRECTION_OUT = 0;
    PIPE_PRESENT = 0;
    BACKGROUND_PROCESS = 0;
    command_redirection_right[0] = NULL;
    command_redirection_left[0] = NULL;
    redirection_output = NULL;
    redirection_input = NULL;
}


void execute_redirection_pipe_redirection(){
    int pipefd[2];
    int fileDescriptor;
    pid_t pid1, pid2;
    if (pipe(pipefd) == -1) {
        printf("parent: Failed to create pipe\n");
        return;
    }
    
    pid1 = fork();
    if (pid1 == 0){
        fileDescriptor = open(redirection_input, O_CREAT | O_TRUNC | O_WRONLY, 0600);
        dup2(fileDescriptor, STDIN_FILENO);
        close(fileDescriptor);
        if (dup2(pipefd[WRITE_END], STDOUT_FILENO) == -1) {
            printf("child: dup2 failed\n");
            return;
        }
        close(pipefd[READ_END]);
        close(pipefd[WRITE_END]);
        
        if(built_in(command_redirection_left[0])){
            execute_command(command_redirection_left);
        }else{
            execvp(command_redirection_left[0],command_redirection_left);
            perror("exec");
        }
    }
    
    pid2 = fork();
    if (pid2 == 0){
        fileDescriptor = open(redirection_output, O_CREAT | O_TRUNC | O_WRONLY, 0600);
        dup2(fileDescriptor, STDOUT_FILENO);
        close(fileDescriptor);
        if (dup2(pipefd[READ_END], STDIN_FILENO) == -1) {
            printf("dup2 failed\n");
            return;
        }
        close(pipefd[READ_END]);
        close(pipefd[WRITE_END]);
        
        if(built_in(command_redirection_right[0])){
            execute_command(command_redirection_left);
            exit(0);
        }else{
            execvp(command_redirection_right[0],command_redirection_right);
            perror("exec");
        }
        
    }
    
    
    
    close(pipefd[READ_END]);
    close(pipefd[WRITE_END]);
    if(BACKGROUND_PROCESS == 0){
        close(pipefd[0]);
        close(pipefd[1]);
        waitpid(pid2,NULL,0);
        waitpid(pid1,NULL,0);
    }
    REDIRECTION_IN = 0;
    REDIRECTION_OUT = 0;
    PIPE_PRESENT = 0;
    BACKGROUND_PROCESS = 0;
    command_redirection_right[0] = NULL;
    command_redirection_left[0] = NULL;
    redirection_output = NULL;
    redirection_input = NULL;
}

void parse_redirection_in(){
    
    char *token;
    char *temp;
    if (REDIRECTION_IN == 1){
        if (strchr(pipe_left,'<') != 0){
            token = strtok(pipe_left, "<");
            while( token != NULL ) {
                token = strtok(NULL, "<");
                if (token != NULL){
                    redirection_input = strdup(token);
                }
            }
            temp = strtok(redirection_input," ");
            redirection_input = strdup(temp);
            token = strtok(pipe_left, "<");
            temp = strdup(token);
            parse_command(command_redirection_left, temp);
        }else{
            token = strtok(pipe_right, "<");
            while( token != NULL ) {
                token = strtok(NULL, "<");
                if (token != NULL){
                    redirection_input = strdup(token);
                }
            }
            temp = strtok(redirection_input," ");
            redirection_input = strdup(temp);
            token = strtok(pipe_right, "<");
            temp = strdup(token);
            parse_command(command_redirection_right, temp);
        }
        free(temp);
        free(token);
    }
    
}
void parse_redirection_out(){
    char * token;
    char *temp;
    if (REDIRECTION_OUT == 1){
        if (strchr(pipe_left,'>') != 0){
            token = strtok(pipe_left, ">");
            while( token != NULL ) {
                token = strtok(NULL, ">");
                if (token != NULL){
                    redirection_output = strdup(token);
                }
            }
            temp = strtok(redirection_output," ");
            redirection_output = strdup(temp);
            token = strtok(pipe_left, ">");
            temp = strdup(token);
            parse_command(command_redirection_left, temp);
        }else{
            token = strtok(pipe_right, ">");
            while( token != NULL ) {
                token = strtok(NULL, ">");
                if (token != NULL){
                    redirection_output = strdup(token);
                }
            }
        }
        temp = strtok(redirection_output," ");
        redirection_output = strdup(temp);
        token = strtok(pipe_right, ">");
        temp = strdup(token);
        parse_command(command_redirection_right, temp);
    }
    free(temp);
    free(token);
    return;
}

void execute_redirection(){
    pid_t pid = 0;
    int fileDescriptor;
    pid = fork();
    if(pid==0){
        if (REDIRECTION_OUT == 1){
            fileDescriptor = open(redirection_output, O_CREAT | O_TRUNC | O_WRONLY, 0600);
            dup2(fileDescriptor, STDOUT_FILENO);
            close(fileDescriptor);
        }else if (REDIRECTION_IN == 1){
            fileDescriptor = open(redirection_input, O_RDONLY, 0600);
            dup2(fileDescriptor, STDIN_FILENO);
            close(fileDescriptor);
            fileDescriptor = open(redirection_output, O_CREAT | O_TRUNC | O_WRONLY, 0600);
            dup2(fileDescriptor, STDOUT_FILENO);
            close(fileDescriptor);
        }
        
        if(command_redirection_right[0] != NULL){
            if(built_in(command_redirection_right[0])){
                execute_command(command_redirection_right);
            }else{
                execvp(command_redirection_right[0],command_redirection_right);
                perror("exec");
            }
        }else {
            if(built_in(command_redirection_left[0])){
                execute_command(command_redirection_left);
            }else{
                execvp(command_redirection_left[0],command_redirection_left);
                perror("exec");
            }
        }
        exit(0);
    }
    else{
        if(BACKGROUND_PROCESS == 1){
        }else{
            waitpid(pid, NULL,0);
        }
    }
    REDIRECTION_IN = 0;
    REDIRECTION_OUT = 0;
    BACKGROUND_PROCESS = 0;
    command_redirection_right[0] = NULL;
    command_redirection_left[0] = NULL;
    redirection_output = NULL;
    redirection_input = NULL;
    
}
void parse(char *com[], char *arg){
    pipe_left = strdup(arg);
    pipe_right = strdup(arg);
    if (strchr(arg,'&') != NULL){
        BACKGROUND_PROCESS = 1;
    }
    if (strchr(arg,'<') != 0  || strchr(arg,'<') != 0){
        REDIRECTION_IN = 1;
    }
    if(strchr(arg,'>') != 0 || strchr(arg,'>') != 0){
        REDIRECTION_OUT = 1;
    }
    if (strchr(arg,'|') != 0){
        PIPE_PRESENT = 1;
        parse_pipe(arg);
    }
    if (strchr(pipe_left,'<') != 0  || strchr(pipe_right,'<') != 0){
        parse_redirection_in();
    }
    if(strchr(pipe_right,'>') != 0 || strchr(pipe_left,'>') != 0){
        parse_redirection_out();
    }
    if(PIPE_PRESENT == 0 && REDIRECTION_OUT == 0 && REDIRECTION_IN == 0) {
        parse_command(com,arg);
    }
}
int main(){
    char *arg;
    
    arg = (char*)malloc(sizeof(char) * BUFFER);
    signal(SIGINT, sigint_handler);
    clear();
    printf("==============================================================\n");
    printf("                      Welcome to the mini-shell               \n");
    printf("==============================================================\n");
    printf("type in help to know more\n");
    printf("--------------------------\n\n");
    while(1){
        print_prompt();
        read_command(arg);
        parse(command,arg);
        if (command[0] != NULL && strcmp(command[0],"exit") == 0){
            break;
        }
        if (PIPE_PRESENT == 0 && REDIRECTION_OUT == 0 && REDIRECTION_IN == 0){
            execute_command(command);
        }
        if (PIPE_PRESENT == 0 && (REDIRECTION_OUT == 1 || REDIRECTION_IN == 1)){
            execute_redirection();
        }
        if (PIPE_PRESENT == 1 && REDIRECTION_OUT == 0 && REDIRECTION_IN == 1){
            execute_redirection_pipe();
        }
        if (PIPE_PRESENT == 1 && REDIRECTION_OUT == 1 && REDIRECTION_IN == 0){
            execute_pipe_redirection();
        }
        if (PIPE_PRESENT == 1 && REDIRECTION_OUT == 1 && REDIRECTION_IN == 1){
            execute_redirection_pipe_redirection();
        }
        if(PIPE_PRESENT == 1 && REDIRECTION_OUT == 0 && REDIRECTION_IN == 0){
            execute_pipe(command_pipe);
        }
        
    }
    printf("\nThank you for using the mini-shell\n");
    printf("Have a nice day \n- Aayush\n\n");
    free(arg);
    return 0;
}
