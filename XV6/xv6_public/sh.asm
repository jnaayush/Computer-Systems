
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	52                   	push   %edx
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
   f:	eb 0c                	jmp    1d <main+0x1d>
  11:	8d 76 00             	lea    0x0(%esi),%esi
    if(fd >= 3){
  14:	83 f8 02             	cmp    $0x2,%eax
  17:	0f 8f c1 00 00 00    	jg     de <main+0xde>
{
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
  1d:	83 ec 08             	sub    $0x8,%esp
  20:	6a 02                	push   $0x2
  22:	68 fd 0f 00 00       	push   $0xffd
  27:	e8 7f 0b 00 00       	call   bab <open>
  2c:	83 c4 10             	add    $0x10,%esp
  2f:	85 c0                	test   %eax,%eax
  31:	79 e1                	jns    14 <main+0x14>
  33:	eb 1d                	jmp    52 <main+0x52>
  35:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
  38:	80 3d 22 16 00 00 20 	cmpb   $0x20,0x1622
  3f:	74 5c                	je     9d <main+0x9d>
  41:	8d 76 00             	lea    0x0(%esi),%esi
      buf[strlen(buf)-1] = 0;  // chop \n
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
  44:	e8 07 01 00 00       	call   150 <fork1>
  49:	85 c0                	test   %eax,%eax
  4b:	74 36                	je     83 <main+0x83>
      runcmd(parsecmd(buf));
    wait();
  4d:	e8 21 0b 00 00       	call   b73 <wait>
      break;
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
  52:	83 ec 08             	sub    $0x8,%esp
  55:	6a 64                	push   $0x64
  57:	68 20 16 00 00       	push   $0x1620
  5c:	e8 8f 00 00 00       	call   f0 <getcmd>
  61:	83 c4 10             	add    $0x10,%esp
  64:	85 c0                	test   %eax,%eax
  66:	78 30                	js     98 <main+0x98>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
  68:	80 3d 20 16 00 00 63 	cmpb   $0x63,0x1620
  6f:	75 d3                	jne    44 <main+0x44>
  71:	80 3d 21 16 00 00 64 	cmpb   $0x64,0x1621
  78:	74 be                	je     38 <main+0x38>
      buf[strlen(buf)-1] = 0;  // chop \n
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
  7a:	e8 d1 00 00 00       	call   150 <fork1>
  7f:	85 c0                	test   %eax,%eax
  81:	75 ca                	jne    4d <main+0x4d>
      runcmd(parsecmd(buf));
  83:	83 ec 0c             	sub    $0xc,%esp
  86:	68 20 16 00 00       	push   $0x1620
  8b:	e8 c4 08 00 00       	call   954 <parsecmd>
  90:	89 04 24             	mov    %eax,(%esp)
  93:	e8 d8 00 00 00       	call   170 <runcmd>
    wait();
  }
  exit();
  98:	e8 ce 0a 00 00       	call   b6b <exit>

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      // Chdir must be called by the parent, not the child.
      buf[strlen(buf)-1] = 0;  // chop \n
  9d:	83 ec 0c             	sub    $0xc,%esp
  a0:	68 20 16 00 00       	push   $0x1620
  a5:	e8 6e 09 00 00       	call   a18 <strlen>
  aa:	c6 80 1f 16 00 00 00 	movb   $0x0,0x161f(%eax)
      if(chdir(buf+3) < 0)
  b1:	c7 04 24 23 16 00 00 	movl   $0x1623,(%esp)
  b8:	e8 1e 0b 00 00       	call   bdb <chdir>
  bd:	83 c4 10             	add    $0x10,%esp
  c0:	85 c0                	test   %eax,%eax
  c2:	79 8e                	jns    52 <main+0x52>
        printf(2, "cannot cd %s\n", buf+3);
  c4:	50                   	push   %eax
  c5:	68 23 16 00 00       	push   $0x1623
  ca:	68 05 10 00 00       	push   $0x1005
  cf:	6a 02                	push   $0x2
  d1:	e8 b6 0b 00 00       	call   c8c <printf>
  d6:	83 c4 10             	add    $0x10,%esp
  d9:	e9 74 ff ff ff       	jmp    52 <main+0x52>
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
    if(fd >= 3){
      close(fd);
  de:	83 ec 0c             	sub    $0xc,%esp
  e1:	50                   	push   %eax
  e2:	e8 ac 0a 00 00       	call   b93 <close>
      break;
  e7:	83 c4 10             	add    $0x10,%esp
  ea:	e9 63 ff ff ff       	jmp    52 <main+0x52>
  ef:	90                   	nop

000000f0 <getcmd>:
  exit();
}

int
getcmd(char *buf, int nbuf)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	56                   	push   %esi
  f4:	53                   	push   %ebx
  f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  f8:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(2, "$ ");
  fb:	83 ec 08             	sub    $0x8,%esp
  fe:	68 5c 0f 00 00       	push   $0xf5c
 103:	6a 02                	push   $0x2
 105:	e8 82 0b 00 00       	call   c8c <printf>
  memset(buf, 0, nbuf);
 10a:	83 c4 0c             	add    $0xc,%esp
 10d:	56                   	push   %esi
 10e:	6a 00                	push   $0x0
 110:	53                   	push   %ebx
 111:	e8 22 09 00 00       	call   a38 <memset>
  gets(buf, nbuf);
 116:	58                   	pop    %eax
 117:	5a                   	pop    %edx
 118:	56                   	push   %esi
 119:	53                   	push   %ebx
 11a:	e8 59 09 00 00       	call   a78 <gets>
  if(buf[0] == 0) // EOF
 11f:	83 c4 10             	add    $0x10,%esp
 122:	31 c0                	xor    %eax,%eax
 124:	80 3b 00             	cmpb   $0x0,(%ebx)
 127:	0f 94 c0             	sete   %al
 12a:	f7 d8                	neg    %eax
    return -1;
  return 0;
}
 12c:	8d 65 f8             	lea    -0x8(%ebp),%esp
 12f:	5b                   	pop    %ebx
 130:	5e                   	pop    %esi
 131:	5d                   	pop    %ebp
 132:	c3                   	ret    
 133:	90                   	nop

00000134 <panic>:
  exit();
}

void
panic(char *s)
{
 134:	55                   	push   %ebp
 135:	89 e5                	mov    %esp,%ebp
 137:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
 13a:	ff 75 08             	pushl  0x8(%ebp)
 13d:	68 f9 0f 00 00       	push   $0xff9
 142:	6a 02                	push   $0x2
 144:	e8 43 0b 00 00       	call   c8c <printf>
  exit();
 149:	e8 1d 0a 00 00       	call   b6b <exit>
 14e:	66 90                	xchg   %ax,%ax

00000150 <fork1>:
}

int
fork1(void)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	83 ec 08             	sub    $0x8,%esp
  int pid;

  pid = fork();
 156:	e8 08 0a 00 00       	call   b63 <fork>
  if(pid == -1)
 15b:	83 f8 ff             	cmp    $0xffffffff,%eax
 15e:	74 02                	je     162 <fork1+0x12>
    panic("fork");
  return pid;
}
 160:	c9                   	leave  
 161:	c3                   	ret    
{
  int pid;

  pid = fork();
  if(pid == -1)
    panic("fork");
 162:	83 ec 0c             	sub    $0xc,%esp
 165:	68 5f 0f 00 00       	push   $0xf5f
 16a:	e8 c5 ff ff ff       	call   134 <panic>
 16f:	90                   	nop

00000170 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	53                   	push   %ebx
 174:	83 ec 14             	sub    $0x14,%esp
 177:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
 17a:	85 db                	test   %ebx,%ebx
 17c:	74 64                	je     1e2 <runcmd+0x72>
    exit();

  switch(cmd->type){
 17e:	83 3b 05             	cmpl   $0x5,(%ebx)
 181:	0f 87 d8 00 00 00    	ja     25f <runcmd+0xef>
 187:	8b 03                	mov    (%ebx),%eax
 189:	ff 24 85 14 10 00 00 	jmp    *0x1014(,%eax,4)
    runcmd(lcmd->right);
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
 190:	83 ec 0c             	sub    $0xc,%esp
 193:	8d 45 f0             	lea    -0x10(%ebp),%eax
 196:	50                   	push   %eax
 197:	e8 df 09 00 00       	call   b7b <pipe>
 19c:	83 c4 10             	add    $0x10,%esp
 19f:	85 c0                	test   %eax,%eax
 1a1:	0f 88 c5 00 00 00    	js     26c <runcmd+0xfc>
      panic("pipe");
    if(fork1() == 0){
 1a7:	e8 a4 ff ff ff       	call   150 <fork1>
 1ac:	85 c0                	test   %eax,%eax
 1ae:	0f 84 08 01 00 00    	je     2bc <runcmd+0x14c>
      dup(p[1]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->left);
    }
    if(fork1() == 0){
 1b4:	e8 97 ff ff ff       	call   150 <fork1>
 1b9:	85 c0                	test   %eax,%eax
 1bb:	0f 84 cd 00 00 00    	je     28e <runcmd+0x11e>
      dup(p[0]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->right);
    }
    close(p[0]);
 1c1:	83 ec 0c             	sub    $0xc,%esp
 1c4:	ff 75 f0             	pushl  -0x10(%ebp)
 1c7:	e8 c7 09 00 00       	call   b93 <close>
    close(p[1]);
 1cc:	58                   	pop    %eax
 1cd:	ff 75 f4             	pushl  -0xc(%ebp)
 1d0:	e8 be 09 00 00       	call   b93 <close>
    wait();
 1d5:	e8 99 09 00 00       	call   b73 <wait>
    wait();
 1da:	e8 94 09 00 00       	call   b73 <wait>
    break;
 1df:	83 c4 10             	add    $0x10,%esp
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    exit();
 1e2:	e8 84 09 00 00       	call   b6b <exit>
    wait();
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
 1e7:	e8 64 ff ff ff       	call   150 <fork1>
 1ec:	85 c0                	test   %eax,%eax
 1ee:	75 f2                	jne    1e2 <runcmd+0x72>
 1f0:	eb 62                	jmp    254 <runcmd+0xe4>
  default:
    panic("runcmd");

  case EXEC:
    ecmd = (struct execcmd*)cmd;
    if(ecmd->argv[0] == 0)
 1f2:	8b 43 04             	mov    0x4(%ebx),%eax
 1f5:	85 c0                	test   %eax,%eax
 1f7:	74 e9                	je     1e2 <runcmd+0x72>
      exit();
    exec(ecmd->argv[0], ecmd->argv);
 1f9:	52                   	push   %edx
 1fa:	52                   	push   %edx
 1fb:	8d 53 04             	lea    0x4(%ebx),%edx
 1fe:	52                   	push   %edx
 1ff:	50                   	push   %eax
 200:	e8 9e 09 00 00       	call   ba3 <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
 205:	83 c4 0c             	add    $0xc,%esp
 208:	ff 73 04             	pushl  0x4(%ebx)
 20b:	68 6b 0f 00 00       	push   $0xf6b
 210:	6a 02                	push   $0x2
 212:	e8 75 0a 00 00       	call   c8c <printf>
    break;
 217:	83 c4 10             	add    $0x10,%esp
 21a:	eb c6                	jmp    1e2 <runcmd+0x72>
    runcmd(rcmd->cmd);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    if(fork1() == 0)
 21c:	e8 2f ff ff ff       	call   150 <fork1>
 221:	85 c0                	test   %eax,%eax
 223:	74 2f                	je     254 <runcmd+0xe4>
      runcmd(lcmd->left);
    wait();
 225:	e8 49 09 00 00       	call   b73 <wait>
    runcmd(lcmd->right);
 22a:	83 ec 0c             	sub    $0xc,%esp
 22d:	ff 73 08             	pushl  0x8(%ebx)
 230:	e8 3b ff ff ff       	call   170 <runcmd>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
 235:	83 ec 0c             	sub    $0xc,%esp
 238:	ff 73 14             	pushl  0x14(%ebx)
 23b:	e8 53 09 00 00       	call   b93 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
 240:	59                   	pop    %ecx
 241:	58                   	pop    %eax
 242:	ff 73 10             	pushl  0x10(%ebx)
 245:	ff 73 08             	pushl  0x8(%ebx)
 248:	e8 5e 09 00 00       	call   bab <open>
 24d:	83 c4 10             	add    $0x10,%esp
 250:	85 c0                	test   %eax,%eax
 252:	78 25                	js     279 <runcmd+0x109>
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
 254:	83 ec 0c             	sub    $0xc,%esp
 257:	ff 73 04             	pushl  0x4(%ebx)
 25a:	e8 11 ff ff ff       	call   170 <runcmd>
  if(cmd == 0)
    exit();

  switch(cmd->type){
  default:
    panic("runcmd");
 25f:	83 ec 0c             	sub    $0xc,%esp
 262:	68 64 0f 00 00       	push   $0xf64
 267:	e8 c8 fe ff ff       	call   134 <panic>
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
 26c:	83 ec 0c             	sub    $0xc,%esp
 26f:	68 8b 0f 00 00       	push   $0xf8b
 274:	e8 bb fe ff ff       	call   134 <panic>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
    if(open(rcmd->file, rcmd->mode) < 0){
      printf(2, "open %s failed\n", rcmd->file);
 279:	52                   	push   %edx
 27a:	ff 73 08             	pushl  0x8(%ebx)
 27d:	68 7b 0f 00 00       	push   $0xf7b
 282:	6a 02                	push   $0x2
 284:	e8 03 0a 00 00       	call   c8c <printf>
      exit();
 289:	e8 dd 08 00 00       	call   b6b <exit>
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->left);
    }
    if(fork1() == 0){
      close(0);
 28e:	83 ec 0c             	sub    $0xc,%esp
 291:	6a 00                	push   $0x0
 293:	e8 fb 08 00 00       	call   b93 <close>
      dup(p[0]);
 298:	5a                   	pop    %edx
 299:	ff 75 f0             	pushl  -0x10(%ebp)
 29c:	e8 42 09 00 00       	call   be3 <dup>
      close(p[0]);
 2a1:	59                   	pop    %ecx
 2a2:	ff 75 f0             	pushl  -0x10(%ebp)
 2a5:	e8 e9 08 00 00       	call   b93 <close>
      close(p[1]);
 2aa:	58                   	pop    %eax
 2ab:	ff 75 f4             	pushl  -0xc(%ebp)
 2ae:	e8 e0 08 00 00       	call   b93 <close>
      runcmd(pcmd->right);
 2b3:	58                   	pop    %eax
 2b4:	ff 73 08             	pushl  0x8(%ebx)
 2b7:	e8 b4 fe ff ff       	call   170 <runcmd>
  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
    if(fork1() == 0){
      close(1);
 2bc:	83 ec 0c             	sub    $0xc,%esp
 2bf:	6a 01                	push   $0x1
 2c1:	e8 cd 08 00 00       	call   b93 <close>
      dup(p[1]);
 2c6:	58                   	pop    %eax
 2c7:	ff 75 f4             	pushl  -0xc(%ebp)
 2ca:	e8 14 09 00 00       	call   be3 <dup>
      close(p[0]);
 2cf:	58                   	pop    %eax
 2d0:	ff 75 f0             	pushl  -0x10(%ebp)
 2d3:	e8 bb 08 00 00       	call   b93 <close>
      close(p[1]);
 2d8:	58                   	pop    %eax
 2d9:	ff 75 f4             	pushl  -0xc(%ebp)
 2dc:	e8 b2 08 00 00       	call   b93 <close>
      runcmd(pcmd->left);
 2e1:	58                   	pop    %eax
 2e2:	ff 73 04             	pushl  0x4(%ebx)
 2e5:	e8 86 fe ff ff       	call   170 <runcmd>
 2ea:	66 90                	xchg   %ax,%ax

000002ec <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
 2ec:	55                   	push   %ebp
 2ed:	89 e5                	mov    %esp,%ebp
 2ef:	53                   	push   %ebx
 2f0:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
 2f3:	6a 54                	push   $0x54
 2f5:	e8 7e 0b 00 00       	call   e78 <malloc>
 2fa:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
 2fc:	83 c4 0c             	add    $0xc,%esp
 2ff:	6a 54                	push   $0x54
 301:	6a 00                	push   $0x0
 303:	50                   	push   %eax
 304:	e8 2f 07 00 00       	call   a38 <memset>
  cmd->type = EXEC;
 309:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
 30f:	89 d8                	mov    %ebx,%eax
 311:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 314:	c9                   	leave  
 315:	c3                   	ret    
 316:	66 90                	xchg   %ax,%ax

00000318 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
 318:	55                   	push   %ebp
 319:	89 e5                	mov    %esp,%ebp
 31b:	53                   	push   %ebx
 31c:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
 31f:	6a 18                	push   $0x18
 321:	e8 52 0b 00 00       	call   e78 <malloc>
 326:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
 328:	83 c4 0c             	add    $0xc,%esp
 32b:	6a 18                	push   $0x18
 32d:	6a 00                	push   $0x0
 32f:	50                   	push   %eax
 330:	e8 03 07 00 00       	call   a38 <memset>
  cmd->type = REDIR;
 335:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
 33b:	8b 45 08             	mov    0x8(%ebp),%eax
 33e:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
 341:	8b 45 0c             	mov    0xc(%ebp),%eax
 344:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
 347:	8b 45 10             	mov    0x10(%ebp),%eax
 34a:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
 34d:	8b 45 14             	mov    0x14(%ebp),%eax
 350:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
 353:	8b 45 18             	mov    0x18(%ebp),%eax
 356:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
 359:	89 d8                	mov    %ebx,%eax
 35b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 35e:	c9                   	leave  
 35f:	c3                   	ret    

00000360 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	53                   	push   %ebx
 364:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
 367:	6a 0c                	push   $0xc
 369:	e8 0a 0b 00 00       	call   e78 <malloc>
 36e:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
 370:	83 c4 0c             	add    $0xc,%esp
 373:	6a 0c                	push   $0xc
 375:	6a 00                	push   $0x0
 377:	50                   	push   %eax
 378:	e8 bb 06 00 00       	call   a38 <memset>
  cmd->type = PIPE;
 37d:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
 383:	8b 45 08             	mov    0x8(%ebp),%eax
 386:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
 389:	8b 45 0c             	mov    0xc(%ebp),%eax
 38c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
 38f:	89 d8                	mov    %ebx,%eax
 391:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 394:	c9                   	leave  
 395:	c3                   	ret    
 396:	66 90                	xchg   %ax,%ax

00000398 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
 398:	55                   	push   %ebp
 399:	89 e5                	mov    %esp,%ebp
 39b:	53                   	push   %ebx
 39c:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
 39f:	6a 0c                	push   $0xc
 3a1:	e8 d2 0a 00 00       	call   e78 <malloc>
 3a6:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
 3a8:	83 c4 0c             	add    $0xc,%esp
 3ab:	6a 0c                	push   $0xc
 3ad:	6a 00                	push   $0x0
 3af:	50                   	push   %eax
 3b0:	e8 83 06 00 00       	call   a38 <memset>
  cmd->type = LIST;
 3b5:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
 3bb:	8b 45 08             	mov    0x8(%ebp),%eax
 3be:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
 3c1:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c4:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
 3c7:	89 d8                	mov    %ebx,%eax
 3c9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3cc:	c9                   	leave  
 3cd:	c3                   	ret    
 3ce:	66 90                	xchg   %ax,%ax

000003d0 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	53                   	push   %ebx
 3d4:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
 3d7:	6a 08                	push   $0x8
 3d9:	e8 9a 0a 00 00       	call   e78 <malloc>
 3de:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
 3e0:	83 c4 0c             	add    $0xc,%esp
 3e3:	6a 08                	push   $0x8
 3e5:	6a 00                	push   $0x0
 3e7:	50                   	push   %eax
 3e8:	e8 4b 06 00 00       	call   a38 <memset>
  cmd->type = BACK;
 3ed:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
 3f3:	8b 45 08             	mov    0x8(%ebp),%eax
 3f6:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
 3f9:	89 d8                	mov    %ebx,%eax
 3fb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3fe:	c9                   	leave  
 3ff:	c3                   	ret    

00000400 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	56                   	push   %esi
 405:	53                   	push   %ebx
 406:	83 ec 0c             	sub    $0xc,%esp
 409:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 40c:	8b 75 10             	mov    0x10(%ebp),%esi
  char *s;
  int ret;

  s = *ps;
 40f:	8b 45 08             	mov    0x8(%ebp),%eax
 412:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
 414:	39 df                	cmp    %ebx,%edi
 416:	72 09                	jb     421 <gettoken+0x21>
 418:	eb 1f                	jmp    439 <gettoken+0x39>
 41a:	66 90                	xchg   %ax,%ax
    s++;
 41c:	47                   	inc    %edi
{
  char *s;
  int ret;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
 41d:	39 df                	cmp    %ebx,%edi
 41f:	74 18                	je     439 <gettoken+0x39>
 421:	83 ec 08             	sub    $0x8,%esp
 424:	0f be 07             	movsbl (%edi),%eax
 427:	50                   	push   %eax
 428:	68 04 16 00 00       	push   $0x1604
 42d:	e8 1e 06 00 00       	call   a50 <strchr>
 432:	83 c4 10             	add    $0x10,%esp
 435:	85 c0                	test   %eax,%eax
 437:	75 e3                	jne    41c <gettoken+0x1c>
    s++;
  if(q)
 439:	85 f6                	test   %esi,%esi
 43b:	74 02                	je     43f <gettoken+0x3f>
    *q = s;
 43d:	89 3e                	mov    %edi,(%esi)
  ret = *s;
 43f:	0f be 37             	movsbl (%edi),%esi
 442:	89 f1                	mov    %esi,%ecx
 444:	89 f0                	mov    %esi,%eax
  switch(*s){
 446:	80 f9 29             	cmp    $0x29,%cl
 449:	7f 4d                	jg     498 <gettoken+0x98>
 44b:	80 f9 28             	cmp    $0x28,%cl
 44e:	7d 53                	jge    4a3 <gettoken+0xa3>
 450:	84 c9                	test   %cl,%cl
 452:	0f 85 bc 00 00 00    	jne    514 <gettoken+0x114>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
 458:	8b 55 14             	mov    0x14(%ebp),%edx
 45b:	85 d2                	test   %edx,%edx
 45d:	74 05                	je     464 <gettoken+0x64>
    *eq = s;
 45f:	8b 45 14             	mov    0x14(%ebp),%eax
 462:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
 464:	39 fb                	cmp    %edi,%ebx
 466:	77 09                	ja     471 <gettoken+0x71>
 468:	eb 1f                	jmp    489 <gettoken+0x89>
 46a:	66 90                	xchg   %ax,%ax
    s++;
 46c:	47                   	inc    %edi
    break;
  }
  if(eq)
    *eq = s;

  while(s < es && strchr(whitespace, *s))
 46d:	39 df                	cmp    %ebx,%edi
 46f:	74 18                	je     489 <gettoken+0x89>
 471:	83 ec 08             	sub    $0x8,%esp
 474:	0f be 07             	movsbl (%edi),%eax
 477:	50                   	push   %eax
 478:	68 04 16 00 00       	push   $0x1604
 47d:	e8 ce 05 00 00       	call   a50 <strchr>
 482:	83 c4 10             	add    $0x10,%esp
 485:	85 c0                	test   %eax,%eax
 487:	75 e3                	jne    46c <gettoken+0x6c>
    s++;
  *ps = s;
 489:	8b 45 08             	mov    0x8(%ebp),%eax
 48c:	89 38                	mov    %edi,(%eax)
  return ret;
}
 48e:	89 f0                	mov    %esi,%eax
 490:	8d 65 f4             	lea    -0xc(%ebp),%esp
 493:	5b                   	pop    %ebx
 494:	5e                   	pop    %esi
 495:	5f                   	pop    %edi
 496:	5d                   	pop    %ebp
 497:	c3                   	ret    
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
 498:	80 f9 3e             	cmp    $0x3e,%cl
 49b:	75 0b                	jne    4a8 <gettoken+0xa8>
  case '<':
    s++;
    break;
  case '>':
    s++;
    if(*s == '>'){
 49d:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
 4a1:	74 61                	je     504 <gettoken+0x104>
  case '&':
  case '<':
    s++;
    break;
  case '>':
    s++;
 4a3:	47                   	inc    %edi
 4a4:	eb b2                	jmp    458 <gettoken+0x58>
 4a6:	66 90                	xchg   %ax,%ax
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
 4a8:	7f 4e                	jg     4f8 <gettoken+0xf8>
 4aa:	83 e9 3b             	sub    $0x3b,%ecx
 4ad:	80 f9 01             	cmp    $0x1,%cl
 4b0:	76 f1                	jbe    4a3 <gettoken+0xa3>
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
 4b2:	39 fb                	cmp    %edi,%ebx
 4b4:	77 22                	ja     4d8 <gettoken+0xd8>
 4b6:	eb 67                	jmp    51f <gettoken+0x11f>
 4b8:	83 ec 08             	sub    $0x8,%esp
 4bb:	0f be 07             	movsbl (%edi),%eax
 4be:	50                   	push   %eax
 4bf:	68 fc 15 00 00       	push   $0x15fc
 4c4:	e8 87 05 00 00       	call   a50 <strchr>
 4c9:	83 c4 10             	add    $0x10,%esp
 4cc:	85 c0                	test   %eax,%eax
 4ce:	75 1d                	jne    4ed <gettoken+0xed>
      s++;
 4d0:	47                   	inc    %edi
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
 4d1:	39 df                	cmp    %ebx,%edi
 4d3:	74 4a                	je     51f <gettoken+0x11f>
 4d5:	0f be 07             	movsbl (%edi),%eax
 4d8:	83 ec 08             	sub    $0x8,%esp
 4db:	50                   	push   %eax
 4dc:	68 04 16 00 00       	push   $0x1604
 4e1:	e8 6a 05 00 00       	call   a50 <strchr>
 4e6:	83 c4 10             	add    $0x10,%esp
 4e9:	85 c0                	test   %eax,%eax
 4eb:	74 cb                	je     4b8 <gettoken+0xb8>
      ret = '+';
      s++;
    }
    break;
  default:
    ret = 'a';
 4ed:	be 61 00 00 00       	mov    $0x61,%esi
 4f2:	e9 61 ff ff ff       	jmp    458 <gettoken+0x58>
 4f7:	90                   	nop
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
 4f8:	80 f9 7c             	cmp    $0x7c,%cl
 4fb:	75 b5                	jne    4b2 <gettoken+0xb2>
  case '&':
  case '<':
    s++;
    break;
  case '>':
    s++;
 4fd:	47                   	inc    %edi
 4fe:	e9 55 ff ff ff       	jmp    458 <gettoken+0x58>
 503:	90                   	nop
    if(*s == '>'){
      ret = '+';
      s++;
 504:	83 c7 02             	add    $0x2,%edi
    s++;
    break;
  case '>':
    s++;
    if(*s == '>'){
      ret = '+';
 507:	be 2b 00 00 00       	mov    $0x2b,%esi
 50c:	e9 47 ff ff ff       	jmp    458 <gettoken+0x58>
 511:	8d 76 00             	lea    0x0(%esi),%esi
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
 514:	80 f9 26             	cmp    $0x26,%cl
 517:	75 99                	jne    4b2 <gettoken+0xb2>
  case '&':
  case '<':
    s++;
    break;
  case '>':
    s++;
 519:	47                   	inc    %edi
 51a:	e9 39 ff ff ff       	jmp    458 <gettoken+0x58>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
 51f:	be 61 00 00 00       	mov    $0x61,%esi
 524:	8b 45 14             	mov    0x14(%ebp),%eax
 527:	85 c0                	test   %eax,%eax
 529:	0f 85 30 ff ff ff    	jne    45f <gettoken+0x5f>
 52f:	e9 55 ff ff ff       	jmp    489 <gettoken+0x89>

00000534 <peek>:
  return ret;
}

int
peek(char **ps, char *es, char *toks)
{
 534:	55                   	push   %ebp
 535:	89 e5                	mov    %esp,%ebp
 537:	57                   	push   %edi
 538:	56                   	push   %esi
 539:	53                   	push   %ebx
 53a:	83 ec 0c             	sub    $0xc,%esp
 53d:	8b 7d 08             	mov    0x8(%ebp),%edi
 540:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
 543:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
 545:	39 f3                	cmp    %esi,%ebx
 547:	72 08                	jb     551 <peek+0x1d>
 549:	eb 1e                	jmp    569 <peek+0x35>
 54b:	90                   	nop
    s++;
 54c:	43                   	inc    %ebx
peek(char **ps, char *es, char *toks)
{
  char *s;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
 54d:	39 f3                	cmp    %esi,%ebx
 54f:	74 18                	je     569 <peek+0x35>
 551:	83 ec 08             	sub    $0x8,%esp
 554:	0f be 03             	movsbl (%ebx),%eax
 557:	50                   	push   %eax
 558:	68 04 16 00 00       	push   $0x1604
 55d:	e8 ee 04 00 00       	call   a50 <strchr>
 562:	83 c4 10             	add    $0x10,%esp
 565:	85 c0                	test   %eax,%eax
 567:	75 e3                	jne    54c <peek+0x18>
    s++;
  *ps = s;
 569:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
 56b:	0f be 03             	movsbl (%ebx),%eax
 56e:	84 c0                	test   %al,%al
 570:	75 0a                	jne    57c <peek+0x48>
 572:	31 c0                	xor    %eax,%eax
}
 574:	8d 65 f4             	lea    -0xc(%ebp),%esp
 577:	5b                   	pop    %ebx
 578:	5e                   	pop    %esi
 579:	5f                   	pop    %edi
 57a:	5d                   	pop    %ebp
 57b:	c3                   	ret    

  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  *ps = s;
  return *s && strchr(toks, *s);
 57c:	83 ec 08             	sub    $0x8,%esp
 57f:	50                   	push   %eax
 580:	ff 75 10             	pushl  0x10(%ebp)
 583:	e8 c8 04 00 00       	call   a50 <strchr>
 588:	83 c4 10             	add    $0x10,%esp
 58b:	85 c0                	test   %eax,%eax
 58d:	0f 95 c0             	setne  %al
 590:	0f b6 c0             	movzbl %al,%eax
}
 593:	8d 65 f4             	lea    -0xc(%ebp),%esp
 596:	5b                   	pop    %ebx
 597:	5e                   	pop    %esi
 598:	5f                   	pop    %edi
 599:	5d                   	pop    %ebp
 59a:	c3                   	ret    
 59b:	90                   	nop

0000059c <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
 59c:	55                   	push   %ebp
 59d:	89 e5                	mov    %esp,%ebp
 59f:	57                   	push   %edi
 5a0:	56                   	push   %esi
 5a1:	53                   	push   %ebx
 5a2:	83 ec 1c             	sub    $0x1c,%esp
 5a5:	8b 75 0c             	mov    0xc(%ebp),%esi
 5a8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 5ab:	90                   	nop
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
 5ac:	50                   	push   %eax
 5ad:	68 ad 0f 00 00       	push   $0xfad
 5b2:	53                   	push   %ebx
 5b3:	56                   	push   %esi
 5b4:	e8 7b ff ff ff       	call   534 <peek>
 5b9:	83 c4 10             	add    $0x10,%esp
 5bc:	85 c0                	test   %eax,%eax
 5be:	74 60                	je     620 <parseredirs+0x84>
    tok = gettoken(ps, es, 0, 0);
 5c0:	6a 00                	push   $0x0
 5c2:	6a 00                	push   $0x0
 5c4:	53                   	push   %ebx
 5c5:	56                   	push   %esi
 5c6:	e8 35 fe ff ff       	call   400 <gettoken>
 5cb:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
 5cd:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5d0:	50                   	push   %eax
 5d1:	8d 45 e0             	lea    -0x20(%ebp),%eax
 5d4:	50                   	push   %eax
 5d5:	53                   	push   %ebx
 5d6:	56                   	push   %esi
 5d7:	e8 24 fe ff ff       	call   400 <gettoken>
 5dc:	83 c4 20             	add    $0x20,%esp
 5df:	83 f8 61             	cmp    $0x61,%eax
 5e2:	75 47                	jne    62b <parseredirs+0x8f>
      panic("missing file for redirection");
    switch(tok){
 5e4:	83 ff 3c             	cmp    $0x3c,%edi
 5e7:	74 2b                	je     614 <parseredirs+0x78>
 5e9:	83 ff 3e             	cmp    $0x3e,%edi
 5ec:	74 05                	je     5f3 <parseredirs+0x57>
 5ee:	83 ff 2b             	cmp    $0x2b,%edi
 5f1:	75 b9                	jne    5ac <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
 5f3:	83 ec 0c             	sub    $0xc,%esp
 5f6:	6a 01                	push   $0x1
 5f8:	68 01 02 00 00       	push   $0x201
 5fd:	ff 75 e4             	pushl  -0x1c(%ebp)
 600:	ff 75 e0             	pushl  -0x20(%ebp)
 603:	ff 75 08             	pushl  0x8(%ebp)
 606:	e8 0d fd ff ff       	call   318 <redircmd>
 60b:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
 60e:	83 c4 20             	add    $0x20,%esp
 611:	eb 99                	jmp    5ac <parseredirs+0x10>
 613:	90                   	nop
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
    switch(tok){
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
 614:	83 ec 0c             	sub    $0xc,%esp
 617:	6a 00                	push   $0x0
 619:	6a 00                	push   $0x0
 61b:	eb e0                	jmp    5fd <parseredirs+0x61>
 61d:	8d 76 00             	lea    0x0(%esi),%esi
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
}
 620:	8b 45 08             	mov    0x8(%ebp),%eax
 623:	8d 65 f4             	lea    -0xc(%ebp),%esp
 626:	5b                   	pop    %ebx
 627:	5e                   	pop    %esi
 628:	5f                   	pop    %edi
 629:	5d                   	pop    %ebp
 62a:	c3                   	ret    
  char *q, *eq;

  while(peek(ps, es, "<>")){
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
 62b:	83 ec 0c             	sub    $0xc,%esp
 62e:	68 90 0f 00 00       	push   $0xf90
 633:	e8 fc fa ff ff       	call   134 <panic>

00000638 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
 638:	55                   	push   %ebp
 639:	89 e5                	mov    %esp,%ebp
 63b:	57                   	push   %edi
 63c:	56                   	push   %esi
 63d:	53                   	push   %ebx
 63e:	83 ec 30             	sub    $0x30,%esp
 641:	8b 75 08             	mov    0x8(%ebp),%esi
 644:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
 647:	68 b0 0f 00 00       	push   $0xfb0
 64c:	57                   	push   %edi
 64d:	56                   	push   %esi
 64e:	e8 e1 fe ff ff       	call   534 <peek>
 653:	83 c4 10             	add    $0x10,%esp
 656:	85 c0                	test   %eax,%eax
 658:	0f 85 8e 00 00 00    	jne    6ec <parseexec+0xb4>
    return parseblock(ps, es);

  ret = execcmd();
 65e:	e8 89 fc ff ff       	call   2ec <execcmd>
 663:	89 c3                	mov    %eax,%ebx
 665:	89 45 cc             	mov    %eax,-0x34(%ebp)
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
 668:	51                   	push   %ecx
 669:	57                   	push   %edi
 66a:	56                   	push   %esi
 66b:	50                   	push   %eax
 66c:	e8 2b ff ff ff       	call   59c <parseredirs>
 671:	89 45 d0             	mov    %eax,-0x30(%ebp)
 674:	8d 5b 04             	lea    0x4(%ebx),%ebx
 677:	83 c4 10             	add    $0x10,%esp
    return parseblock(ps, es);

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
 67a:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 681:	eb 12                	jmp    695 <parseexec+0x5d>
 683:	90                   	nop
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
 684:	52                   	push   %edx
 685:	57                   	push   %edi
 686:	56                   	push   %esi
 687:	ff 75 d0             	pushl  -0x30(%ebp)
 68a:	e8 0d ff ff ff       	call   59c <parseredirs>
 68f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 692:	83 c4 10             	add    $0x10,%esp
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
 695:	50                   	push   %eax
 696:	68 c7 0f 00 00       	push   $0xfc7
 69b:	57                   	push   %edi
 69c:	56                   	push   %esi
 69d:	e8 92 fe ff ff       	call   534 <peek>
 6a2:	83 c4 10             	add    $0x10,%esp
 6a5:	85 c0                	test   %eax,%eax
 6a7:	75 5b                	jne    704 <parseexec+0xcc>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
 6a9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6ac:	50                   	push   %eax
 6ad:	8d 45 e0             	lea    -0x20(%ebp),%eax
 6b0:	50                   	push   %eax
 6b1:	57                   	push   %edi
 6b2:	56                   	push   %esi
 6b3:	e8 48 fd ff ff       	call   400 <gettoken>
 6b8:	83 c4 10             	add    $0x10,%esp
 6bb:	85 c0                	test   %eax,%eax
 6bd:	74 45                	je     704 <parseexec+0xcc>
      break;
    if(tok != 'a')
 6bf:	83 f8 61             	cmp    $0x61,%eax
 6c2:	75 62                	jne    726 <parseexec+0xee>
      panic("syntax");
    cmd->argv[argc] = q;
 6c4:	8b 45 e0             	mov    -0x20(%ebp),%eax
 6c7:	89 03                	mov    %eax,(%ebx)
    cmd->eargv[argc] = eq;
 6c9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6cc:	89 43 28             	mov    %eax,0x28(%ebx)
    argc++;
 6cf:	ff 45 d4             	incl   -0x2c(%ebp)
 6d2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 6d5:	83 c3 04             	add    $0x4,%ebx
    if(argc >= MAXARGS)
 6d8:	83 f8 0a             	cmp    $0xa,%eax
 6db:	75 a7                	jne    684 <parseexec+0x4c>
      panic("too many args");
 6dd:	83 ec 0c             	sub    $0xc,%esp
 6e0:	68 b9 0f 00 00       	push   $0xfb9
 6e5:	e8 4a fa ff ff       	call   134 <panic>
 6ea:	66 90                	xchg   %ax,%ax
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
    return parseblock(ps, es);
 6ec:	83 ec 08             	sub    $0x8,%esp
 6ef:	57                   	push   %edi
 6f0:	56                   	push   %esi
 6f1:	e8 3a 01 00 00       	call   830 <parseblock>
 6f6:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
 6f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6fc:	5b                   	pop    %ebx
 6fd:	5e                   	pop    %esi
 6fe:	5f                   	pop    %edi
 6ff:	5d                   	pop    %ebp
 700:	c3                   	ret    
 701:	8d 76 00             	lea    0x0(%esi),%esi
 704:	8b 45 cc             	mov    -0x34(%ebp),%eax
 707:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 70a:	8d 04 90             	lea    (%eax,%edx,4),%eax
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
 70d:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  cmd->eargv[argc] = 0;
 714:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
 71b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  return ret;
}
 71e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 721:	5b                   	pop    %ebx
 722:	5e                   	pop    %esi
 723:	5f                   	pop    %edi
 724:	5d                   	pop    %ebp
 725:	c3                   	ret    
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
      panic("syntax");
 726:	83 ec 0c             	sub    $0xc,%esp
 729:	68 b2 0f 00 00       	push   $0xfb2
 72e:	e8 01 fa ff ff       	call   134 <panic>
 733:	90                   	nop

00000734 <parsepipe>:
  return cmd;
}

struct cmd*
parsepipe(char **ps, char *es)
{
 734:	55                   	push   %ebp
 735:	89 e5                	mov    %esp,%ebp
 737:	57                   	push   %edi
 738:	56                   	push   %esi
 739:	53                   	push   %ebx
 73a:	83 ec 14             	sub    $0x14,%esp
 73d:	8b 5d 08             	mov    0x8(%ebp),%ebx
 740:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct cmd *cmd;

  cmd = parseexec(ps, es);
 743:	56                   	push   %esi
 744:	53                   	push   %ebx
 745:	e8 ee fe ff ff       	call   638 <parseexec>
 74a:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
 74c:	83 c4 0c             	add    $0xc,%esp
 74f:	68 cc 0f 00 00       	push   $0xfcc
 754:	56                   	push   %esi
 755:	53                   	push   %ebx
 756:	e8 d9 fd ff ff       	call   534 <peek>
 75b:	83 c4 10             	add    $0x10,%esp
 75e:	85 c0                	test   %eax,%eax
 760:	75 0a                	jne    76c <parsepipe+0x38>
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
  }
  return cmd;
}
 762:	89 f8                	mov    %edi,%eax
 764:	8d 65 f4             	lea    -0xc(%ebp),%esp
 767:	5b                   	pop    %ebx
 768:	5e                   	pop    %esi
 769:	5f                   	pop    %edi
 76a:	5d                   	pop    %ebp
 76b:	c3                   	ret    
{
  struct cmd *cmd;

  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
 76c:	6a 00                	push   $0x0
 76e:	6a 00                	push   $0x0
 770:	56                   	push   %esi
 771:	53                   	push   %ebx
 772:	e8 89 fc ff ff       	call   400 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
 777:	58                   	pop    %eax
 778:	5a                   	pop    %edx
 779:	56                   	push   %esi
 77a:	53                   	push   %ebx
 77b:	e8 b4 ff ff ff       	call   734 <parsepipe>
 780:	83 c4 10             	add    $0x10,%esp
 783:	89 45 0c             	mov    %eax,0xc(%ebp)
 786:	89 7d 08             	mov    %edi,0x8(%ebp)
  }
  return cmd;
}
 789:	8d 65 f4             	lea    -0xc(%ebp),%esp
 78c:	5b                   	pop    %ebx
 78d:	5e                   	pop    %esi
 78e:	5f                   	pop    %edi
 78f:	5d                   	pop    %ebp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
 790:	e9 cb fb ff ff       	jmp    360 <pipecmd>
 795:	8d 76 00             	lea    0x0(%esi),%esi

00000798 <parseline>:
  return cmd;
}

struct cmd*
parseline(char **ps, char *es)
{
 798:	55                   	push   %ebp
 799:	89 e5                	mov    %esp,%ebp
 79b:	57                   	push   %edi
 79c:	56                   	push   %esi
 79d:	53                   	push   %ebx
 79e:	83 ec 14             	sub    $0x14,%esp
 7a1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 7a4:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
 7a7:	56                   	push   %esi
 7a8:	53                   	push   %ebx
 7a9:	e8 86 ff ff ff       	call   734 <parsepipe>
 7ae:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
 7b0:	83 c4 10             	add    $0x10,%esp
 7b3:	eb 1b                	jmp    7d0 <parseline+0x38>
 7b5:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
 7b8:	6a 00                	push   $0x0
 7ba:	6a 00                	push   $0x0
 7bc:	56                   	push   %esi
 7bd:	53                   	push   %ebx
 7be:	e8 3d fc ff ff       	call   400 <gettoken>
    cmd = backcmd(cmd);
 7c3:	89 3c 24             	mov    %edi,(%esp)
 7c6:	e8 05 fc ff ff       	call   3d0 <backcmd>
 7cb:	89 c7                	mov    %eax,%edi
 7cd:	83 c4 10             	add    $0x10,%esp
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
 7d0:	50                   	push   %eax
 7d1:	68 ce 0f 00 00       	push   $0xfce
 7d6:	56                   	push   %esi
 7d7:	53                   	push   %ebx
 7d8:	e8 57 fd ff ff       	call   534 <peek>
 7dd:	83 c4 10             	add    $0x10,%esp
 7e0:	85 c0                	test   %eax,%eax
 7e2:	75 d4                	jne    7b8 <parseline+0x20>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
 7e4:	51                   	push   %ecx
 7e5:	68 ca 0f 00 00       	push   $0xfca
 7ea:	56                   	push   %esi
 7eb:	53                   	push   %ebx
 7ec:	e8 43 fd ff ff       	call   534 <peek>
 7f1:	83 c4 10             	add    $0x10,%esp
 7f4:	85 c0                	test   %eax,%eax
 7f6:	75 0c                	jne    804 <parseline+0x6c>
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
  }
  return cmd;
}
 7f8:	89 f8                	mov    %edi,%eax
 7fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7fd:	5b                   	pop    %ebx
 7fe:	5e                   	pop    %esi
 7ff:	5f                   	pop    %edi
 800:	5d                   	pop    %ebp
 801:	c3                   	ret    
 802:	66 90                	xchg   %ax,%ax
  while(peek(ps, es, "&")){
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
 804:	6a 00                	push   $0x0
 806:	6a 00                	push   $0x0
 808:	56                   	push   %esi
 809:	53                   	push   %ebx
 80a:	e8 f1 fb ff ff       	call   400 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
 80f:	58                   	pop    %eax
 810:	5a                   	pop    %edx
 811:	56                   	push   %esi
 812:	53                   	push   %ebx
 813:	e8 80 ff ff ff       	call   798 <parseline>
 818:	83 c4 10             	add    $0x10,%esp
 81b:	89 45 0c             	mov    %eax,0xc(%ebp)
 81e:	89 7d 08             	mov    %edi,0x8(%ebp)
  }
  return cmd;
}
 821:	8d 65 f4             	lea    -0xc(%ebp),%esp
 824:	5b                   	pop    %ebx
 825:	5e                   	pop    %esi
 826:	5f                   	pop    %edi
 827:	5d                   	pop    %ebp
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
 828:	e9 6b fb ff ff       	jmp    398 <listcmd>
 82d:	8d 76 00             	lea    0x0(%esi),%esi

00000830 <parseblock>:
  return cmd;
}

struct cmd*
parseblock(char **ps, char *es)
{
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
 833:	57                   	push   %edi
 834:	56                   	push   %esi
 835:	53                   	push   %ebx
 836:	83 ec 10             	sub    $0x10,%esp
 839:	8b 5d 08             	mov    0x8(%ebp),%ebx
 83c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct cmd *cmd;

  if(!peek(ps, es, "("))
 83f:	68 b0 0f 00 00       	push   $0xfb0
 844:	56                   	push   %esi
 845:	53                   	push   %ebx
 846:	e8 e9 fc ff ff       	call   534 <peek>
 84b:	83 c4 10             	add    $0x10,%esp
 84e:	85 c0                	test   %eax,%eax
 850:	74 4a                	je     89c <parseblock+0x6c>
    panic("parseblock");
  gettoken(ps, es, 0, 0);
 852:	6a 00                	push   $0x0
 854:	6a 00                	push   $0x0
 856:	56                   	push   %esi
 857:	53                   	push   %ebx
 858:	e8 a3 fb ff ff       	call   400 <gettoken>
  cmd = parseline(ps, es);
 85d:	58                   	pop    %eax
 85e:	5a                   	pop    %edx
 85f:	56                   	push   %esi
 860:	53                   	push   %ebx
 861:	e8 32 ff ff ff       	call   798 <parseline>
 866:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
 868:	83 c4 0c             	add    $0xc,%esp
 86b:	68 ec 0f 00 00       	push   $0xfec
 870:	56                   	push   %esi
 871:	53                   	push   %ebx
 872:	e8 bd fc ff ff       	call   534 <peek>
 877:	83 c4 10             	add    $0x10,%esp
 87a:	85 c0                	test   %eax,%eax
 87c:	74 2b                	je     8a9 <parseblock+0x79>
    panic("syntax - missing )");
  gettoken(ps, es, 0, 0);
 87e:	6a 00                	push   $0x0
 880:	6a 00                	push   $0x0
 882:	56                   	push   %esi
 883:	53                   	push   %ebx
 884:	e8 77 fb ff ff       	call   400 <gettoken>
  cmd = parseredirs(cmd, ps, es);
 889:	83 c4 0c             	add    $0xc,%esp
 88c:	56                   	push   %esi
 88d:	53                   	push   %ebx
 88e:	57                   	push   %edi
 88f:	e8 08 fd ff ff       	call   59c <parseredirs>
  return cmd;
}
 894:	8d 65 f4             	lea    -0xc(%ebp),%esp
 897:	5b                   	pop    %ebx
 898:	5e                   	pop    %esi
 899:	5f                   	pop    %edi
 89a:	5d                   	pop    %ebp
 89b:	c3                   	ret    
parseblock(char **ps, char *es)
{
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
 89c:	83 ec 0c             	sub    $0xc,%esp
 89f:	68 d0 0f 00 00       	push   $0xfd0
 8a4:	e8 8b f8 ff ff       	call   134 <panic>
  gettoken(ps, es, 0, 0);
  cmd = parseline(ps, es);
  if(!peek(ps, es, ")"))
    panic("syntax - missing )");
 8a9:	83 ec 0c             	sub    $0xc,%esp
 8ac:	68 db 0f 00 00       	push   $0xfdb
 8b1:	e8 7e f8 ff ff       	call   134 <panic>
 8b6:	66 90                	xchg   %ax,%ax

000008b8 <nulterminate>:
}

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
 8b8:	55                   	push   %ebp
 8b9:	89 e5                	mov    %esp,%ebp
 8bb:	53                   	push   %ebx
 8bc:	53                   	push   %ebx
 8bd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
 8c0:	85 db                	test   %ebx,%ebx
 8c2:	0f 84 88 00 00 00    	je     950 <nulterminate+0x98>
    return 0;

  switch(cmd->type){
 8c8:	83 3b 05             	cmpl   $0x5,(%ebx)
 8cb:	77 46                	ja     913 <nulterminate+0x5b>
 8cd:	8b 03                	mov    (%ebx),%eax
 8cf:	ff 24 85 2c 10 00 00 	jmp    *0x102c(,%eax,4)
 8d6:	66 90                	xchg   %ax,%ax
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
 8d8:	83 ec 0c             	sub    $0xc,%esp
 8db:	ff 73 04             	pushl  0x4(%ebx)
 8de:	e8 d5 ff ff ff       	call   8b8 <nulterminate>
    nulterminate(lcmd->right);
 8e3:	58                   	pop    %eax
 8e4:	ff 73 08             	pushl  0x8(%ebx)
 8e7:	e8 cc ff ff ff       	call   8b8 <nulterminate>
    break;
 8ec:	83 c4 10             	add    $0x10,%esp
 8ef:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
 8f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 8f4:	c9                   	leave  
 8f5:	c3                   	ret    
 8f6:	66 90                	xchg   %ax,%ax
 8f8:	8d 43 2c             	lea    0x2c(%ebx),%eax
    return 0;

  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
 8fb:	8b 4b 04             	mov    0x4(%ebx),%ecx
 8fe:	85 c9                	test   %ecx,%ecx
 900:	74 11                	je     913 <nulterminate+0x5b>
 902:	66 90                	xchg   %ax,%ax
      *ecmd->eargv[i] = 0;
 904:	8b 10                	mov    (%eax),%edx
 906:	c6 02 00             	movb   $0x0,(%edx)
 909:	83 c0 04             	add    $0x4,%eax
    return 0;

  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
 90c:	8b 50 d8             	mov    -0x28(%eax),%edx
 90f:	85 d2                	test   %edx,%edx
 911:	75 f1                	jne    904 <nulterminate+0x4c>
  struct redircmd *rcmd;

  if(cmd == 0)
    return 0;

  switch(cmd->type){
 913:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
 915:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 918:	c9                   	leave  
 919:	c3                   	ret    
 91a:	66 90                	xchg   %ax,%ax
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
 91c:	83 ec 0c             	sub    $0xc,%esp
 91f:	ff 73 04             	pushl  0x4(%ebx)
 922:	e8 91 ff ff ff       	call   8b8 <nulterminate>
    break;
 927:	83 c4 10             	add    $0x10,%esp
 92a:	89 d8                	mov    %ebx,%eax
  }
  return cmd;
}
 92c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 92f:	c9                   	leave  
 930:	c3                   	ret    
 931:	8d 76 00             	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
 934:	83 ec 0c             	sub    $0xc,%esp
 937:	ff 73 04             	pushl  0x4(%ebx)
 93a:	e8 79 ff ff ff       	call   8b8 <nulterminate>
    *rcmd->efile = 0;
 93f:	8b 43 0c             	mov    0xc(%ebx),%eax
 942:	c6 00 00             	movb   $0x0,(%eax)
    break;
 945:	83 c4 10             	add    $0x10,%esp
 948:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
 94a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 94d:	c9                   	leave  
 94e:	c3                   	ret    
 94f:	90                   	nop
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    return 0;
 950:	31 c0                	xor    %eax,%eax
 952:	eb 9d                	jmp    8f1 <nulterminate+0x39>

00000954 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
 954:	55                   	push   %ebp
 955:	89 e5                	mov    %esp,%ebp
 957:	56                   	push   %esi
 958:	53                   	push   %ebx
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
 959:	8b 5d 08             	mov    0x8(%ebp),%ebx
 95c:	83 ec 0c             	sub    $0xc,%esp
 95f:	53                   	push   %ebx
 960:	e8 b3 00 00 00       	call   a18 <strlen>
 965:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
 967:	59                   	pop    %ecx
 968:	5e                   	pop    %esi
 969:	53                   	push   %ebx
 96a:	8d 45 08             	lea    0x8(%ebp),%eax
 96d:	50                   	push   %eax
 96e:	e8 25 fe ff ff       	call   798 <parseline>
 973:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
 975:	83 c4 0c             	add    $0xc,%esp
 978:	68 7a 0f 00 00       	push   $0xf7a
 97d:	53                   	push   %ebx
 97e:	8d 45 08             	lea    0x8(%ebp),%eax
 981:	50                   	push   %eax
 982:	e8 ad fb ff ff       	call   534 <peek>
  if(s != es){
 987:	8b 45 08             	mov    0x8(%ebp),%eax
 98a:	83 c4 10             	add    $0x10,%esp
 98d:	39 d8                	cmp    %ebx,%eax
 98f:	75 12                	jne    9a3 <parsecmd+0x4f>
    printf(2, "leftovers: %s\n", s);
    panic("syntax");
  }
  nulterminate(cmd);
 991:	83 ec 0c             	sub    $0xc,%esp
 994:	56                   	push   %esi
 995:	e8 1e ff ff ff       	call   8b8 <nulterminate>
  return cmd;
}
 99a:	89 f0                	mov    %esi,%eax
 99c:	8d 65 f8             	lea    -0x8(%ebp),%esp
 99f:	5b                   	pop    %ebx
 9a0:	5e                   	pop    %esi
 9a1:	5d                   	pop    %ebp
 9a2:	c3                   	ret    

  es = s + strlen(s);
  cmd = parseline(&s, es);
  peek(&s, es, "");
  if(s != es){
    printf(2, "leftovers: %s\n", s);
 9a3:	52                   	push   %edx
 9a4:	50                   	push   %eax
 9a5:	68 ee 0f 00 00       	push   $0xfee
 9aa:	6a 02                	push   $0x2
 9ac:	e8 db 02 00 00       	call   c8c <printf>
    panic("syntax");
 9b1:	c7 04 24 b2 0f 00 00 	movl   $0xfb2,(%esp)
 9b8:	e8 77 f7 ff ff       	call   134 <panic>
 9bd:	66 90                	xchg   %ax,%ax
 9bf:	90                   	nop

000009c0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 9c0:	55                   	push   %ebp
 9c1:	89 e5                	mov    %esp,%ebp
 9c3:	53                   	push   %ebx
 9c4:	8b 45 08             	mov    0x8(%ebp),%eax
 9c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 9ca:	89 c2                	mov    %eax,%edx
 9cc:	42                   	inc    %edx
 9cd:	41                   	inc    %ecx
 9ce:	8a 59 ff             	mov    -0x1(%ecx),%bl
 9d1:	88 5a ff             	mov    %bl,-0x1(%edx)
 9d4:	84 db                	test   %bl,%bl
 9d6:	75 f4                	jne    9cc <strcpy+0xc>
    ;
  return os;
}
 9d8:	5b                   	pop    %ebx
 9d9:	5d                   	pop    %ebp
 9da:	c3                   	ret    
 9db:	90                   	nop

000009dc <strcmp>:

int
strcmp(const char *p, const char *q)
{
 9dc:	55                   	push   %ebp
 9dd:	89 e5                	mov    %esp,%ebp
 9df:	56                   	push   %esi
 9e0:	53                   	push   %ebx
 9e1:	8b 55 08             	mov    0x8(%ebp),%edx
 9e4:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 9e7:	0f b6 02             	movzbl (%edx),%eax
 9ea:	0f b6 0b             	movzbl (%ebx),%ecx
 9ed:	84 c0                	test   %al,%al
 9ef:	75 14                	jne    a05 <strcmp+0x29>
 9f1:	eb 1d                	jmp    a10 <strcmp+0x34>
 9f3:	90                   	nop
    p++, q++;
 9f4:	42                   	inc    %edx
 9f5:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 9f8:	0f b6 02             	movzbl (%edx),%eax
 9fb:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 9ff:	84 c0                	test   %al,%al
 a01:	74 0d                	je     a10 <strcmp+0x34>
 a03:	89 f3                	mov    %esi,%ebx
 a05:	38 c8                	cmp    %cl,%al
 a07:	74 eb                	je     9f4 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 a09:	29 c8                	sub    %ecx,%eax
}
 a0b:	5b                   	pop    %ebx
 a0c:	5e                   	pop    %esi
 a0d:	5d                   	pop    %ebp
 a0e:	c3                   	ret    
 a0f:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 a10:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 a12:	29 c8                	sub    %ecx,%eax
}
 a14:	5b                   	pop    %ebx
 a15:	5e                   	pop    %esi
 a16:	5d                   	pop    %ebp
 a17:	c3                   	ret    

00000a18 <strlen>:

uint
strlen(char *s)
{
 a18:	55                   	push   %ebp
 a19:	89 e5                	mov    %esp,%ebp
 a1b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 a1e:	80 39 00             	cmpb   $0x0,(%ecx)
 a21:	74 10                	je     a33 <strlen+0x1b>
 a23:	31 d2                	xor    %edx,%edx
 a25:	8d 76 00             	lea    0x0(%esi),%esi
 a28:	42                   	inc    %edx
 a29:	89 d0                	mov    %edx,%eax
 a2b:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 a2f:	75 f7                	jne    a28 <strlen+0x10>
    ;
  return n;
}
 a31:	5d                   	pop    %ebp
 a32:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 a33:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 a35:	5d                   	pop    %ebp
 a36:	c3                   	ret    
 a37:	90                   	nop

00000a38 <memset>:

void*
memset(void *dst, int c, uint n)
{
 a38:	55                   	push   %ebp
 a39:	89 e5                	mov    %esp,%ebp
 a3b:	57                   	push   %edi
 a3c:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 a3f:	89 d7                	mov    %edx,%edi
 a41:	8b 4d 10             	mov    0x10(%ebp),%ecx
 a44:	8b 45 0c             	mov    0xc(%ebp),%eax
 a47:	fc                   	cld    
 a48:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 a4a:	89 d0                	mov    %edx,%eax
 a4c:	5f                   	pop    %edi
 a4d:	5d                   	pop    %ebp
 a4e:	c3                   	ret    
 a4f:	90                   	nop

00000a50 <strchr>:

char*
strchr(const char *s, char c)
{
 a50:	55                   	push   %ebp
 a51:	89 e5                	mov    %esp,%ebp
 a53:	53                   	push   %ebx
 a54:	8b 45 08             	mov    0x8(%ebp),%eax
 a57:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 a5a:	8a 18                	mov    (%eax),%bl
 a5c:	84 db                	test   %bl,%bl
 a5e:	74 13                	je     a73 <strchr+0x23>
 a60:	88 d1                	mov    %dl,%cl
    if(*s == c)
 a62:	38 d3                	cmp    %dl,%bl
 a64:	75 06                	jne    a6c <strchr+0x1c>
 a66:	eb 0d                	jmp    a75 <strchr+0x25>
 a68:	38 ca                	cmp    %cl,%dl
 a6a:	74 09                	je     a75 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 a6c:	40                   	inc    %eax
 a6d:	8a 10                	mov    (%eax),%dl
 a6f:	84 d2                	test   %dl,%dl
 a71:	75 f5                	jne    a68 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 a73:	31 c0                	xor    %eax,%eax
}
 a75:	5b                   	pop    %ebx
 a76:	5d                   	pop    %ebp
 a77:	c3                   	ret    

00000a78 <gets>:

char*
gets(char *buf, int max)
{
 a78:	55                   	push   %ebp
 a79:	89 e5                	mov    %esp,%ebp
 a7b:	57                   	push   %edi
 a7c:	56                   	push   %esi
 a7d:	53                   	push   %ebx
 a7e:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 a81:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 a83:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 a86:	eb 26                	jmp    aae <gets+0x36>
    cc = read(0, &c, 1);
 a88:	50                   	push   %eax
 a89:	6a 01                	push   $0x1
 a8b:	57                   	push   %edi
 a8c:	6a 00                	push   $0x0
 a8e:	e8 f0 00 00 00       	call   b83 <read>
    if(cc < 1)
 a93:	83 c4 10             	add    $0x10,%esp
 a96:	85 c0                	test   %eax,%eax
 a98:	7e 1c                	jle    ab6 <gets+0x3e>
      break;
    buf[i++] = c;
 a9a:	8a 45 e7             	mov    -0x19(%ebp),%al
 a9d:	8b 55 08             	mov    0x8(%ebp),%edx
 aa0:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
 aa4:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 aa6:	3c 0a                	cmp    $0xa,%al
 aa8:	74 0c                	je     ab6 <gets+0x3e>
 aaa:	3c 0d                	cmp    $0xd,%al
 aac:	74 08                	je     ab6 <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 aae:	8d 5e 01             	lea    0x1(%esi),%ebx
 ab1:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 ab4:	7c d2                	jl     a88 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 ab6:	8b 45 08             	mov    0x8(%ebp),%eax
 ab9:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 abd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 ac0:	5b                   	pop    %ebx
 ac1:	5e                   	pop    %esi
 ac2:	5f                   	pop    %edi
 ac3:	5d                   	pop    %ebp
 ac4:	c3                   	ret    
 ac5:	8d 76 00             	lea    0x0(%esi),%esi

00000ac8 <stat>:

int
stat(char *n, struct stat *st)
{
 ac8:	55                   	push   %ebp
 ac9:	89 e5                	mov    %esp,%ebp
 acb:	56                   	push   %esi
 acc:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 acd:	83 ec 08             	sub    $0x8,%esp
 ad0:	6a 00                	push   $0x0
 ad2:	ff 75 08             	pushl  0x8(%ebp)
 ad5:	e8 d1 00 00 00       	call   bab <open>
 ada:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 adc:	83 c4 10             	add    $0x10,%esp
 adf:	85 c0                	test   %eax,%eax
 ae1:	78 25                	js     b08 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 ae3:	83 ec 08             	sub    $0x8,%esp
 ae6:	ff 75 0c             	pushl  0xc(%ebp)
 ae9:	50                   	push   %eax
 aea:	e8 d4 00 00 00       	call   bc3 <fstat>
 aef:	89 c6                	mov    %eax,%esi
  close(fd);
 af1:	89 1c 24             	mov    %ebx,(%esp)
 af4:	e8 9a 00 00 00       	call   b93 <close>
  return r;
 af9:	83 c4 10             	add    $0x10,%esp
 afc:	89 f0                	mov    %esi,%eax
}
 afe:	8d 65 f8             	lea    -0x8(%ebp),%esp
 b01:	5b                   	pop    %ebx
 b02:	5e                   	pop    %esi
 b03:	5d                   	pop    %ebp
 b04:	c3                   	ret    
 b05:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 b08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 b0d:	eb ef                	jmp    afe <stat+0x36>
 b0f:	90                   	nop

00000b10 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 b10:	55                   	push   %ebp
 b11:	89 e5                	mov    %esp,%ebp
 b13:	53                   	push   %ebx
 b14:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 b17:	0f be 11             	movsbl (%ecx),%edx
 b1a:	8d 42 d0             	lea    -0x30(%edx),%eax
 b1d:	3c 09                	cmp    $0x9,%al
 b1f:	b8 00 00 00 00       	mov    $0x0,%eax
 b24:	77 15                	ja     b3b <atoi+0x2b>
 b26:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 b28:	41                   	inc    %ecx
 b29:	8d 04 80             	lea    (%eax,%eax,4),%eax
 b2c:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 b30:	0f be 11             	movsbl (%ecx),%edx
 b33:	8d 5a d0             	lea    -0x30(%edx),%ebx
 b36:	80 fb 09             	cmp    $0x9,%bl
 b39:	76 ed                	jbe    b28 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 b3b:	5b                   	pop    %ebx
 b3c:	5d                   	pop    %ebp
 b3d:	c3                   	ret    
 b3e:	66 90                	xchg   %ax,%ax

00000b40 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 b40:	55                   	push   %ebp
 b41:	89 e5                	mov    %esp,%ebp
 b43:	56                   	push   %esi
 b44:	53                   	push   %ebx
 b45:	8b 45 08             	mov    0x8(%ebp),%eax
 b48:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 b4b:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 b4e:	31 d2                	xor    %edx,%edx
 b50:	85 f6                	test   %esi,%esi
 b52:	7e 0b                	jle    b5f <memmove+0x1f>
    *dst++ = *src++;
 b54:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 b57:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 b5a:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 b5b:	39 f2                	cmp    %esi,%edx
 b5d:	75 f5                	jne    b54 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 b5f:	5b                   	pop    %ebx
 b60:	5e                   	pop    %esi
 b61:	5d                   	pop    %ebp
 b62:	c3                   	ret    

00000b63 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 b63:	b8 01 00 00 00       	mov    $0x1,%eax
 b68:	cd 40                	int    $0x40
 b6a:	c3                   	ret    

00000b6b <exit>:
SYSCALL(exit)
 b6b:	b8 02 00 00 00       	mov    $0x2,%eax
 b70:	cd 40                	int    $0x40
 b72:	c3                   	ret    

00000b73 <wait>:
SYSCALL(wait)
 b73:	b8 03 00 00 00       	mov    $0x3,%eax
 b78:	cd 40                	int    $0x40
 b7a:	c3                   	ret    

00000b7b <pipe>:
SYSCALL(pipe)
 b7b:	b8 04 00 00 00       	mov    $0x4,%eax
 b80:	cd 40                	int    $0x40
 b82:	c3                   	ret    

00000b83 <read>:
SYSCALL(read)
 b83:	b8 05 00 00 00       	mov    $0x5,%eax
 b88:	cd 40                	int    $0x40
 b8a:	c3                   	ret    

00000b8b <write>:
SYSCALL(write)
 b8b:	b8 10 00 00 00       	mov    $0x10,%eax
 b90:	cd 40                	int    $0x40
 b92:	c3                   	ret    

00000b93 <close>:
SYSCALL(close)
 b93:	b8 15 00 00 00       	mov    $0x15,%eax
 b98:	cd 40                	int    $0x40
 b9a:	c3                   	ret    

00000b9b <kill>:
SYSCALL(kill)
 b9b:	b8 06 00 00 00       	mov    $0x6,%eax
 ba0:	cd 40                	int    $0x40
 ba2:	c3                   	ret    

00000ba3 <exec>:
SYSCALL(exec)
 ba3:	b8 07 00 00 00       	mov    $0x7,%eax
 ba8:	cd 40                	int    $0x40
 baa:	c3                   	ret    

00000bab <open>:
SYSCALL(open)
 bab:	b8 0f 00 00 00       	mov    $0xf,%eax
 bb0:	cd 40                	int    $0x40
 bb2:	c3                   	ret    

00000bb3 <mknod>:
SYSCALL(mknod)
 bb3:	b8 11 00 00 00       	mov    $0x11,%eax
 bb8:	cd 40                	int    $0x40
 bba:	c3                   	ret    

00000bbb <unlink>:
SYSCALL(unlink)
 bbb:	b8 12 00 00 00       	mov    $0x12,%eax
 bc0:	cd 40                	int    $0x40
 bc2:	c3                   	ret    

00000bc3 <fstat>:
SYSCALL(fstat)
 bc3:	b8 08 00 00 00       	mov    $0x8,%eax
 bc8:	cd 40                	int    $0x40
 bca:	c3                   	ret    

00000bcb <link>:
SYSCALL(link)
 bcb:	b8 13 00 00 00       	mov    $0x13,%eax
 bd0:	cd 40                	int    $0x40
 bd2:	c3                   	ret    

00000bd3 <mkdir>:
SYSCALL(mkdir)
 bd3:	b8 14 00 00 00       	mov    $0x14,%eax
 bd8:	cd 40                	int    $0x40
 bda:	c3                   	ret    

00000bdb <chdir>:
SYSCALL(chdir)
 bdb:	b8 09 00 00 00       	mov    $0x9,%eax
 be0:	cd 40                	int    $0x40
 be2:	c3                   	ret    

00000be3 <dup>:
SYSCALL(dup)
 be3:	b8 0a 00 00 00       	mov    $0xa,%eax
 be8:	cd 40                	int    $0x40
 bea:	c3                   	ret    

00000beb <getpid>:
SYSCALL(getpid)
 beb:	b8 0b 00 00 00       	mov    $0xb,%eax
 bf0:	cd 40                	int    $0x40
 bf2:	c3                   	ret    

00000bf3 <sbrk>:
SYSCALL(sbrk)
 bf3:	b8 0c 00 00 00       	mov    $0xc,%eax
 bf8:	cd 40                	int    $0x40
 bfa:	c3                   	ret    

00000bfb <sleep>:
SYSCALL(sleep)
 bfb:	b8 0d 00 00 00       	mov    $0xd,%eax
 c00:	cd 40                	int    $0x40
 c02:	c3                   	ret    

00000c03 <uptime>:
SYSCALL(uptime)
 c03:	b8 0e 00 00 00       	mov    $0xe,%eax
 c08:	cd 40                	int    $0x40
 c0a:	c3                   	ret    

00000c0b <mike>:
SYSCALL(mike)
 c0b:	b8 16 00 00 00       	mov    $0x16,%eax
 c10:	cd 40                	int    $0x40
 c12:	c3                   	ret    
 c13:	90                   	nop

00000c14 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 c14:	55                   	push   %ebp
 c15:	89 e5                	mov    %esp,%ebp
 c17:	57                   	push   %edi
 c18:	56                   	push   %esi
 c19:	53                   	push   %ebx
 c1a:	83 ec 3c             	sub    $0x3c,%esp
 c1d:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 c1f:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 c21:	8b 5d 08             	mov    0x8(%ebp),%ebx
 c24:	85 db                	test   %ebx,%ebx
 c26:	74 04                	je     c2c <printint+0x18>
 c28:	85 d2                	test   %edx,%edx
 c2a:	78 53                	js     c7f <printint+0x6b>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 c2c:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 c33:	31 db                	xor    %ebx,%ebx
 c35:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 c38:	43                   	inc    %ebx
 c39:	31 d2                	xor    %edx,%edx
 c3b:	f7 f1                	div    %ecx
 c3d:	8a 92 4c 10 00 00    	mov    0x104c(%edx),%dl
 c43:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 c46:	85 c0                	test   %eax,%eax
 c48:	75 ee                	jne    c38 <printint+0x24>
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 c4a:	89 d8                	mov    %ebx,%eax
  }while((x /= base) != 0);
  if(neg)
 c4c:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 c4f:	85 d2                	test   %edx,%edx
 c51:	74 06                	je     c59 <printint+0x45>
    buf[i++] = '-';
 c53:	43                   	inc    %ebx
 c54:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 c59:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 c5d:	8d 76 00             	lea    0x0(%esi),%esi
 c60:	8a 03                	mov    (%ebx),%al
 c62:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 c65:	50                   	push   %eax
 c66:	6a 01                	push   $0x1
 c68:	56                   	push   %esi
 c69:	57                   	push   %edi
 c6a:	e8 1c ff ff ff       	call   b8b <write>
 c6f:	4b                   	dec    %ebx
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 c70:	83 c4 10             	add    $0x10,%esp
 c73:	39 f3                	cmp    %esi,%ebx
 c75:	75 e9                	jne    c60 <printint+0x4c>
    putc(fd, buf[i]);
}
 c77:	8d 65 f4             	lea    -0xc(%ebp),%esp
 c7a:	5b                   	pop    %ebx
 c7b:	5e                   	pop    %esi
 c7c:	5f                   	pop    %edi
 c7d:	5d                   	pop    %ebp
 c7e:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 c7f:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 c81:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 c88:	eb a9                	jmp    c33 <printint+0x1f>
 c8a:	66 90                	xchg   %ax,%ax

00000c8c <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 c8c:	55                   	push   %ebp
 c8d:	89 e5                	mov    %esp,%ebp
 c8f:	57                   	push   %edi
 c90:	56                   	push   %esi
 c91:	53                   	push   %ebx
 c92:	83 ec 2c             	sub    $0x2c,%esp
 c95:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 c98:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 c9b:	8a 13                	mov    (%ebx),%dl
 c9d:	84 d2                	test   %dl,%dl
 c9f:	0f 84 a3 00 00 00    	je     d48 <printf+0xbc>
 ca5:	43                   	inc    %ebx
 ca6:	8d 45 10             	lea    0x10(%ebp),%eax
 ca9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 cac:	31 ff                	xor    %edi,%edi
 cae:	eb 24                	jmp    cd4 <printf+0x48>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 cb0:	83 fa 25             	cmp    $0x25,%edx
 cb3:	0f 84 97 00 00 00    	je     d50 <printf+0xc4>
        state = '%';
      } else {
        putc(fd, c);
 cb9:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 cbc:	50                   	push   %eax
 cbd:	6a 01                	push   $0x1
 cbf:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 cc2:	50                   	push   %eax
 cc3:	56                   	push   %esi
 cc4:	e8 c2 fe ff ff       	call   b8b <write>
 cc9:	83 c4 10             	add    $0x10,%esp
 ccc:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 ccd:	8a 53 ff             	mov    -0x1(%ebx),%dl
 cd0:	84 d2                	test   %dl,%dl
 cd2:	74 74                	je     d48 <printf+0xbc>
    c = fmt[i] & 0xff;
 cd4:	0f be c2             	movsbl %dl,%eax
 cd7:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
 cda:	85 ff                	test   %edi,%edi
 cdc:	74 d2                	je     cb0 <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 cde:	83 ff 25             	cmp    $0x25,%edi
 ce1:	75 e9                	jne    ccc <printf+0x40>
      if(c == 'd'){
 ce3:	83 fa 64             	cmp    $0x64,%edx
 ce6:	0f 84 e8 00 00 00    	je     dd4 <printf+0x148>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 cec:	25 f7 00 00 00       	and    $0xf7,%eax
 cf1:	83 f8 70             	cmp    $0x70,%eax
 cf4:	74 66                	je     d5c <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 cf6:	83 fa 73             	cmp    $0x73,%edx
 cf9:	0f 84 85 00 00 00    	je     d84 <printf+0xf8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 cff:	83 fa 63             	cmp    $0x63,%edx
 d02:	0f 84 b5 00 00 00    	je     dbd <printf+0x131>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 d08:	83 fa 25             	cmp    $0x25,%edx
 d0b:	0f 84 cf 00 00 00    	je     de0 <printf+0x154>
 d11:	89 55 d0             	mov    %edx,-0x30(%ebp)
 d14:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 d18:	50                   	push   %eax
 d19:	6a 01                	push   $0x1
 d1b:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 d1e:	50                   	push   %eax
 d1f:	56                   	push   %esi
 d20:	e8 66 fe ff ff       	call   b8b <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 d25:	8b 55 d0             	mov    -0x30(%ebp),%edx
 d28:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 d2b:	83 c4 0c             	add    $0xc,%esp
 d2e:	6a 01                	push   $0x1
 d30:	8d 45 e7             	lea    -0x19(%ebp),%eax
 d33:	50                   	push   %eax
 d34:	56                   	push   %esi
 d35:	e8 51 fe ff ff       	call   b8b <write>
 d3a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 d3d:	31 ff                	xor    %edi,%edi
 d3f:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 d40:	8a 53 ff             	mov    -0x1(%ebx),%dl
 d43:	84 d2                	test   %dl,%dl
 d45:	75 8d                	jne    cd4 <printf+0x48>
 d47:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 d48:	8d 65 f4             	lea    -0xc(%ebp),%esp
 d4b:	5b                   	pop    %ebx
 d4c:	5e                   	pop    %esi
 d4d:	5f                   	pop    %edi
 d4e:	5d                   	pop    %ebp
 d4f:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 d50:	bf 25 00 00 00       	mov    $0x25,%edi
 d55:	e9 72 ff ff ff       	jmp    ccc <printf+0x40>
 d5a:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 d5c:	83 ec 0c             	sub    $0xc,%esp
 d5f:	6a 00                	push   $0x0
 d61:	b9 10 00 00 00       	mov    $0x10,%ecx
 d66:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 d69:	8b 17                	mov    (%edi),%edx
 d6b:	89 f0                	mov    %esi,%eax
 d6d:	e8 a2 fe ff ff       	call   c14 <printint>
        ap++;
 d72:	89 f8                	mov    %edi,%eax
 d74:	83 c0 04             	add    $0x4,%eax
 d77:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 d7a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 d7d:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 d7f:	e9 48 ff ff ff       	jmp    ccc <printf+0x40>
      } else if(c == 's'){
        s = (char*)*ap;
 d84:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 d87:	8b 38                	mov    (%eax),%edi
        ap++;
 d89:	83 c0 04             	add    $0x4,%eax
 d8c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 d8f:	85 ff                	test   %edi,%edi
 d91:	74 5c                	je     def <printf+0x163>
          s = "(null)";
        while(*s != 0){
 d93:	8a 07                	mov    (%edi),%al
 d95:	84 c0                	test   %al,%al
 d97:	74 1d                	je     db6 <printf+0x12a>
 d99:	8d 76 00             	lea    0x0(%esi),%esi
 d9c:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 d9f:	50                   	push   %eax
 da0:	6a 01                	push   $0x1
 da2:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 da5:	50                   	push   %eax
 da6:	56                   	push   %esi
 da7:	e8 df fd ff ff       	call   b8b <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 dac:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 dad:	8a 07                	mov    (%edi),%al
 daf:	83 c4 10             	add    $0x10,%esp
 db2:	84 c0                	test   %al,%al
 db4:	75 e6                	jne    d9c <printf+0x110>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 db6:	31 ff                	xor    %edi,%edi
 db8:	e9 0f ff ff ff       	jmp    ccc <printf+0x40>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 dbd:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 dc0:	8b 07                	mov    (%edi),%eax
 dc2:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 dc5:	51                   	push   %ecx
 dc6:	6a 01                	push   $0x1
 dc8:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 dcb:	50                   	push   %eax
 dcc:	56                   	push   %esi
 dcd:	e8 b9 fd ff ff       	call   b8b <write>
 dd2:	eb 9e                	jmp    d72 <printf+0xe6>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 dd4:	83 ec 0c             	sub    $0xc,%esp
 dd7:	6a 01                	push   $0x1
 dd9:	b9 0a 00 00 00       	mov    $0xa,%ecx
 dde:	eb 86                	jmp    d66 <printf+0xda>
 de0:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 de4:	52                   	push   %edx
 de5:	6a 01                	push   $0x1
 de7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 dea:	e9 44 ff ff ff       	jmp    d33 <printf+0xa7>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 def:	bf 44 10 00 00       	mov    $0x1044,%edi
 df4:	eb 9d                	jmp    d93 <printf+0x107>
 df6:	66 90                	xchg   %ax,%ax

00000df8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 df8:	55                   	push   %ebp
 df9:	89 e5                	mov    %esp,%ebp
 dfb:	57                   	push   %edi
 dfc:	56                   	push   %esi
 dfd:	53                   	push   %ebx
 dfe:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 e01:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e04:	a1 84 16 00 00       	mov    0x1684,%eax
 e09:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e0c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e0e:	39 c8                	cmp    %ecx,%eax
 e10:	73 2e                	jae    e40 <free+0x48>
 e12:	39 d1                	cmp    %edx,%ecx
 e14:	72 04                	jb     e1a <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e16:	39 d0                	cmp    %edx,%eax
 e18:	72 2e                	jb     e48 <free+0x50>
      break;
  if(bp + bp->s.size == p->s.ptr){
 e1a:	8b 73 fc             	mov    -0x4(%ebx),%esi
 e1d:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 e20:	39 d7                	cmp    %edx,%edi
 e22:	74 28                	je     e4c <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 e24:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 e27:	8b 50 04             	mov    0x4(%eax),%edx
 e2a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 e2d:	39 f1                	cmp    %esi,%ecx
 e2f:	74 32                	je     e63 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 e31:	89 08                	mov    %ecx,(%eax)
  freep = p;
 e33:	a3 84 16 00 00       	mov    %eax,0x1684
}
 e38:	5b                   	pop    %ebx
 e39:	5e                   	pop    %esi
 e3a:	5f                   	pop    %edi
 e3b:	5d                   	pop    %ebp
 e3c:	c3                   	ret    
 e3d:	8d 76 00             	lea    0x0(%esi),%esi
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e40:	39 d0                	cmp    %edx,%eax
 e42:	72 04                	jb     e48 <free+0x50>
 e44:	39 d1                	cmp    %edx,%ecx
 e46:	72 d2                	jb     e1a <free+0x22>
static Header base;
static Header *freep;

void
free(void *ap)
{
 e48:	89 d0                	mov    %edx,%eax
 e4a:	eb c0                	jmp    e0c <free+0x14>
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 e4c:	03 72 04             	add    0x4(%edx),%esi
 e4f:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 e52:	8b 10                	mov    (%eax),%edx
 e54:	8b 12                	mov    (%edx),%edx
 e56:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 e59:	8b 50 04             	mov    0x4(%eax),%edx
 e5c:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 e5f:	39 f1                	cmp    %esi,%ecx
 e61:	75 ce                	jne    e31 <free+0x39>
    p->s.size += bp->s.size;
 e63:	03 53 fc             	add    -0x4(%ebx),%edx
 e66:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 e69:	8b 53 f8             	mov    -0x8(%ebx),%edx
 e6c:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 e6e:	a3 84 16 00 00       	mov    %eax,0x1684
}
 e73:	5b                   	pop    %ebx
 e74:	5e                   	pop    %esi
 e75:	5f                   	pop    %edi
 e76:	5d                   	pop    %ebp
 e77:	c3                   	ret    

00000e78 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 e78:	55                   	push   %ebp
 e79:	89 e5                	mov    %esp,%ebp
 e7b:	57                   	push   %edi
 e7c:	56                   	push   %esi
 e7d:	53                   	push   %ebx
 e7e:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 e81:	8b 45 08             	mov    0x8(%ebp),%eax
 e84:	8d 70 07             	lea    0x7(%eax),%esi
 e87:	c1 ee 03             	shr    $0x3,%esi
 e8a:	46                   	inc    %esi
  if((prevp = freep) == 0){
 e8b:	8b 15 84 16 00 00    	mov    0x1684,%edx
 e91:	85 d2                	test   %edx,%edx
 e93:	0f 84 99 00 00 00    	je     f32 <malloc+0xba>
 e99:	8b 02                	mov    (%edx),%eax
 e9b:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 e9e:	39 ce                	cmp    %ecx,%esi
 ea0:	76 62                	jbe    f04 <malloc+0x8c>
 ea2:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 ea9:	eb 0a                	jmp    eb5 <malloc+0x3d>
 eab:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 eac:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 eae:	8b 48 04             	mov    0x4(%eax),%ecx
 eb1:	39 ce                	cmp    %ecx,%esi
 eb3:	76 4f                	jbe    f04 <malloc+0x8c>
 eb5:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 eb7:	3b 05 84 16 00 00    	cmp    0x1684,%eax
 ebd:	75 ed                	jne    eac <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 ebf:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 ec5:	77 5d                	ja     f24 <malloc+0xac>
 ec7:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 ecc:	bf 00 10 00 00       	mov    $0x1000,%edi
  p = sbrk(nu * sizeof(Header));
 ed1:	83 ec 0c             	sub    $0xc,%esp
 ed4:	50                   	push   %eax
 ed5:	e8 19 fd ff ff       	call   bf3 <sbrk>
  if(p == (char*)-1)
 eda:	83 c4 10             	add    $0x10,%esp
 edd:	83 f8 ff             	cmp    $0xffffffff,%eax
 ee0:	74 1c                	je     efe <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 ee2:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 ee5:	83 ec 0c             	sub    $0xc,%esp
 ee8:	83 c0 08             	add    $0x8,%eax
 eeb:	50                   	push   %eax
 eec:	e8 07 ff ff ff       	call   df8 <free>
  return freep;
 ef1:	8b 15 84 16 00 00    	mov    0x1684,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 ef7:	83 c4 10             	add    $0x10,%esp
 efa:	85 d2                	test   %edx,%edx
 efc:	75 ae                	jne    eac <malloc+0x34>
        return 0;
 efe:	31 c0                	xor    %eax,%eax
 f00:	eb 1a                	jmp    f1c <malloc+0xa4>
 f02:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 f04:	39 ce                	cmp    %ecx,%esi
 f06:	74 24                	je     f2c <malloc+0xb4>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 f08:	29 f1                	sub    %esi,%ecx
 f0a:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 f0d:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 f10:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
 f13:	89 15 84 16 00 00    	mov    %edx,0x1684
      return (void*)(p + 1);
 f19:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 f1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 f1f:	5b                   	pop    %ebx
 f20:	5e                   	pop    %esi
 f21:	5f                   	pop    %edi
 f22:	5d                   	pop    %ebp
 f23:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 f24:	89 d8                	mov    %ebx,%eax
 f26:	89 f7                	mov    %esi,%edi
 f28:	eb a7                	jmp    ed1 <malloc+0x59>
 f2a:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 f2c:	8b 08                	mov    (%eax),%ecx
 f2e:	89 0a                	mov    %ecx,(%edx)
 f30:	eb e1                	jmp    f13 <malloc+0x9b>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 f32:	c7 05 84 16 00 00 88 	movl   $0x1688,0x1684
 f39:	16 00 00 
 f3c:	c7 05 88 16 00 00 88 	movl   $0x1688,0x1688
 f43:	16 00 00 
    base.s.size = 0;
 f46:	c7 05 8c 16 00 00 00 	movl   $0x0,0x168c
 f4d:	00 00 00 
 f50:	b8 88 16 00 00       	mov    $0x1688,%eax
 f55:	e9 48 ff ff ff       	jmp    ea2 <malloc+0x2a>
