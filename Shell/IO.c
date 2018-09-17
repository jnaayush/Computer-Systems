#include<stdio.h>
#include<unistd.h>
#include<string.h>
#include<stdlib.h>
#include<signal.h>


#define BUFFER 80
#define READ_END 0
#define WRITE_END 1

int BACKGROUND_PROCESS;
int PIPE_PRESENT = 0;
int REDIRECTION_IN = 0;
int REDIRECTION_OUT = 0;
char *command[BUFFER];
char *pipe_left;
char *pipe_right;
char *redirection_input;
char *redirection_output;
char *command_redirection_left[BUFFER];
char *command_redirection_right[BUFFER];
char *command_pipe[2][BUFFER];



void sigint_handler(int sig){
    write(1,"\nmini-shell terminated\n",80);
    exit(0);
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
    com[i] = NULL;
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
    if ((strcmp("ls",par) == 0) || (strcmp("help",par) == 0) || (strcmp("clear",par) == 0)){
        return 1;
    }
    return 0;
}
void execute_command_cd(char *par){
    if (strcmp(par,"--help") == 0){
        printf("Help for cd\n");
    }
    else if (chdir(par) != 0){
        printf("mini-shell: cd %s: No such file or directory\n", par);
    }
}

void execute_system(char *com[]){
    if (fork() == 0){
        execv(com[0],com);
        exit(0);
    }
    else{
        wait(&BACKGROUND_PROCESS);
    }
}

void execute_command(char *com[]){
    if (strcmp(com[0],"cd") == 0){
        if ( com[1] != NULL){
            execute_command_cd(com[1]);
        }
    } else if (strcmp(com[0],"ls") == 0){
        system("ls");
    }
    else if (strcmp(com[0],"help") == 0){
        printf("help\n");
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
    /*printf("pipe_left %s\n",pipe_left);*/
    parse_command(command_pipe[0],temp);
    temp = strdup(*command_pipe[1]);
    pipe_right = strdup(temp);
    /*printf("pipe_right %s\n",pipe_right);*/
    parse_command(command_pipe[1],temp);
    free(temp);
}

void execute_pipe(char *command_pipe_exec[3][BUFFER]){
    printf("first: |%s| second: |%s|\n",command_pipe_exec[0][0],command_pipe_exec[1][0]);
    int pipefd[2];
    pid_t pid1, pid2;
    
    if (pipe(pipefd) == -1) {
        fprintf(stderr, "parent: Failed to create pipe\n");
        return;
    }
    
    /* Create the first child and run the first command. */
    pid1 = fork();
    if (pid1<0) {
        perror("First fork() failed!");
        exit(0);
    }
    if (pid1==0) {
        /* Set the process output to the input of the pipe. */
        if (dup2(pipefd[WRITE_END], STDOUT_FILENO) == -1) {
            fprintf(stderr, "ls dup2 failed\n");
            return;
        }
        close(pipefd[READ_END]);
        close(pipefd[WRITE_END]);
        
        /*fprintf(stderr,"************* Running ls -l *************\n");*/
        if(built_in(command_pipe_exec[0][0])){
            execute_command(command_pipe_exec[0]);
            exit(0);
        }else{
            execvp(command_pipe_exec[0][0],command_pipe_exec[0]);
            perror("First execvp() failed");
            exit(0);
        }
    }
    
    
    
    /* Create the second child and run the second command. */
    pid2 = fork();
    if (pid2<0) {
        perror("Second fork() failed!");
        exit(0);
    }
    if (pid2==0) {
        /* Set the process input to the output of the pipe. */
        if (dup2(pipefd[READ_END], STDIN_FILENO) == -1) {
            fprintf(stderr, "child: grep dup2 failed\n");
            return;
        }
        close(pipefd[READ_END]);
        close(pipefd[WRITE_END]);
        /*fprintf(stderr,"************* Running test ************* \n");*/
        if(built_in(command_pipe_exec[1][0])){
            execute_command(command_pipe_exec[1]);
            exit(0);
        } else{
            execvp(command_pipe_exec[1][0],command_pipe_exec[1]);
            perror("Second execvp() failed");
            exit(0);
        }
        
    }
    
    close(pipefd[0]);
    close(pipefd[1]);
    /* Wait for the children to finish, then exit. */
    waitpid(pid1,NULL,0);
    waitpid(pid2,NULL,0);
    /*printf("************* Father exitting... *************\n");
 *      parse_command(command1,command2);*/
    PIPE_PRESENT = 0;
    
}



void parse_redirection_in(){
    
    char *token;
    char *temp;
    if (REDIRECTION_IN == 1){
        if (strchr(pipe_left,'<') != 0){
            token = strtok(pipe_left, "<");
            printf("token %s\n",token);
            
            while( token != NULL ) {
                token = strtok(NULL, "<");
                if (token != NULL){
                    redirection_input = strdup(token);
                    printf("in file name 1 %s\n",redirection_input);
                }
            }
            token = strtok(pipe_left, "<");
            printf("token %s\n",token);
            temp = strdup(token);
            parse_command(command_redirection_left, temp);
        }else{
            token = strtok(pipe_right, "<");
            printf("token %s\n",token);
            while( token != NULL ) {
                token = strtok(NULL, "<");
                if (token != NULL){
                    redirection_input = strdup(token);
                    printf("in file name 2 %s\n",redirection_input);
                }
            }
            token = strtok(pipe_right, "<");
            printf("token %s\n",token);
            temp = strdup(token);
            parse_command(command_redirection_right, temp);
        }
    }
    
}
void parse_redirection_out(){
    char * token;
    char *temp;
    if (REDIRECTION_OUT == 1){
        if (strchr(pipe_left,'>') != 0){
            token = strtok(pipe_left, ">");
            printf("token %s\n",token);
            while( token != NULL ) {
                token = strtok(NULL, ">");
                if (token != NULL){
                    redirection_output = strdup(token);
                    printf("out file name 1 %s\n",redirection_output);
                }
            }
            token = strtok(pipe_left, "<");
            printf("token %s\n",token);
            temp = strdup(token);
            parse_command(command_redirection_left, temp);
        }else{
            token = strtok(pipe_right, ">");
            printf("token %s\n",token);
            while( token != NULL ) {
                token = strtok(NULL, ">");
                if (token != NULL){
                    redirection_output = strdup(token);
                    printf("out file name 2%s\n",redirection_output);
                }
            }
        }
        token = strtok(pipe_right, "<");
        printf("token %s\n",token);
        temp = strdup(token);
        parse_command(command_redirection_right, temp);
    }
    return;
}

void execute_redirection(char *com[]){
    printf("files: out :%s in:%s\n",redirection_output,redirection_input);
    printf("commands: left:%s right:%s\n",command_redirection_left[0],command_redirection_right[0]);
}

void parse(char *com[], char *arg){
    if (strchr(arg,'|') != 0){
        PIPE_PRESENT = 1;
        parse_pipe(arg);
        if (strchr(pipe_left,'<') != 0  || strchr(pipe_right,'<') != 0){
            REDIRECTION_IN = 1;
            parse_redirection_in();
        }
        if(strchr(pipe_right,'>') != 0 || strchr(pipe_left,'>') != 0){
            REDIRECTION_OUT = 1;
            parse_redirection_out();
        }
    }
    
    else {
        parse_command(com,arg);
    }
}
int main(){
    char *arg;
    
    arg = (char*)malloc(sizeof(char) * BUFFER);
    signal(SIGINT, sigint_handler);
    
    while(1){
        print_prompt();
        read_command(arg);
        parse(command,arg);
        if (command[0] != NULL && strcmp(command[0],"exit") == 0){
            break;
        }
        if(PIPE_PRESENT == 1){
            execute_pipe(command_pipe);
        }
        if (REDIRECTION_IN == 1 || REDIRECTION_OUT == 1){
            execute_redirection(command_redirection_left);
        } else{
            execute_command(command);
        }
        
    }
    free(arg);
    return 0;
}


