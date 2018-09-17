
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return randstate;
}

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "usertests starting\n");
      11:	68 b6 49 00 00       	push   $0x49b6
      16:	6a 01                	push   $0x1
      18:	e8 db 36 00 00       	call   36f8 <printf>

  if(open("usertests.ran", 0) >= 0){
      1d:	5a                   	pop    %edx
      1e:	59                   	pop    %ecx
      1f:	6a 00                	push   $0x0
      21:	68 ca 49 00 00       	push   $0x49ca
      26:	e8 ec 35 00 00       	call   3617 <open>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	85 c0                	test   %eax,%eax
      30:	78 14                	js     46 <main+0x46>
    printf(1, "already ran user tests -- rebuild fs.img\n");
      32:	83 ec 08             	sub    $0x8,%esp
      35:	68 34 51 00 00       	push   $0x5134
      3a:	6a 01                	push   $0x1
      3c:	e8 b7 36 00 00       	call   36f8 <printf>
    exit();
      41:	e8 91 35 00 00       	call   35d7 <exit>
  }
  close(open("usertests.ran", O_CREATE));
      46:	50                   	push   %eax
      47:	50                   	push   %eax
      48:	68 00 02 00 00       	push   $0x200
      4d:	68 ca 49 00 00       	push   $0x49ca
      52:	e8 c0 35 00 00       	call   3617 <open>
      57:	89 04 24             	mov    %eax,(%esp)
      5a:	e8 a0 35 00 00       	call   35ff <close>

  argptest();
      5f:	e8 38 33 00 00       	call   339c <argptest>
  createdelete();
      64:	e8 9b 10 00 00       	call   1104 <createdelete>
  linkunlink();
      69:	e8 ae 18 00 00       	call   191c <linkunlink>
  concreate();
      6e:	e8 dd 15 00 00       	call   1650 <concreate>
  fourfiles();
      73:	e8 cc 0e 00 00       	call   f44 <fourfiles>
  sharedfd();
      78:	e8 27 0d 00 00       	call   da4 <sharedfd>

  bigargtest();
      7d:	e8 b6 2f 00 00       	call   3038 <bigargtest>
  bigwrite();
      82:	e8 a9 21 00 00       	call   2230 <bigwrite>
  bigargtest();
      87:	e8 ac 2f 00 00       	call   3038 <bigargtest>
  bsstest();
      8c:	e8 3f 2f 00 00       	call   2fd0 <bsstest>
  sbrktest();
      91:	e8 7e 2a 00 00       	call   2b14 <sbrktest>
  validatetest();
      96:	e8 89 2e 00 00       	call   2f24 <validatetest>

  opentest();
      9b:	e8 38 03 00 00       	call   3d8 <opentest>
  writetest();
      a0:	e8 c3 03 00 00       	call   468 <writetest>
  writetest1();
      a5:	e8 8e 05 00 00       	call   638 <writetest1>
  createtest();
      aa:	e8 39 07 00 00       	call   7e8 <createtest>

  openiputtest();
      af:	e8 30 02 00 00       	call   2e4 <openiputtest>
  exitiputtest();
      b4:	e8 3b 01 00 00       	call   1f4 <exitiputtest>
  iputtest();
      b9:	e8 56 00 00 00       	call   114 <iputtest>

  mem();
      be:	e8 29 0c 00 00       	call   cec <mem>
  pipe1();
      c3:	e8 e8 08 00 00       	call   9b0 <pipe1>
  preempt();
      c8:	e8 6f 0a 00 00       	call   b3c <preempt>
  exitwait();
      cd:	e8 9e 0b 00 00       	call   c70 <exitwait>

  rmdot();
      d2:	e8 19 25 00 00       	call   25f0 <rmdot>
  fourteen();
      d7:	e8 e0 23 00 00       	call   24bc <fourteen>
  bigfile();
      dc:	e8 23 22 00 00       	call   2304 <bigfile>
  subdir();
      e1:	e8 72 1a 00 00       	call   1b58 <subdir>
  linktest();
      e6:	e8 59 13 00 00       	call   1444 <linktest>
  unlinkread();
      eb:	e8 d0 11 00 00       	call   12c0 <unlinkread>
  dirfile();
      f0:	e8 6f 26 00 00       	call   2764 <dirfile>
  iref();
      f5:	e8 62 28 00 00       	call   295c <iref>
  forktest();
      fa:	e8 75 29 00 00       	call   2a74 <forktest>
  bigdir(); // slow
      ff:	e8 28 19 00 00       	call   1a2c <bigdir>

  uio();
     104:	e8 27 32 00 00       	call   3330 <uio>

  exectest();
     109:	e8 5a 08 00 00       	call   968 <exectest>

  exit();
     10e:	e8 c4 34 00 00       	call   35d7 <exit>
     113:	90                   	nop

00000114 <iputtest>:
int stdout = 1;

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(void)
{
     114:	55                   	push   %ebp
     115:	89 e5                	mov    %esp,%ebp
     117:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "iput test\n");
     11a:	68 5c 3a 00 00       	push   $0x3a5c
     11f:	ff 35 58 5a 00 00    	pushl  0x5a58
     125:	e8 ce 35 00 00       	call   36f8 <printf>

  if(mkdir("iputdir") < 0){
     12a:	c7 04 24 ef 39 00 00 	movl   $0x39ef,(%esp)
     131:	e8 09 35 00 00       	call   363f <mkdir>
     136:	83 c4 10             	add    $0x10,%esp
     139:	85 c0                	test   %eax,%eax
     13b:	78 58                	js     195 <iputtest+0x81>
    printf(stdout, "mkdir failed\n");
    exit();
  }
  if(chdir("iputdir") < 0){
     13d:	83 ec 0c             	sub    $0xc,%esp
     140:	68 ef 39 00 00       	push   $0x39ef
     145:	e8 fd 34 00 00       	call   3647 <chdir>
     14a:	83 c4 10             	add    $0x10,%esp
     14d:	85 c0                	test   %eax,%eax
     14f:	0f 88 85 00 00 00    	js     1da <iputtest+0xc6>
    printf(stdout, "chdir iputdir failed\n");
    exit();
  }
  if(unlink("../iputdir") < 0){
     155:	83 ec 0c             	sub    $0xc,%esp
     158:	68 ec 39 00 00       	push   $0x39ec
     15d:	e8 c5 34 00 00       	call   3627 <unlink>
     162:	83 c4 10             	add    $0x10,%esp
     165:	85 c0                	test   %eax,%eax
     167:	78 5a                	js     1c3 <iputtest+0xaf>
    printf(stdout, "unlink ../iputdir failed\n");
    exit();
  }
  if(chdir("/") < 0){
     169:	83 ec 0c             	sub    $0xc,%esp
     16c:	68 11 3a 00 00       	push   $0x3a11
     171:	e8 d1 34 00 00       	call   3647 <chdir>
     176:	83 c4 10             	add    $0x10,%esp
     179:	85 c0                	test   %eax,%eax
     17b:	78 2f                	js     1ac <iputtest+0x98>
    printf(stdout, "chdir / failed\n");
    exit();
  }
  printf(stdout, "iput test ok\n");
     17d:	83 ec 08             	sub    $0x8,%esp
     180:	68 94 3a 00 00       	push   $0x3a94
     185:	ff 35 58 5a 00 00    	pushl  0x5a58
     18b:	e8 68 35 00 00       	call   36f8 <printf>
     190:	83 c4 10             	add    $0x10,%esp
}
     193:	c9                   	leave  
     194:	c3                   	ret    
iputtest(void)
{
  printf(stdout, "iput test\n");

  if(mkdir("iputdir") < 0){
    printf(stdout, "mkdir failed\n");
     195:	50                   	push   %eax
     196:	50                   	push   %eax
     197:	68 c8 39 00 00       	push   $0x39c8
     19c:	ff 35 58 5a 00 00    	pushl  0x5a58
     1a2:	e8 51 35 00 00       	call   36f8 <printf>
    exit();
     1a7:	e8 2b 34 00 00       	call   35d7 <exit>
  if(unlink("../iputdir") < 0){
    printf(stdout, "unlink ../iputdir failed\n");
    exit();
  }
  if(chdir("/") < 0){
    printf(stdout, "chdir / failed\n");
     1ac:	50                   	push   %eax
     1ad:	50                   	push   %eax
     1ae:	68 13 3a 00 00       	push   $0x3a13
     1b3:	ff 35 58 5a 00 00    	pushl  0x5a58
     1b9:	e8 3a 35 00 00       	call   36f8 <printf>
    exit();
     1be:	e8 14 34 00 00       	call   35d7 <exit>
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
    exit();
  }
  if(unlink("../iputdir") < 0){
    printf(stdout, "unlink ../iputdir failed\n");
     1c3:	52                   	push   %edx
     1c4:	52                   	push   %edx
     1c5:	68 f7 39 00 00       	push   $0x39f7
     1ca:	ff 35 58 5a 00 00    	pushl  0x5a58
     1d0:	e8 23 35 00 00       	call   36f8 <printf>
    exit();
     1d5:	e8 fd 33 00 00       	call   35d7 <exit>
  if(mkdir("iputdir") < 0){
    printf(stdout, "mkdir failed\n");
    exit();
  }
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
     1da:	51                   	push   %ecx
     1db:	51                   	push   %ecx
     1dc:	68 d6 39 00 00       	push   $0x39d6
     1e1:	ff 35 58 5a 00 00    	pushl  0x5a58
     1e7:	e8 0c 35 00 00       	call   36f8 <printf>
    exit();
     1ec:	e8 e6 33 00 00       	call   35d7 <exit>
     1f1:	8d 76 00             	lea    0x0(%esi),%esi

000001f4 <exitiputtest>:
}

// does exit() call iput(p->cwd) in a transaction?
void
exitiputtest(void)
{
     1f4:	55                   	push   %ebp
     1f5:	89 e5                	mov    %esp,%ebp
     1f7:	83 ec 10             	sub    $0x10,%esp
  int pid;

  printf(stdout, "exitiput test\n");
     1fa:	68 23 3a 00 00       	push   $0x3a23
     1ff:	ff 35 58 5a 00 00    	pushl  0x5a58
     205:	e8 ee 34 00 00       	call   36f8 <printf>

  pid = fork();
     20a:	e8 c0 33 00 00       	call   35cf <fork>
  if(pid < 0){
     20f:	83 c4 10             	add    $0x10,%esp
     212:	85 c0                	test   %eax,%eax
     214:	0f 88 82 00 00 00    	js     29c <exitiputtest+0xa8>
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
     21a:	75 48                	jne    264 <exitiputtest+0x70>
    if(mkdir("iputdir") < 0){
     21c:	83 ec 0c             	sub    $0xc,%esp
     21f:	68 ef 39 00 00       	push   $0x39ef
     224:	e8 16 34 00 00       	call   363f <mkdir>
     229:	83 c4 10             	add    $0x10,%esp
     22c:	85 c0                	test   %eax,%eax
     22e:	0f 88 96 00 00 00    	js     2ca <exitiputtest+0xd6>
      printf(stdout, "mkdir failed\n");
      exit();
    }
    if(chdir("iputdir") < 0){
     234:	83 ec 0c             	sub    $0xc,%esp
     237:	68 ef 39 00 00       	push   $0x39ef
     23c:	e8 06 34 00 00       	call   3647 <chdir>
     241:	83 c4 10             	add    $0x10,%esp
     244:	85 c0                	test   %eax,%eax
     246:	78 6b                	js     2b3 <exitiputtest+0xbf>
      printf(stdout, "child chdir failed\n");
      exit();
    }
    if(unlink("../iputdir") < 0){
     248:	83 ec 0c             	sub    $0xc,%esp
     24b:	68 ec 39 00 00       	push   $0x39ec
     250:	e8 d2 33 00 00       	call   3627 <unlink>
     255:	83 c4 10             	add    $0x10,%esp
     258:	85 c0                	test   %eax,%eax
     25a:	78 28                	js     284 <exitiputtest+0x90>
      printf(stdout, "unlink ../iputdir failed\n");
      exit();
    }
    exit();
     25c:	e8 76 33 00 00       	call   35d7 <exit>
     261:	8d 76 00             	lea    0x0(%esi),%esi
  }
  wait();
     264:	e8 76 33 00 00       	call   35df <wait>
  printf(stdout, "exitiput test ok\n");
     269:	83 ec 08             	sub    $0x8,%esp
     26c:	68 46 3a 00 00       	push   $0x3a46
     271:	ff 35 58 5a 00 00    	pushl  0x5a58
     277:	e8 7c 34 00 00       	call   36f8 <printf>
     27c:	83 c4 10             	add    $0x10,%esp
}
     27f:	c9                   	leave  
     280:	c3                   	ret    
     281:	8d 76 00             	lea    0x0(%esi),%esi
    if(chdir("iputdir") < 0){
      printf(stdout, "child chdir failed\n");
      exit();
    }
    if(unlink("../iputdir") < 0){
      printf(stdout, "unlink ../iputdir failed\n");
     284:	83 ec 08             	sub    $0x8,%esp
     287:	68 f7 39 00 00       	push   $0x39f7
     28c:	ff 35 58 5a 00 00    	pushl  0x5a58
     292:	e8 61 34 00 00       	call   36f8 <printf>
      exit();
     297:	e8 3b 33 00 00       	call   35d7 <exit>

  printf(stdout, "exitiput test\n");

  pid = fork();
  if(pid < 0){
    printf(stdout, "fork failed\n");
     29c:	51                   	push   %ecx
     29d:	51                   	push   %ecx
     29e:	68 09 49 00 00       	push   $0x4909
     2a3:	ff 35 58 5a 00 00    	pushl  0x5a58
     2a9:	e8 4a 34 00 00       	call   36f8 <printf>
    exit();
     2ae:	e8 24 33 00 00       	call   35d7 <exit>
    if(mkdir("iputdir") < 0){
      printf(stdout, "mkdir failed\n");
      exit();
    }
    if(chdir("iputdir") < 0){
      printf(stdout, "child chdir failed\n");
     2b3:	50                   	push   %eax
     2b4:	50                   	push   %eax
     2b5:	68 32 3a 00 00       	push   $0x3a32
     2ba:	ff 35 58 5a 00 00    	pushl  0x5a58
     2c0:	e8 33 34 00 00       	call   36f8 <printf>
      exit();
     2c5:	e8 0d 33 00 00       	call   35d7 <exit>
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
    if(mkdir("iputdir") < 0){
      printf(stdout, "mkdir failed\n");
     2ca:	52                   	push   %edx
     2cb:	52                   	push   %edx
     2cc:	68 c8 39 00 00       	push   $0x39c8
     2d1:	ff 35 58 5a 00 00    	pushl  0x5a58
     2d7:	e8 1c 34 00 00       	call   36f8 <printf>
      exit();
     2dc:	e8 f6 32 00 00       	call   35d7 <exit>
     2e1:	8d 76 00             	lea    0x0(%esi),%esi

000002e4 <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(void)
{
     2e4:	55                   	push   %ebp
     2e5:	89 e5                	mov    %esp,%ebp
     2e7:	83 ec 10             	sub    $0x10,%esp
  int pid;

  printf(stdout, "openiput test\n");
     2ea:	68 58 3a 00 00       	push   $0x3a58
     2ef:	ff 35 58 5a 00 00    	pushl  0x5a58
     2f5:	e8 fe 33 00 00       	call   36f8 <printf>
  if(mkdir("oidir") < 0){
     2fa:	c7 04 24 67 3a 00 00 	movl   $0x3a67,(%esp)
     301:	e8 39 33 00 00       	call   363f <mkdir>
     306:	83 c4 10             	add    $0x10,%esp
     309:	85 c0                	test   %eax,%eax
     30b:	0f 88 80 00 00 00    	js     391 <openiputtest+0xad>
    printf(stdout, "mkdir oidir failed\n");
    exit();
  }
  pid = fork();
     311:	e8 b9 32 00 00       	call   35cf <fork>
  if(pid < 0){
     316:	85 c0                	test   %eax,%eax
     318:	0f 88 8a 00 00 00    	js     3a8 <openiputtest+0xc4>
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
     31e:	75 30                	jne    350 <openiputtest+0x6c>
    int fd = open("oidir", O_RDWR);
     320:	83 ec 08             	sub    $0x8,%esp
     323:	6a 02                	push   $0x2
     325:	68 67 3a 00 00       	push   $0x3a67
     32a:	e8 e8 32 00 00       	call   3617 <open>
    if(fd >= 0){
     32f:	83 c4 10             	add    $0x10,%esp
     332:	85 c0                	test   %eax,%eax
     334:	78 56                	js     38c <openiputtest+0xa8>
      printf(stdout, "open directory for write succeeded\n");
     336:	83 ec 08             	sub    $0x8,%esp
     339:	68 ec 49 00 00       	push   $0x49ec
     33e:	ff 35 58 5a 00 00    	pushl  0x5a58
     344:	e8 af 33 00 00       	call   36f8 <printf>
      exit();
     349:	e8 89 32 00 00       	call   35d7 <exit>
     34e:	66 90                	xchg   %ax,%ax
    }
    exit();
  }
  sleep(1);
     350:	83 ec 0c             	sub    $0xc,%esp
     353:	6a 01                	push   $0x1
     355:	e8 0d 33 00 00       	call   3667 <sleep>
  if(unlink("oidir") != 0){
     35a:	c7 04 24 67 3a 00 00 	movl   $0x3a67,(%esp)
     361:	e8 c1 32 00 00       	call   3627 <unlink>
     366:	83 c4 10             	add    $0x10,%esp
     369:	85 c0                	test   %eax,%eax
     36b:	75 52                	jne    3bf <openiputtest+0xdb>
    printf(stdout, "unlink failed\n");
    exit();
  }
  wait();
     36d:	e8 6d 32 00 00       	call   35df <wait>
  printf(stdout, "openiput test ok\n");
     372:	83 ec 08             	sub    $0x8,%esp
     375:	68 90 3a 00 00       	push   $0x3a90
     37a:	ff 35 58 5a 00 00    	pushl  0x5a58
     380:	e8 73 33 00 00       	call   36f8 <printf>
     385:	83 c4 10             	add    $0x10,%esp
}
     388:	c9                   	leave  
     389:	c3                   	ret    
     38a:	66 90                	xchg   %ax,%ax
    int fd = open("oidir", O_RDWR);
    if(fd >= 0){
      printf(stdout, "open directory for write succeeded\n");
      exit();
    }
    exit();
     38c:	e8 46 32 00 00       	call   35d7 <exit>
{
  int pid;

  printf(stdout, "openiput test\n");
  if(mkdir("oidir") < 0){
    printf(stdout, "mkdir oidir failed\n");
     391:	51                   	push   %ecx
     392:	51                   	push   %ecx
     393:	68 6d 3a 00 00       	push   $0x3a6d
     398:	ff 35 58 5a 00 00    	pushl  0x5a58
     39e:	e8 55 33 00 00       	call   36f8 <printf>
    exit();
     3a3:	e8 2f 32 00 00       	call   35d7 <exit>
  }
  pid = fork();
  if(pid < 0){
    printf(stdout, "fork failed\n");
     3a8:	52                   	push   %edx
     3a9:	52                   	push   %edx
     3aa:	68 09 49 00 00       	push   $0x4909
     3af:	ff 35 58 5a 00 00    	pushl  0x5a58
     3b5:	e8 3e 33 00 00       	call   36f8 <printf>
    exit();
     3ba:	e8 18 32 00 00       	call   35d7 <exit>
    }
    exit();
  }
  sleep(1);
  if(unlink("oidir") != 0){
    printf(stdout, "unlink failed\n");
     3bf:	50                   	push   %eax
     3c0:	50                   	push   %eax
     3c1:	68 81 3a 00 00       	push   $0x3a81
     3c6:	ff 35 58 5a 00 00    	pushl  0x5a58
     3cc:	e8 27 33 00 00       	call   36f8 <printf>
    exit();
     3d1:	e8 01 32 00 00       	call   35d7 <exit>
     3d6:	66 90                	xchg   %ax,%ax

000003d8 <opentest>:

// simple file system tests

void
opentest(void)
{
     3d8:	55                   	push   %ebp
     3d9:	89 e5                	mov    %esp,%ebp
     3db:	83 ec 10             	sub    $0x10,%esp
  int fd;

  printf(stdout, "open test\n");
     3de:	68 a2 3a 00 00       	push   $0x3aa2
     3e3:	ff 35 58 5a 00 00    	pushl  0x5a58
     3e9:	e8 0a 33 00 00       	call   36f8 <printf>
  fd = open("echo", 0);
     3ee:	58                   	pop    %eax
     3ef:	5a                   	pop    %edx
     3f0:	6a 00                	push   $0x0
     3f2:	68 ad 3a 00 00       	push   $0x3aad
     3f7:	e8 1b 32 00 00       	call   3617 <open>
  if(fd < 0){
     3fc:	83 c4 10             	add    $0x10,%esp
     3ff:	85 c0                	test   %eax,%eax
     401:	78 36                	js     439 <opentest+0x61>
    printf(stdout, "open echo failed!\n");
    exit();
  }
  close(fd);
     403:	83 ec 0c             	sub    $0xc,%esp
     406:	50                   	push   %eax
     407:	e8 f3 31 00 00       	call   35ff <close>
  fd = open("doesnotexist", 0);
     40c:	5a                   	pop    %edx
     40d:	59                   	pop    %ecx
     40e:	6a 00                	push   $0x0
     410:	68 c5 3a 00 00       	push   $0x3ac5
     415:	e8 fd 31 00 00       	call   3617 <open>
  if(fd >= 0){
     41a:	83 c4 10             	add    $0x10,%esp
     41d:	85 c0                	test   %eax,%eax
     41f:	79 2f                	jns    450 <opentest+0x78>
    printf(stdout, "open doesnotexist succeeded!\n");
    exit();
  }
  printf(stdout, "open test ok\n");
     421:	83 ec 08             	sub    $0x8,%esp
     424:	68 f0 3a 00 00       	push   $0x3af0
     429:	ff 35 58 5a 00 00    	pushl  0x5a58
     42f:	e8 c4 32 00 00       	call   36f8 <printf>
     434:	83 c4 10             	add    $0x10,%esp
}
     437:	c9                   	leave  
     438:	c3                   	ret    
  int fd;

  printf(stdout, "open test\n");
  fd = open("echo", 0);
  if(fd < 0){
    printf(stdout, "open echo failed!\n");
     439:	50                   	push   %eax
     43a:	50                   	push   %eax
     43b:	68 b2 3a 00 00       	push   $0x3ab2
     440:	ff 35 58 5a 00 00    	pushl  0x5a58
     446:	e8 ad 32 00 00       	call   36f8 <printf>
    exit();
     44b:	e8 87 31 00 00       	call   35d7 <exit>
  }
  close(fd);
  fd = open("doesnotexist", 0);
  if(fd >= 0){
    printf(stdout, "open doesnotexist succeeded!\n");
     450:	50                   	push   %eax
     451:	50                   	push   %eax
     452:	68 d2 3a 00 00       	push   $0x3ad2
     457:	ff 35 58 5a 00 00    	pushl  0x5a58
     45d:	e8 96 32 00 00       	call   36f8 <printf>
    exit();
     462:	e8 70 31 00 00       	call   35d7 <exit>
     467:	90                   	nop

00000468 <writetest>:
  printf(stdout, "open test ok\n");
}

void
writetest(void)
{
     468:	55                   	push   %ebp
     469:	89 e5                	mov    %esp,%ebp
     46b:	56                   	push   %esi
     46c:	53                   	push   %ebx
  int fd;
  int i;

  printf(stdout, "small file test\n");
     46d:	83 ec 08             	sub    $0x8,%esp
     470:	68 fe 3a 00 00       	push   $0x3afe
     475:	ff 35 58 5a 00 00    	pushl  0x5a58
     47b:	e8 78 32 00 00       	call   36f8 <printf>
  fd = open("small", O_CREATE|O_RDWR);
     480:	58                   	pop    %eax
     481:	5a                   	pop    %edx
     482:	68 02 02 00 00       	push   $0x202
     487:	68 0f 3b 00 00       	push   $0x3b0f
     48c:	e8 86 31 00 00       	call   3617 <open>
     491:	89 c6                	mov    %eax,%esi
  if(fd >= 0){
     493:	83 c4 10             	add    $0x10,%esp
     496:	85 c0                	test   %eax,%eax
     498:	0f 88 7f 01 00 00    	js     61d <writetest+0x1b5>
    printf(stdout, "creat small succeeded; ok\n");
     49e:	83 ec 08             	sub    $0x8,%esp
     4a1:	68 15 3b 00 00       	push   $0x3b15
     4a6:	ff 35 58 5a 00 00    	pushl  0x5a58
     4ac:	e8 47 32 00 00       	call   36f8 <printf>
     4b1:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     4b4:	31 db                	xor    %ebx,%ebx
     4b6:	66 90                	xchg   %ax,%ax
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     4b8:	50                   	push   %eax
     4b9:	6a 0a                	push   $0xa
     4bb:	68 4c 3b 00 00       	push   $0x3b4c
     4c0:	56                   	push   %esi
     4c1:	e8 31 31 00 00       	call   35f7 <write>
     4c6:	83 c4 10             	add    $0x10,%esp
     4c9:	83 f8 0a             	cmp    $0xa,%eax
     4cc:	0f 85 d5 00 00 00    	jne    5a7 <writetest+0x13f>
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit();
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     4d2:	50                   	push   %eax
     4d3:	6a 0a                	push   $0xa
     4d5:	68 57 3b 00 00       	push   $0x3b57
     4da:	56                   	push   %esi
     4db:	e8 17 31 00 00       	call   35f7 <write>
     4e0:	83 c4 10             	add    $0x10,%esp
     4e3:	83 f8 0a             	cmp    $0xa,%eax
     4e6:	0f 85 d2 00 00 00    	jne    5be <writetest+0x156>
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     4ec:	43                   	inc    %ebx
     4ed:	83 fb 64             	cmp    $0x64,%ebx
     4f0:	75 c6                	jne    4b8 <writetest+0x50>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit();
    }
  }
  printf(stdout, "writes ok\n");
     4f2:	83 ec 08             	sub    $0x8,%esp
     4f5:	68 62 3b 00 00       	push   $0x3b62
     4fa:	ff 35 58 5a 00 00    	pushl  0x5a58
     500:	e8 f3 31 00 00       	call   36f8 <printf>
  close(fd);
     505:	89 34 24             	mov    %esi,(%esp)
     508:	e8 f2 30 00 00       	call   35ff <close>
  fd = open("small", O_RDONLY);
     50d:	58                   	pop    %eax
     50e:	5a                   	pop    %edx
     50f:	6a 00                	push   $0x0
     511:	68 0f 3b 00 00       	push   $0x3b0f
     516:	e8 fc 30 00 00       	call   3617 <open>
     51b:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     51d:	83 c4 10             	add    $0x10,%esp
     520:	85 c0                	test   %eax,%eax
     522:	0f 88 ad 00 00 00    	js     5d5 <writetest+0x16d>
    printf(stdout, "open small succeeded ok\n");
     528:	83 ec 08             	sub    $0x8,%esp
     52b:	68 6d 3b 00 00       	push   $0x3b6d
     530:	ff 35 58 5a 00 00    	pushl  0x5a58
     536:	e8 bd 31 00 00       	call   36f8 <printf>
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
     53b:	83 c4 0c             	add    $0xc,%esp
     53e:	68 d0 07 00 00       	push   $0x7d0
     543:	68 40 82 00 00       	push   $0x8240
     548:	53                   	push   %ebx
     549:	e8 a1 30 00 00       	call   35ef <read>
  if(i == 2000){
     54e:	83 c4 10             	add    $0x10,%esp
     551:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     556:	0f 85 91 00 00 00    	jne    5ed <writetest+0x185>
    printf(stdout, "read succeeded ok\n");
     55c:	83 ec 08             	sub    $0x8,%esp
     55f:	68 a1 3b 00 00       	push   $0x3ba1
     564:	ff 35 58 5a 00 00    	pushl  0x5a58
     56a:	e8 89 31 00 00       	call   36f8 <printf>
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
     56f:	89 1c 24             	mov    %ebx,(%esp)
     572:	e8 88 30 00 00       	call   35ff <close>

  if(unlink("small") < 0){
     577:	c7 04 24 0f 3b 00 00 	movl   $0x3b0f,(%esp)
     57e:	e8 a4 30 00 00       	call   3627 <unlink>
     583:	83 c4 10             	add    $0x10,%esp
     586:	85 c0                	test   %eax,%eax
     588:	78 7b                	js     605 <writetest+0x19d>
    printf(stdout, "unlink small failed\n");
    exit();
  }
  printf(stdout, "small file test ok\n");
     58a:	83 ec 08             	sub    $0x8,%esp
     58d:	68 c9 3b 00 00       	push   $0x3bc9
     592:	ff 35 58 5a 00 00    	pushl  0x5a58
     598:	e8 5b 31 00 00       	call   36f8 <printf>
     59d:	83 c4 10             	add    $0x10,%esp
}
     5a0:	8d 65 f8             	lea    -0x8(%ebp),%esp
     5a3:	5b                   	pop    %ebx
     5a4:	5e                   	pop    %esi
     5a5:	5d                   	pop    %ebp
     5a6:	c3                   	ret    
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
      printf(stdout, "error: write aa %d new file failed\n", i);
     5a7:	50                   	push   %eax
     5a8:	53                   	push   %ebx
     5a9:	68 10 4a 00 00       	push   $0x4a10
     5ae:	ff 35 58 5a 00 00    	pushl  0x5a58
     5b4:	e8 3f 31 00 00       	call   36f8 <printf>
      exit();
     5b9:	e8 19 30 00 00       	call   35d7 <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
     5be:	51                   	push   %ecx
     5bf:	53                   	push   %ebx
     5c0:	68 34 4a 00 00       	push   $0x4a34
     5c5:	ff 35 58 5a 00 00    	pushl  0x5a58
     5cb:	e8 28 31 00 00       	call   36f8 <printf>
      exit();
     5d0:	e8 02 30 00 00       	call   35d7 <exit>
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open small succeeded ok\n");
  } else {
    printf(stdout, "error: open small failed!\n");
     5d5:	83 ec 08             	sub    $0x8,%esp
     5d8:	68 86 3b 00 00       	push   $0x3b86
     5dd:	ff 35 58 5a 00 00    	pushl  0x5a58
     5e3:	e8 10 31 00 00       	call   36f8 <printf>
    exit();
     5e8:	e8 ea 2f 00 00       	call   35d7 <exit>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf(stdout, "read succeeded ok\n");
  } else {
    printf(stdout, "read failed\n");
     5ed:	83 ec 08             	sub    $0x8,%esp
     5f0:	68 cd 3e 00 00       	push   $0x3ecd
     5f5:	ff 35 58 5a 00 00    	pushl  0x5a58
     5fb:	e8 f8 30 00 00       	call   36f8 <printf>
    exit();
     600:	e8 d2 2f 00 00       	call   35d7 <exit>
  }
  close(fd);

  if(unlink("small") < 0){
    printf(stdout, "unlink small failed\n");
     605:	83 ec 08             	sub    $0x8,%esp
     608:	68 b4 3b 00 00       	push   $0x3bb4
     60d:	ff 35 58 5a 00 00    	pushl  0x5a58
     613:	e8 e0 30 00 00       	call   36f8 <printf>
    exit();
     618:	e8 ba 2f 00 00       	call   35d7 <exit>
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
     61d:	83 ec 08             	sub    $0x8,%esp
     620:	68 30 3b 00 00       	push   $0x3b30
     625:	ff 35 58 5a 00 00    	pushl  0x5a58
     62b:	e8 c8 30 00 00       	call   36f8 <printf>
    exit();
     630:	e8 a2 2f 00 00       	call   35d7 <exit>
     635:	8d 76 00             	lea    0x0(%esi),%esi

00000638 <writetest1>:
  printf(stdout, "small file test ok\n");
}

void
writetest1(void)
{
     638:	55                   	push   %ebp
     639:	89 e5                	mov    %esp,%ebp
     63b:	56                   	push   %esi
     63c:	53                   	push   %ebx
  int i, fd, n;

  printf(stdout, "big files test\n");
     63d:	83 ec 08             	sub    $0x8,%esp
     640:	68 dd 3b 00 00       	push   $0x3bdd
     645:	ff 35 58 5a 00 00    	pushl  0x5a58
     64b:	e8 a8 30 00 00       	call   36f8 <printf>

  fd = open("big", O_CREATE|O_RDWR);
     650:	58                   	pop    %eax
     651:	5a                   	pop    %edx
     652:	68 02 02 00 00       	push   $0x202
     657:	68 57 3c 00 00       	push   $0x3c57
     65c:	e8 b6 2f 00 00       	call   3617 <open>
     661:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     663:	83 c4 10             	add    $0x10,%esp
     666:	85 c0                	test   %eax,%eax
     668:	0f 88 48 01 00 00    	js     7b6 <writetest1+0x17e>
     66e:	31 db                	xor    %ebx,%ebx
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
     670:	89 1d 40 82 00 00    	mov    %ebx,0x8240
    if(write(fd, buf, 512) != 512){
     676:	50                   	push   %eax
     677:	68 00 02 00 00       	push   $0x200
     67c:	68 40 82 00 00       	push   $0x8240
     681:	56                   	push   %esi
     682:	e8 70 2f 00 00       	call   35f7 <write>
     687:	83 c4 10             	add    $0x10,%esp
     68a:	3d 00 02 00 00       	cmp    $0x200,%eax
     68f:	0f 85 a9 00 00 00    	jne    73e <writetest1+0x106>
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
     695:	43                   	inc    %ebx
     696:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     69c:	75 d2                	jne    670 <writetest1+0x38>
      printf(stdout, "error: write big file failed\n", i);
      exit();
    }
  }

  close(fd);
     69e:	83 ec 0c             	sub    $0xc,%esp
     6a1:	56                   	push   %esi
     6a2:	e8 58 2f 00 00       	call   35ff <close>

  fd = open("big", O_RDONLY);
     6a7:	58                   	pop    %eax
     6a8:	5a                   	pop    %edx
     6a9:	6a 00                	push   $0x0
     6ab:	68 57 3c 00 00       	push   $0x3c57
     6b0:	e8 62 2f 00 00       	call   3617 <open>
     6b5:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     6b7:	83 c4 10             	add    $0x10,%esp
     6ba:	85 c0                	test   %eax,%eax
     6bc:	0f 88 dc 00 00 00    	js     79e <writetest1+0x166>
     6c2:	31 db                	xor    %ebx,%ebx
     6c4:	eb 17                	jmp    6dd <writetest1+0xa5>
     6c6:	66 90                	xchg   %ax,%ax
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512){
     6c8:	3d 00 02 00 00       	cmp    $0x200,%eax
     6cd:	0f 85 99 00 00 00    	jne    76c <writetest1+0x134>
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n){
     6d3:	a1 40 82 00 00       	mov    0x8240,%eax
     6d8:	39 d8                	cmp    %ebx,%eax
     6da:	75 79                	jne    755 <writetest1+0x11d>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
     6dc:	43                   	inc    %ebx
    exit();
  }

  n = 0;
  for(;;){
    i = read(fd, buf, 512);
     6dd:	50                   	push   %eax
     6de:	68 00 02 00 00       	push   $0x200
     6e3:	68 40 82 00 00       	push   $0x8240
     6e8:	56                   	push   %esi
     6e9:	e8 01 2f 00 00       	call   35ef <read>
    if(i == 0){
     6ee:	83 c4 10             	add    $0x10,%esp
     6f1:	85 c0                	test   %eax,%eax
     6f3:	75 d3                	jne    6c8 <writetest1+0x90>
      if(n == MAXFILE - 1){
     6f5:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     6fb:	0f 84 82 00 00 00    	je     783 <writetest1+0x14b>
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
  }
  close(fd);
     701:	83 ec 0c             	sub    $0xc,%esp
     704:	56                   	push   %esi
     705:	e8 f5 2e 00 00       	call   35ff <close>
  if(unlink("big") < 0){
     70a:	c7 04 24 57 3c 00 00 	movl   $0x3c57,(%esp)
     711:	e8 11 2f 00 00       	call   3627 <unlink>
     716:	83 c4 10             	add    $0x10,%esp
     719:	85 c0                	test   %eax,%eax
     71b:	0f 88 ad 00 00 00    	js     7ce <writetest1+0x196>
    printf(stdout, "unlink big failed\n");
    exit();
  }
  printf(stdout, "big files ok\n");
     721:	83 ec 08             	sub    $0x8,%esp
     724:	68 7e 3c 00 00       	push   $0x3c7e
     729:	ff 35 58 5a 00 00    	pushl  0x5a58
     72f:	e8 c4 2f 00 00       	call   36f8 <printf>
     734:	83 c4 10             	add    $0x10,%esp
}
     737:	8d 65 f8             	lea    -0x8(%ebp),%esp
     73a:	5b                   	pop    %ebx
     73b:	5e                   	pop    %esi
     73c:	5d                   	pop    %ebp
     73d:	c3                   	ret    
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
    if(write(fd, buf, 512) != 512){
      printf(stdout, "error: write big file failed\n", i);
     73e:	51                   	push   %ecx
     73f:	53                   	push   %ebx
     740:	68 07 3c 00 00       	push   $0x3c07
     745:	ff 35 58 5a 00 00    	pushl  0x5a58
     74b:	e8 a8 2f 00 00       	call   36f8 <printf>
      exit();
     750:	e8 82 2e 00 00       	call   35d7 <exit>
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n){
      printf(stdout, "read content of block %d is %d\n",
     755:	50                   	push   %eax
     756:	53                   	push   %ebx
     757:	68 58 4a 00 00       	push   $0x4a58
     75c:	ff 35 58 5a 00 00    	pushl  0x5a58
     762:	e8 91 2f 00 00       	call   36f8 <printf>
             n, ((int*)buf)[0]);
      exit();
     767:	e8 6b 2e 00 00       	call   35d7 <exit>
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
     76c:	52                   	push   %edx
     76d:	50                   	push   %eax
     76e:	68 5b 3c 00 00       	push   $0x3c5b
     773:	ff 35 58 5a 00 00    	pushl  0x5a58
     779:	e8 7a 2f 00 00       	call   36f8 <printf>
      exit();
     77e:	e8 54 2e 00 00       	call   35d7 <exit>
  n = 0;
  for(;;){
    i = read(fd, buf, 512);
    if(i == 0){
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
     783:	51                   	push   %ecx
     784:	68 8b 00 00 00       	push   $0x8b
     789:	68 3e 3c 00 00       	push   $0x3c3e
     78e:	ff 35 58 5a 00 00    	pushl  0x5a58
     794:	e8 5f 2f 00 00       	call   36f8 <printf>
        exit();
     799:	e8 39 2e 00 00       	call   35d7 <exit>

  close(fd);

  fd = open("big", O_RDONLY);
  if(fd < 0){
    printf(stdout, "error: open big failed!\n");
     79e:	83 ec 08             	sub    $0x8,%esp
     7a1:	68 25 3c 00 00       	push   $0x3c25
     7a6:	ff 35 58 5a 00 00    	pushl  0x5a58
     7ac:	e8 47 2f 00 00       	call   36f8 <printf>
    exit();
     7b1:	e8 21 2e 00 00       	call   35d7 <exit>

  printf(stdout, "big files test\n");

  fd = open("big", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
     7b6:	83 ec 08             	sub    $0x8,%esp
     7b9:	68 ed 3b 00 00       	push   $0x3bed
     7be:	ff 35 58 5a 00 00    	pushl  0x5a58
     7c4:	e8 2f 2f 00 00       	call   36f8 <printf>
    exit();
     7c9:	e8 09 2e 00 00       	call   35d7 <exit>
    }
    n++;
  }
  close(fd);
  if(unlink("big") < 0){
    printf(stdout, "unlink big failed\n");
     7ce:	83 ec 08             	sub    $0x8,%esp
     7d1:	68 6b 3c 00 00       	push   $0x3c6b
     7d6:	ff 35 58 5a 00 00    	pushl  0x5a58
     7dc:	e8 17 2f 00 00       	call   36f8 <printf>
    exit();
     7e1:	e8 f1 2d 00 00       	call   35d7 <exit>
     7e6:	66 90                	xchg   %ax,%ax

000007e8 <createtest>:
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
     7e8:	55                   	push   %ebp
     7e9:	89 e5                	mov    %esp,%ebp
     7eb:	53                   	push   %ebx
     7ec:	83 ec 0c             	sub    $0xc,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     7ef:	68 78 4a 00 00       	push   $0x4a78
     7f4:	ff 35 58 5a 00 00    	pushl  0x5a58
     7fa:	e8 f9 2e 00 00       	call   36f8 <printf>

  name[0] = 'a';
     7ff:	c6 05 40 a2 00 00 61 	movb   $0x61,0xa240
  name[2] = '\0';
     806:	c6 05 42 a2 00 00 00 	movb   $0x0,0xa242
     80d:	83 c4 10             	add    $0x10,%esp
     810:	b3 30                	mov    $0x30,%bl
     812:	66 90                	xchg   %ax,%ax
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
     814:	88 1d 41 a2 00 00    	mov    %bl,0xa241
    fd = open(name, O_CREATE|O_RDWR);
     81a:	83 ec 08             	sub    $0x8,%esp
     81d:	68 02 02 00 00       	push   $0x202
     822:	68 40 a2 00 00       	push   $0xa240
     827:	e8 eb 2d 00 00       	call   3617 <open>
    close(fd);
     82c:	89 04 24             	mov    %eax,(%esp)
     82f:	e8 cb 2d 00 00       	call   35ff <close>
     834:	43                   	inc    %ebx

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     835:	83 c4 10             	add    $0x10,%esp
     838:	80 fb 64             	cmp    $0x64,%bl
     83b:	75 d7                	jne    814 <createtest+0x2c>
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
     83d:	c6 05 40 a2 00 00 61 	movb   $0x61,0xa240
  name[2] = '\0';
     844:	c6 05 42 a2 00 00 00 	movb   $0x0,0xa242
     84b:	b3 30                	mov    $0x30,%bl
     84d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
     850:	88 1d 41 a2 00 00    	mov    %bl,0xa241
    unlink(name);
     856:	83 ec 0c             	sub    $0xc,%esp
     859:	68 40 a2 00 00       	push   $0xa240
     85e:	e8 c4 2d 00 00       	call   3627 <unlink>
     863:	43                   	inc    %ebx
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     864:	83 c4 10             	add    $0x10,%esp
     867:	80 fb 64             	cmp    $0x64,%bl
     86a:	75 e4                	jne    850 <createtest+0x68>
    name[1] = '0' + i;
    unlink(name);
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     86c:	83 ec 08             	sub    $0x8,%esp
     86f:	68 a0 4a 00 00       	push   $0x4aa0
     874:	ff 35 58 5a 00 00    	pushl  0x5a58
     87a:	e8 79 2e 00 00       	call   36f8 <printf>
     87f:	83 c4 10             	add    $0x10,%esp
}
     882:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     885:	c9                   	leave  
     886:	c3                   	ret    
     887:	90                   	nop

00000888 <dirtest>:

void dirtest(void)
{
     888:	55                   	push   %ebp
     889:	89 e5                	mov    %esp,%ebp
     88b:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "mkdir test\n");
     88e:	68 8c 3c 00 00       	push   $0x3c8c
     893:	ff 35 58 5a 00 00    	pushl  0x5a58
     899:	e8 5a 2e 00 00       	call   36f8 <printf>

  if(mkdir("dir0") < 0){
     89e:	c7 04 24 98 3c 00 00 	movl   $0x3c98,(%esp)
     8a5:	e8 95 2d 00 00       	call   363f <mkdir>
     8aa:	83 c4 10             	add    $0x10,%esp
     8ad:	85 c0                	test   %eax,%eax
     8af:	78 58                	js     909 <dirtest+0x81>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0){
     8b1:	83 ec 0c             	sub    $0xc,%esp
     8b4:	68 98 3c 00 00       	push   $0x3c98
     8b9:	e8 89 2d 00 00       	call   3647 <chdir>
     8be:	83 c4 10             	add    $0x10,%esp
     8c1:	85 c0                	test   %eax,%eax
     8c3:	0f 88 85 00 00 00    	js     94e <dirtest+0xc6>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0){
     8c9:	83 ec 0c             	sub    $0xc,%esp
     8cc:	68 3d 42 00 00       	push   $0x423d
     8d1:	e8 71 2d 00 00       	call   3647 <chdir>
     8d6:	83 c4 10             	add    $0x10,%esp
     8d9:	85 c0                	test   %eax,%eax
     8db:	78 5a                	js     937 <dirtest+0xaf>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0){
     8dd:	83 ec 0c             	sub    $0xc,%esp
     8e0:	68 98 3c 00 00       	push   $0x3c98
     8e5:	e8 3d 2d 00 00       	call   3627 <unlink>
     8ea:	83 c4 10             	add    $0x10,%esp
     8ed:	85 c0                	test   %eax,%eax
     8ef:	78 2f                	js     920 <dirtest+0x98>
    printf(stdout, "unlink dir0 failed\n");
    exit();
  }
  printf(stdout, "mkdir test ok\n");
     8f1:	83 ec 08             	sub    $0x8,%esp
     8f4:	68 d5 3c 00 00       	push   $0x3cd5
     8f9:	ff 35 58 5a 00 00    	pushl  0x5a58
     8ff:	e8 f4 2d 00 00       	call   36f8 <printf>
     904:	83 c4 10             	add    $0x10,%esp
}
     907:	c9                   	leave  
     908:	c3                   	ret    
void dirtest(void)
{
  printf(stdout, "mkdir test\n");

  if(mkdir("dir0") < 0){
    printf(stdout, "mkdir failed\n");
     909:	50                   	push   %eax
     90a:	50                   	push   %eax
     90b:	68 c8 39 00 00       	push   $0x39c8
     910:	ff 35 58 5a 00 00    	pushl  0x5a58
     916:	e8 dd 2d 00 00       	call   36f8 <printf>
    exit();
     91b:	e8 b7 2c 00 00       	call   35d7 <exit>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0){
    printf(stdout, "unlink dir0 failed\n");
     920:	50                   	push   %eax
     921:	50                   	push   %eax
     922:	68 c1 3c 00 00       	push   $0x3cc1
     927:	ff 35 58 5a 00 00    	pushl  0x5a58
     92d:	e8 c6 2d 00 00       	call   36f8 <printf>
    exit();
     932:	e8 a0 2c 00 00       	call   35d7 <exit>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0){
    printf(stdout, "chdir .. failed\n");
     937:	52                   	push   %edx
     938:	52                   	push   %edx
     939:	68 b0 3c 00 00       	push   $0x3cb0
     93e:	ff 35 58 5a 00 00    	pushl  0x5a58
     944:	e8 af 2d 00 00       	call   36f8 <printf>
    exit();
     949:	e8 89 2c 00 00       	call   35d7 <exit>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0){
    printf(stdout, "chdir dir0 failed\n");
     94e:	51                   	push   %ecx
     94f:	51                   	push   %ecx
     950:	68 9d 3c 00 00       	push   $0x3c9d
     955:	ff 35 58 5a 00 00    	pushl  0x5a58
     95b:	e8 98 2d 00 00       	call   36f8 <printf>
    exit();
     960:	e8 72 2c 00 00       	call   35d7 <exit>
     965:	8d 76 00             	lea    0x0(%esi),%esi

00000968 <exectest>:
  printf(stdout, "mkdir test ok\n");
}

void
exectest(void)
{
     968:	55                   	push   %ebp
     969:	89 e5                	mov    %esp,%ebp
     96b:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exec test\n");
     96e:	68 e4 3c 00 00       	push   $0x3ce4
     973:	ff 35 58 5a 00 00    	pushl  0x5a58
     979:	e8 7a 2d 00 00       	call   36f8 <printf>
  if(exec("echo", echoargv) < 0){
     97e:	5a                   	pop    %edx
     97f:	59                   	pop    %ecx
     980:	68 5c 5a 00 00       	push   $0x5a5c
     985:	68 ad 3a 00 00       	push   $0x3aad
     98a:	e8 80 2c 00 00       	call   360f <exec>
     98f:	83 c4 10             	add    $0x10,%esp
     992:	85 c0                	test   %eax,%eax
     994:	78 02                	js     998 <exectest+0x30>
    printf(stdout, "exec echo failed\n");
    exit();
  }
}
     996:	c9                   	leave  
     997:	c3                   	ret    
void
exectest(void)
{
  printf(stdout, "exec test\n");
  if(exec("echo", echoargv) < 0){
    printf(stdout, "exec echo failed\n");
     998:	50                   	push   %eax
     999:	50                   	push   %eax
     99a:	68 ef 3c 00 00       	push   $0x3cef
     99f:	ff 35 58 5a 00 00    	pushl  0x5a58
     9a5:	e8 4e 2d 00 00       	call   36f8 <printf>
    exit();
     9aa:	e8 28 2c 00 00       	call   35d7 <exit>
     9af:	90                   	nop

000009b0 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     9b0:	55                   	push   %ebp
     9b1:	89 e5                	mov    %esp,%ebp
     9b3:	57                   	push   %edi
     9b4:	56                   	push   %esi
     9b5:	53                   	push   %ebx
     9b6:	83 ec 38             	sub    $0x38,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     9b9:	8d 45 e0             	lea    -0x20(%ebp),%eax
     9bc:	50                   	push   %eax
     9bd:	e8 25 2c 00 00       	call   35e7 <pipe>
     9c2:	83 c4 10             	add    $0x10,%esp
     9c5:	85 c0                	test   %eax,%eax
     9c7:	0f 85 33 01 00 00    	jne    b00 <pipe1+0x150>
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
     9cd:	e8 fd 2b 00 00       	call   35cf <fork>
  seq = 0;
  if(pid == 0){
     9d2:	83 f8 00             	cmp    $0x0,%eax
     9d5:	0f 84 8b 00 00 00    	je     a66 <pipe1+0xb6>
        printf(1, "pipe1 oops 1\n");
        exit();
      }
    }
    exit();
  } else if(pid > 0){
     9db:	0f 8e 33 01 00 00    	jle    b14 <pipe1+0x164>
    close(fds[1]);
     9e1:	83 ec 0c             	sub    $0xc,%esp
     9e4:	ff 75 e4             	pushl  -0x1c(%ebp)
     9e7:	e8 13 2c 00 00       	call   35ff <close>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
     9ec:	83 c4 10             	add    $0x10,%esp
      }
    }
    exit();
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
     9ef:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    cc = 1;
     9f6:	bf 01 00 00 00       	mov    $0x1,%edi
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
  seq = 0;
     9fb:	31 db                	xor    %ebx,%ebx
    exit();
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
     9fd:	56                   	push   %esi
     9fe:	57                   	push   %edi
     9ff:	68 40 82 00 00       	push   $0x8240
     a04:	ff 75 e0             	pushl  -0x20(%ebp)
     a07:	e8 e3 2b 00 00       	call   35ef <read>
     a0c:	83 c4 10             	add    $0x10,%esp
     a0f:	85 c0                	test   %eax,%eax
     a11:	0f 8e a5 00 00 00    	jle    abc <pipe1+0x10c>
     a17:	8d 34 18             	lea    (%eax,%ebx,1),%esi
     a1a:	89 d9                	mov    %ebx,%ecx
     a1c:	f7 d9                	neg    %ecx
     a1e:	66 90                	xchg   %ax,%ax
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     a20:	8d 53 01             	lea    0x1(%ebx),%edx
     a23:	38 9c 0b 40 82 00 00 	cmp    %bl,0x8240(%ebx,%ecx,1)
     a2a:	75 17                	jne    a43 <pipe1+0x93>
     a2c:	89 d3                	mov    %edx,%ebx
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
     a2e:	39 f2                	cmp    %esi,%edx
     a30:	75 ee                	jne    a20 <pipe1+0x70>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
     a32:	01 45 d4             	add    %eax,-0x2c(%ebp)
     a35:	01 ff                	add    %edi,%edi
     a37:	81 ff 00 20 00 00    	cmp    $0x2000,%edi
     a3d:	7f 1e                	jg     a5d <pipe1+0xad>
     a3f:	89 f3                	mov    %esi,%ebx
     a41:	eb ba                	jmp    9fd <pipe1+0x4d>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
     a43:	83 ec 08             	sub    $0x8,%esp
     a46:	68 1e 3d 00 00       	push   $0x3d1e
     a4b:	6a 01                	push   $0x1
     a4d:	e8 a6 2c 00 00       	call   36f8 <printf>
          return;
     a52:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
}
     a55:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a58:	5b                   	pop    %ebx
     a59:	5e                   	pop    %esi
     a5a:	5f                   	pop    %edi
     a5b:	5d                   	pop    %ebp
     a5c:	c3                   	ret    
     a5d:	bf 00 20 00 00       	mov    $0x2000,%edi
     a62:	89 f3                	mov    %esi,%ebx
     a64:	eb 97                	jmp    9fd <pipe1+0x4d>
    exit();
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
     a66:	83 ec 0c             	sub    $0xc,%esp
     a69:	ff 75 e0             	pushl  -0x20(%ebp)
     a6c:	e8 8e 2b 00 00       	call   35ff <close>
     a71:	83 c4 10             	add    $0x10,%esp
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
  seq = 0;
     a74:	31 f6                	xor    %esi,%esi
     a76:	8d 96 09 04 00 00    	lea    0x409(%esi),%edx

// simple fork and pipe read/write

void
pipe1(void)
{
     a7c:	89 f3                	mov    %esi,%ebx
     a7e:	89 f0                	mov    %esi,%eax
     a80:	f7 d8                	neg    %eax
     a82:	66 90                	xchg   %ax,%ax
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
     a84:	88 9c 18 40 82 00 00 	mov    %bl,0x8240(%eax,%ebx,1)
     a8b:	43                   	inc    %ebx
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
     a8c:	39 d3                	cmp    %edx,%ebx
     a8e:	75 f4                	jne    a84 <pipe1+0xd4>
     a90:	89 de                	mov    %ebx,%esi
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
     a92:	57                   	push   %edi
     a93:	68 09 04 00 00       	push   $0x409
     a98:	68 40 82 00 00       	push   $0x8240
     a9d:	ff 75 e4             	pushl  -0x1c(%ebp)
     aa0:	e8 52 2b 00 00       	call   35f7 <write>
     aa5:	83 c4 10             	add    $0x10,%esp
     aa8:	3d 09 04 00 00       	cmp    $0x409,%eax
     aad:	75 79                	jne    b28 <pipe1+0x178>
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
     aaf:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     ab5:	75 bf                	jne    a76 <pipe1+0xc6>
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
        exit();
      }
    }
    exit();
     ab7:	e8 1b 2b 00 00       	call   35d7 <exit>
      total += n;
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
     abc:	81 7d d4 2d 14 00 00 	cmpl   $0x142d,-0x2c(%ebp)
     ac3:	75 26                	jne    aeb <pipe1+0x13b>
      printf(1, "pipe1 oops 3 total %d\n", total);
      exit();
    }
    close(fds[0]);
     ac5:	83 ec 0c             	sub    $0xc,%esp
     ac8:	ff 75 e0             	pushl  -0x20(%ebp)
     acb:	e8 2f 2b 00 00       	call   35ff <close>
    wait();
     ad0:	e8 0a 2b 00 00       	call   35df <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
     ad5:	58                   	pop    %eax
     ad6:	5a                   	pop    %edx
     ad7:	68 43 3d 00 00       	push   $0x3d43
     adc:	6a 01                	push   $0x1
     ade:	e8 15 2c 00 00       	call   36f8 <printf>
     ae3:	83 c4 10             	add    $0x10,%esp
     ae6:	e9 6a ff ff ff       	jmp    a55 <pipe1+0xa5>
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
      printf(1, "pipe1 oops 3 total %d\n", total);
     aeb:	51                   	push   %ecx
     aec:	ff 75 d4             	pushl  -0x2c(%ebp)
     aef:	68 2c 3d 00 00       	push   $0x3d2c
     af4:	6a 01                	push   $0x1
     af6:	e8 fd 2b 00 00       	call   36f8 <printf>
      exit();
     afb:	e8 d7 2a 00 00       	call   35d7 <exit>
{
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
     b00:	83 ec 08             	sub    $0x8,%esp
     b03:	68 01 3d 00 00       	push   $0x3d01
     b08:	6a 01                	push   $0x1
     b0a:	e8 e9 2b 00 00       	call   36f8 <printf>
    exit();
     b0f:	e8 c3 2a 00 00       	call   35d7 <exit>
      exit();
    }
    close(fds[0]);
    wait();
  } else {
    printf(1, "fork() failed\n");
     b14:	83 ec 08             	sub    $0x8,%esp
     b17:	68 4d 3d 00 00       	push   $0x3d4d
     b1c:	6a 01                	push   $0x1
     b1e:	e8 d5 2b 00 00       	call   36f8 <printf>
    exit();
     b23:	e8 af 2a 00 00       	call   35d7 <exit>
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
     b28:	83 ec 08             	sub    $0x8,%esp
     b2b:	68 10 3d 00 00       	push   $0x3d10
     b30:	6a 01                	push   $0x1
     b32:	e8 c1 2b 00 00       	call   36f8 <printf>
        exit();
     b37:	e8 9b 2a 00 00       	call   35d7 <exit>

00000b3c <preempt>:
}

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     b3c:	55                   	push   %ebp
     b3d:	89 e5                	mov    %esp,%ebp
     b3f:	57                   	push   %edi
     b40:	56                   	push   %esi
     b41:	53                   	push   %ebx
     b42:	83 ec 24             	sub    $0x24,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     b45:	68 5c 3d 00 00       	push   $0x3d5c
     b4a:	6a 01                	push   $0x1
     b4c:	e8 a7 2b 00 00       	call   36f8 <printf>
  pid1 = fork();
     b51:	e8 79 2a 00 00       	call   35cf <fork>
     b56:	89 c7                	mov    %eax,%edi
  if(pid1 == 0)
     b58:	83 c4 10             	add    $0x10,%esp
     b5b:	85 c0                	test   %eax,%eax
     b5d:	75 02                	jne    b61 <preempt+0x25>
    for(;;)
      ;
     b5f:	eb fe                	jmp    b5f <preempt+0x23>

  pid2 = fork();
     b61:	e8 69 2a 00 00       	call   35cf <fork>
     b66:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     b68:	85 c0                	test   %eax,%eax
     b6a:	75 02                	jne    b6e <preempt+0x32>
    for(;;)
      ;
     b6c:	eb fe                	jmp    b6c <preempt+0x30>

  pipe(pfds);
     b6e:	83 ec 0c             	sub    $0xc,%esp
     b71:	8d 45 e0             	lea    -0x20(%ebp),%eax
     b74:	50                   	push   %eax
     b75:	e8 6d 2a 00 00       	call   35e7 <pipe>
  pid3 = fork();
     b7a:	e8 50 2a 00 00       	call   35cf <fork>
     b7f:	89 c3                	mov    %eax,%ebx
  if(pid3 == 0){
     b81:	83 c4 10             	add    $0x10,%esp
     b84:	85 c0                	test   %eax,%eax
     b86:	75 45                	jne    bcd <preempt+0x91>
    close(pfds[0]);
     b88:	83 ec 0c             	sub    $0xc,%esp
     b8b:	ff 75 e0             	pushl  -0x20(%ebp)
     b8e:	e8 6c 2a 00 00       	call   35ff <close>
    if(write(pfds[1], "x", 1) != 1)
     b93:	83 c4 0c             	add    $0xc,%esp
     b96:	6a 01                	push   $0x1
     b98:	68 21 43 00 00       	push   $0x4321
     b9d:	ff 75 e4             	pushl  -0x1c(%ebp)
     ba0:	e8 52 2a 00 00       	call   35f7 <write>
     ba5:	83 c4 10             	add    $0x10,%esp
     ba8:	48                   	dec    %eax
     ba9:	74 12                	je     bbd <preempt+0x81>
      printf(1, "preempt write error");
     bab:	83 ec 08             	sub    $0x8,%esp
     bae:	68 66 3d 00 00       	push   $0x3d66
     bb3:	6a 01                	push   $0x1
     bb5:	e8 3e 2b 00 00       	call   36f8 <printf>
     bba:	83 c4 10             	add    $0x10,%esp
    close(pfds[1]);
     bbd:	83 ec 0c             	sub    $0xc,%esp
     bc0:	ff 75 e4             	pushl  -0x1c(%ebp)
     bc3:	e8 37 2a 00 00       	call   35ff <close>
     bc8:	83 c4 10             	add    $0x10,%esp
    for(;;)
      ;
     bcb:	eb fe                	jmp    bcb <preempt+0x8f>
  }

  close(pfds[1]);
     bcd:	83 ec 0c             	sub    $0xc,%esp
     bd0:	ff 75 e4             	pushl  -0x1c(%ebp)
     bd3:	e8 27 2a 00 00       	call   35ff <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     bd8:	83 c4 0c             	add    $0xc,%esp
     bdb:	68 00 20 00 00       	push   $0x2000
     be0:	68 40 82 00 00       	push   $0x8240
     be5:	ff 75 e0             	pushl  -0x20(%ebp)
     be8:	e8 02 2a 00 00       	call   35ef <read>
     bed:	83 c4 10             	add    $0x10,%esp
     bf0:	48                   	dec    %eax
     bf1:	74 1a                	je     c0d <preempt+0xd1>
    printf(1, "preempt read error");
     bf3:	83 ec 08             	sub    $0x8,%esp
     bf6:	68 7a 3d 00 00       	push   $0x3d7a
     bfb:	6a 01                	push   $0x1
     bfd:	e8 f6 2a 00 00       	call   36f8 <printf>
    return;
     c02:	83 c4 10             	add    $0x10,%esp
  printf(1, "wait... ");
  wait();
  wait();
  wait();
  printf(1, "preempt ok\n");
}
     c05:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c08:	5b                   	pop    %ebx
     c09:	5e                   	pop    %esi
     c0a:	5f                   	pop    %edi
     c0b:	5d                   	pop    %ebp
     c0c:	c3                   	ret    
  close(pfds[1]);
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    printf(1, "preempt read error");
    return;
  }
  close(pfds[0]);
     c0d:	83 ec 0c             	sub    $0xc,%esp
     c10:	ff 75 e0             	pushl  -0x20(%ebp)
     c13:	e8 e7 29 00 00       	call   35ff <close>
  printf(1, "kill... ");
     c18:	58                   	pop    %eax
     c19:	5a                   	pop    %edx
     c1a:	68 8d 3d 00 00       	push   $0x3d8d
     c1f:	6a 01                	push   $0x1
     c21:	e8 d2 2a 00 00       	call   36f8 <printf>
  kill(pid1);
     c26:	89 3c 24             	mov    %edi,(%esp)
     c29:	e8 d9 29 00 00       	call   3607 <kill>
  kill(pid2);
     c2e:	89 34 24             	mov    %esi,(%esp)
     c31:	e8 d1 29 00 00       	call   3607 <kill>
  kill(pid3);
     c36:	89 1c 24             	mov    %ebx,(%esp)
     c39:	e8 c9 29 00 00       	call   3607 <kill>
  printf(1, "wait... ");
     c3e:	59                   	pop    %ecx
     c3f:	5b                   	pop    %ebx
     c40:	68 96 3d 00 00       	push   $0x3d96
     c45:	6a 01                	push   $0x1
     c47:	e8 ac 2a 00 00       	call   36f8 <printf>
  wait();
     c4c:	e8 8e 29 00 00       	call   35df <wait>
  wait();
     c51:	e8 89 29 00 00       	call   35df <wait>
  wait();
     c56:	e8 84 29 00 00       	call   35df <wait>
  printf(1, "preempt ok\n");
     c5b:	5e                   	pop    %esi
     c5c:	5f                   	pop    %edi
     c5d:	68 9f 3d 00 00       	push   $0x3d9f
     c62:	6a 01                	push   $0x1
     c64:	e8 8f 2a 00 00       	call   36f8 <printf>
     c69:	83 c4 10             	add    $0x10,%esp
     c6c:	eb 97                	jmp    c05 <preempt+0xc9>
     c6e:	66 90                	xchg   %ax,%ax

00000c70 <exitwait>:
}

// try to find any races between exit and wait
void
exitwait(void)
{
     c70:	55                   	push   %ebp
     c71:	89 e5                	mov    %esp,%ebp
     c73:	56                   	push   %esi
     c74:	53                   	push   %ebx
     c75:	be 64 00 00 00       	mov    $0x64,%esi
     c7a:	eb 0e                	jmp    c8a <exitwait+0x1a>
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
     c7c:	74 67                	je     ce5 <exitwait+0x75>
      if(wait() != pid){
     c7e:	e8 5c 29 00 00       	call   35df <wait>
     c83:	39 d8                	cmp    %ebx,%eax
     c85:	75 29                	jne    cb0 <exitwait+0x40>
void
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
     c87:	4e                   	dec    %esi
     c88:	74 42                	je     ccc <exitwait+0x5c>
    pid = fork();
     c8a:	e8 40 29 00 00       	call   35cf <fork>
     c8f:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     c91:	85 c0                	test   %eax,%eax
     c93:	79 e7                	jns    c7c <exitwait+0xc>
      printf(1, "fork failed\n");
     c95:	83 ec 08             	sub    $0x8,%esp
     c98:	68 09 49 00 00       	push   $0x4909
     c9d:	6a 01                	push   $0x1
     c9f:	e8 54 2a 00 00       	call   36f8 <printf>
      return;
     ca4:	83 c4 10             	add    $0x10,%esp
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
     ca7:	8d 65 f8             	lea    -0x8(%ebp),%esp
     caa:	5b                   	pop    %ebx
     cab:	5e                   	pop    %esi
     cac:	5d                   	pop    %ebp
     cad:	c3                   	ret    
     cae:	66 90                	xchg   %ax,%ax
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
      if(wait() != pid){
        printf(1, "wait wrong pid\n");
     cb0:	83 ec 08             	sub    $0x8,%esp
     cb3:	68 ab 3d 00 00       	push   $0x3dab
     cb8:	6a 01                	push   $0x1
     cba:	e8 39 2a 00 00       	call   36f8 <printf>
        return;
     cbf:	83 c4 10             	add    $0x10,%esp
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
     cc2:	8d 65 f8             	lea    -0x8(%ebp),%esp
     cc5:	5b                   	pop    %ebx
     cc6:	5e                   	pop    %esi
     cc7:	5d                   	pop    %ebp
     cc8:	c3                   	ret    
     cc9:	8d 76 00             	lea    0x0(%esi),%esi
      }
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
     ccc:	83 ec 08             	sub    $0x8,%esp
     ccf:	68 bb 3d 00 00       	push   $0x3dbb
     cd4:	6a 01                	push   $0x1
     cd6:	e8 1d 2a 00 00       	call   36f8 <printf>
     cdb:	83 c4 10             	add    $0x10,%esp
}
     cde:	8d 65 f8             	lea    -0x8(%ebp),%esp
     ce1:	5b                   	pop    %ebx
     ce2:	5e                   	pop    %esi
     ce3:	5d                   	pop    %ebp
     ce4:	c3                   	ret    
      if(wait() != pid){
        printf(1, "wait wrong pid\n");
        return;
      }
    } else {
      exit();
     ce5:	e8 ed 28 00 00       	call   35d7 <exit>
     cea:	66 90                	xchg   %ax,%ax

00000cec <mem>:
  printf(1, "exitwait ok\n");
}

void
mem(void)
{
     cec:	55                   	push   %ebp
     ced:	89 e5                	mov    %esp,%ebp
     cef:	56                   	push   %esi
     cf0:	53                   	push   %ebx
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
     cf1:	83 ec 08             	sub    $0x8,%esp
     cf4:	68 c8 3d 00 00       	push   $0x3dc8
     cf9:	6a 01                	push   $0x1
     cfb:	e8 f8 29 00 00       	call   36f8 <printf>
  ppid = getpid();
     d00:	e8 52 29 00 00       	call   3657 <getpid>
     d05:	89 c6                	mov    %eax,%esi
  if((pid = fork()) == 0){
     d07:	e8 c3 28 00 00       	call   35cf <fork>
     d0c:	83 c4 10             	add    $0x10,%esp
     d0f:	85 c0                	test   %eax,%eax
     d11:	75 69                	jne    d7c <mem+0x90>
     d13:	31 db                	xor    %ebx,%ebx
     d15:	eb 05                	jmp    d1c <mem+0x30>
     d17:	90                   	nop
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
     d18:	89 18                	mov    %ebx,(%eax)
     d1a:	89 c3                	mov    %eax,%ebx

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
     d1c:	83 ec 0c             	sub    $0xc,%esp
     d1f:	68 11 27 00 00       	push   $0x2711
     d24:	e8 bb 2b 00 00       	call   38e4 <malloc>
     d29:	83 c4 10             	add    $0x10,%esp
     d2c:	85 c0                	test   %eax,%eax
     d2e:	75 e8                	jne    d18 <mem+0x2c>
     d30:	89 da                	mov    %ebx,%edx
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     d32:	85 db                	test   %ebx,%ebx
     d34:	74 16                	je     d4c <mem+0x60>
     d36:	66 90                	xchg   %ax,%ax
      m2 = *(char**)m1;
     d38:	8b 1a                	mov    (%edx),%ebx
      free(m1);
     d3a:	83 ec 0c             	sub    $0xc,%esp
     d3d:	52                   	push   %edx
     d3e:	e8 21 2b 00 00       	call   3864 <free>
     d43:	89 da                	mov    %ebx,%edx
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     d45:	83 c4 10             	add    $0x10,%esp
     d48:	85 db                	test   %ebx,%ebx
     d4a:	75 ec                	jne    d38 <mem+0x4c>
      m2 = *(char**)m1;
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
     d4c:	83 ec 0c             	sub    $0xc,%esp
     d4f:	68 00 50 00 00       	push   $0x5000
     d54:	e8 8b 2b 00 00       	call   38e4 <malloc>
    if(m1 == 0){
     d59:	83 c4 10             	add    $0x10,%esp
     d5c:	85 c0                	test   %eax,%eax
     d5e:	74 28                	je     d88 <mem+0x9c>
      printf(1, "couldn't allocate mem?!!\n");
      kill(ppid);
      exit();
    }
    free(m1);
     d60:	83 ec 0c             	sub    $0xc,%esp
     d63:	50                   	push   %eax
     d64:	e8 fb 2a 00 00       	call   3864 <free>
    printf(1, "mem ok\n");
     d69:	58                   	pop    %eax
     d6a:	5a                   	pop    %edx
     d6b:	68 ec 3d 00 00       	push   $0x3dec
     d70:	6a 01                	push   $0x1
     d72:	e8 81 29 00 00       	call   36f8 <printf>
    exit();
     d77:	e8 5b 28 00 00       	call   35d7 <exit>
  } else {
    wait();
  }
}
     d7c:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d7f:	5b                   	pop    %ebx
     d80:	5e                   	pop    %esi
     d81:	5d                   	pop    %ebp
    }
    free(m1);
    printf(1, "mem ok\n");
    exit();
  } else {
    wait();
     d82:	e9 58 28 00 00       	jmp    35df <wait>
     d87:	90                   	nop
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
    if(m1 == 0){
      printf(1, "couldn't allocate mem?!!\n");
     d88:	83 ec 08             	sub    $0x8,%esp
     d8b:	68 d2 3d 00 00       	push   $0x3dd2
     d90:	6a 01                	push   $0x1
     d92:	e8 61 29 00 00       	call   36f8 <printf>
      kill(ppid);
     d97:	89 34 24             	mov    %esi,(%esp)
     d9a:	e8 68 28 00 00       	call   3607 <kill>
      exit();
     d9f:	e8 33 28 00 00       	call   35d7 <exit>

00000da4 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
     da4:	55                   	push   %ebp
     da5:	89 e5                	mov    %esp,%ebp
     da7:	57                   	push   %edi
     da8:	56                   	push   %esi
     da9:	53                   	push   %ebx
     daa:	83 ec 34             	sub    $0x34,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
     dad:	68 f4 3d 00 00       	push   $0x3df4
     db2:	6a 01                	push   $0x1
     db4:	e8 3f 29 00 00       	call   36f8 <printf>

  unlink("sharedfd");
     db9:	c7 04 24 03 3e 00 00 	movl   $0x3e03,(%esp)
     dc0:	e8 62 28 00 00       	call   3627 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     dc5:	59                   	pop    %ecx
     dc6:	5b                   	pop    %ebx
     dc7:	68 02 02 00 00       	push   $0x202
     dcc:	68 03 3e 00 00       	push   $0x3e03
     dd1:	e8 41 28 00 00       	call   3617 <open>
     dd6:	89 c7                	mov    %eax,%edi
  if(fd < 0){
     dd8:	83 c4 10             	add    $0x10,%esp
     ddb:	85 c0                	test   %eax,%eax
     ddd:	0f 88 15 01 00 00    	js     ef8 <sharedfd+0x154>
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
     de3:	e8 e7 27 00 00       	call   35cf <fork>
     de8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     deb:	83 f8 01             	cmp    $0x1,%eax
     dee:	19 c0                	sbb    %eax,%eax
     df0:	83 e0 f3             	and    $0xfffffff3,%eax
     df3:	83 c0 70             	add    $0x70,%eax
     df6:	52                   	push   %edx
     df7:	6a 0a                	push   $0xa
     df9:	50                   	push   %eax
     dfa:	8d 75 de             	lea    -0x22(%ebp),%esi
     dfd:	56                   	push   %esi
     dfe:	e8 a1 26 00 00       	call   34a4 <memset>
     e03:	83 c4 10             	add    $0x10,%esp
     e06:	bb e8 03 00 00       	mov    $0x3e8,%ebx
     e0b:	eb 06                	jmp    e13 <sharedfd+0x6f>
     e0d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 1000; i++){
     e10:	4b                   	dec    %ebx
     e11:	74 24                	je     e37 <sharedfd+0x93>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     e13:	50                   	push   %eax
     e14:	6a 0a                	push   $0xa
     e16:	56                   	push   %esi
     e17:	57                   	push   %edi
     e18:	e8 da 27 00 00       	call   35f7 <write>
     e1d:	83 c4 10             	add    $0x10,%esp
     e20:	83 f8 0a             	cmp    $0xa,%eax
     e23:	74 eb                	je     e10 <sharedfd+0x6c>
      printf(1, "fstests: write sharedfd failed\n");
     e25:	83 ec 08             	sub    $0x8,%esp
     e28:	68 f4 4a 00 00       	push   $0x4af4
     e2d:	6a 01                	push   $0x1
     e2f:	e8 c4 28 00 00       	call   36f8 <printf>
      break;
     e34:	83 c4 10             	add    $0x10,%esp
    }
  }
  if(pid == 0)
     e37:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
     e3a:	85 db                	test   %ebx,%ebx
     e3c:	0f 84 ea 00 00 00    	je     f2c <sharedfd+0x188>
    exit();
  else
    wait();
     e42:	e8 98 27 00 00       	call   35df <wait>
  close(fd);
     e47:	83 ec 0c             	sub    $0xc,%esp
     e4a:	57                   	push   %edi
     e4b:	e8 af 27 00 00       	call   35ff <close>
  fd = open("sharedfd", 0);
     e50:	5a                   	pop    %edx
     e51:	59                   	pop    %ecx
     e52:	6a 00                	push   $0x0
     e54:	68 03 3e 00 00       	push   $0x3e03
     e59:	e8 b9 27 00 00       	call   3617 <open>
     e5e:	89 45 d0             	mov    %eax,-0x30(%ebp)
  if(fd < 0){
     e61:	83 c4 10             	add    $0x10,%esp
     e64:	85 c0                	test   %eax,%eax
     e66:	0f 88 a6 00 00 00    	js     f12 <sharedfd+0x16e>
     e6c:	31 ff                	xor    %edi,%edi
     e6e:	8d 5d e8             	lea    -0x18(%ebp),%ebx
     e71:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
     e74:	50                   	push   %eax
     e75:	6a 0a                	push   $0xa
     e77:	56                   	push   %esi
     e78:	ff 75 d0             	pushl  -0x30(%ebp)
     e7b:	e8 6f 27 00 00       	call   35ef <read>
     e80:	83 c4 10             	add    $0x10,%esp
     e83:	85 c0                	test   %eax,%eax
     e85:	7e 24                	jle    eab <sharedfd+0x107>
     e87:	89 f1                	mov    %esi,%ecx
     e89:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     e8c:	eb 0c                	jmp    e9a <sharedfd+0xf6>
     e8e:	66 90                	xchg   %ax,%ax
    for(i = 0; i < sizeof(buf); i++){
      if(buf[i] == 'c')
        nc++;
      if(buf[i] == 'p')
     e90:	3c 70                	cmp    $0x70,%al
     e92:	75 01                	jne    e95 <sharedfd+0xf1>
        np++;
     e94:	47                   	inc    %edi
     e95:	41                   	inc    %ecx
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
     e96:	39 d9                	cmp    %ebx,%ecx
     e98:	74 0c                	je     ea6 <sharedfd+0x102>
      if(buf[i] == 'c')
     e9a:	8a 01                	mov    (%ecx),%al
     e9c:	3c 63                	cmp    $0x63,%al
     e9e:	75 f0                	jne    e90 <sharedfd+0xec>
        nc++;
     ea0:	42                   	inc    %edx
     ea1:	41                   	inc    %ecx
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
     ea2:	39 d9                	cmp    %ebx,%ecx
     ea4:	75 f4                	jne    e9a <sharedfd+0xf6>
     ea6:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     ea9:	eb c9                	jmp    e74 <sharedfd+0xd0>
     eab:	89 7d cc             	mov    %edi,-0x34(%ebp)
     eae:	8b 7d d4             	mov    -0x2c(%ebp),%edi
        nc++;
      if(buf[i] == 'p')
        np++;
    }
  }
  close(fd);
     eb1:	83 ec 0c             	sub    $0xc,%esp
     eb4:	ff 75 d0             	pushl  -0x30(%ebp)
     eb7:	e8 43 27 00 00       	call   35ff <close>
  unlink("sharedfd");
     ebc:	c7 04 24 03 3e 00 00 	movl   $0x3e03,(%esp)
     ec3:	e8 5f 27 00 00       	call   3627 <unlink>
  if(nc == 10000 && np == 10000){
     ec8:	83 c4 10             	add    $0x10,%esp
     ecb:	81 ff 10 27 00 00    	cmp    $0x2710,%edi
     ed1:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ed4:	75 5b                	jne    f31 <sharedfd+0x18d>
     ed6:	81 fa 10 27 00 00    	cmp    $0x2710,%edx
     edc:	75 53                	jne    f31 <sharedfd+0x18d>
    printf(1, "sharedfd ok\n");
     ede:	83 ec 08             	sub    $0x8,%esp
     ee1:	68 0c 3e 00 00       	push   $0x3e0c
     ee6:	6a 01                	push   $0x1
     ee8:	e8 0b 28 00 00       	call   36f8 <printf>
     eed:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit();
  }
}
     ef0:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ef3:	5b                   	pop    %ebx
     ef4:	5e                   	pop    %esi
     ef5:	5f                   	pop    %edi
     ef6:	5d                   	pop    %ebp
     ef7:	c3                   	ret    
  printf(1, "sharedfd test\n");

  unlink("sharedfd");
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
     ef8:	83 ec 08             	sub    $0x8,%esp
     efb:	68 c8 4a 00 00       	push   $0x4ac8
     f00:	6a 01                	push   $0x1
     f02:	e8 f1 27 00 00       	call   36f8 <printf>
    return;
     f07:	83 c4 10             	add    $0x10,%esp
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit();
  }
}
     f0a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f0d:	5b                   	pop    %ebx
     f0e:	5e                   	pop    %esi
     f0f:	5f                   	pop    %edi
     f10:	5d                   	pop    %ebp
     f11:	c3                   	ret    
  else
    wait();
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
     f12:	83 ec 08             	sub    $0x8,%esp
     f15:	68 14 4b 00 00       	push   $0x4b14
     f1a:	6a 01                	push   $0x1
     f1c:	e8 d7 27 00 00       	call   36f8 <printf>
    return;
     f21:	83 c4 10             	add    $0x10,%esp
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit();
  }
}
     f24:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f27:	5b                   	pop    %ebx
     f28:	5e                   	pop    %esi
     f29:	5f                   	pop    %edi
     f2a:	5d                   	pop    %ebp
     f2b:	c3                   	ret    
      printf(1, "fstests: write sharedfd failed\n");
      break;
    }
  }
  if(pid == 0)
    exit();
     f2c:	e8 a6 26 00 00       	call   35d7 <exit>
  close(fd);
  unlink("sharedfd");
  if(nc == 10000 && np == 10000){
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
     f31:	52                   	push   %edx
     f32:	57                   	push   %edi
     f33:	68 19 3e 00 00       	push   $0x3e19
     f38:	6a 01                	push   $0x1
     f3a:	e8 b9 27 00 00       	call   36f8 <printf>
    exit();
     f3f:	e8 93 26 00 00       	call   35d7 <exit>

00000f44 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
     f44:	55                   	push   %ebp
     f45:	89 e5                	mov    %esp,%ebp
     f47:	57                   	push   %edi
     f48:	56                   	push   %esi
     f49:	53                   	push   %ebx
     f4a:	83 ec 34             	sub    $0x34,%esp
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
     f4d:	be 60 51 00 00       	mov    $0x5160,%esi
     f52:	b9 04 00 00 00       	mov    $0x4,%ecx
     f57:	8d 7d d8             	lea    -0x28(%ebp),%edi
     f5a:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  char *fname;

  printf(1, "fourfiles test\n");
     f5c:	68 2e 3e 00 00       	push   $0x3e2e
     f61:	6a 01                	push   $0x1
     f63:	e8 90 27 00 00       	call   36f8 <printf>
     f68:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
     f6b:	31 db                	xor    %ebx,%ebx
    fname = names[pi];
     f6d:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    unlink(fname);
     f71:	83 ec 0c             	sub    $0xc,%esp
     f74:	56                   	push   %esi
     f75:	e8 ad 26 00 00       	call   3627 <unlink>

    pid = fork();
     f7a:	e8 50 26 00 00       	call   35cf <fork>
    if(pid < 0){
     f7f:	83 c4 10             	add    $0x10,%esp
     f82:	85 c0                	test   %eax,%eax
     f84:	0f 88 65 01 00 00    	js     10ef <fourfiles+0x1ab>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
     f8a:	0f 84 cf 00 00 00    	je     105f <fourfiles+0x11b>
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");

  for(pi = 0; pi < 4; pi++){
     f90:	43                   	inc    %ebx
     f91:	83 fb 04             	cmp    $0x4,%ebx
     f94:	75 d7                	jne    f6d <fourfiles+0x29>
      exit();
    }
  }

  for(pi = 0; pi < 4; pi++){
    wait();
     f96:	e8 44 26 00 00       	call   35df <wait>
     f9b:	e8 3f 26 00 00       	call   35df <wait>
     fa0:	e8 3a 26 00 00       	call   35df <wait>
     fa5:	e8 35 26 00 00       	call   35df <wait>
     faa:	bf 30 00 00 00       	mov    $0x30,%edi
  }

  for(i = 0; i < 2; i++){
    fname = names[i];
     faf:	8b 84 bd 18 ff ff ff 	mov    -0xe8(%ebp,%edi,4),%eax
     fb6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    fd = open(fname, 0);
     fb9:	83 ec 08             	sub    $0x8,%esp
     fbc:	6a 00                	push   $0x0
     fbe:	50                   	push   %eax
     fbf:	e8 53 26 00 00       	call   3617 <open>
     fc4:	89 c3                	mov    %eax,%ebx
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
     fc6:	83 c4 10             	add    $0x10,%esp
  }

  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    total = 0;
     fc9:	31 f6                	xor    %esi,%esi
     fcb:	90                   	nop
    while((n = read(fd, buf, sizeof(buf))) > 0){
     fcc:	52                   	push   %edx
     fcd:	68 00 20 00 00       	push   $0x2000
     fd2:	68 40 82 00 00       	push   $0x8240
     fd7:	53                   	push   %ebx
     fd8:	e8 12 26 00 00       	call   35ef <read>
     fdd:	83 c4 10             	add    $0x10,%esp
     fe0:	85 c0                	test   %eax,%eax
     fe2:	7e 18                	jle    ffc <fourfiles+0xb8>
     fe4:	31 d2                	xor    %edx,%edx
     fe6:	66 90                	xchg   %ax,%ax
      for(j = 0; j < n; j++){
        if(buf[j] != '0'+i){
     fe8:	0f be 8a 40 82 00 00 	movsbl 0x8240(%edx),%ecx
     fef:	39 cf                	cmp    %ecx,%edi
     ff1:	75 58                	jne    104b <fourfiles+0x107>
  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
     ff3:	42                   	inc    %edx
     ff4:	39 c2                	cmp    %eax,%edx
     ff6:	75 f0                	jne    fe8 <fourfiles+0xa4>
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
          exit();
        }
      }
      total += n;
     ff8:	01 d6                	add    %edx,%esi
     ffa:	eb d0                	jmp    fcc <fourfiles+0x88>
    }
    close(fd);
     ffc:	83 ec 0c             	sub    $0xc,%esp
     fff:	53                   	push   %ebx
    1000:	e8 fa 25 00 00       	call   35ff <close>
    if(total != 12*500){
    1005:	83 c4 10             	add    $0x10,%esp
    1008:	81 fe 70 17 00 00    	cmp    $0x1770,%esi
    100e:	0f 85 c8 00 00 00    	jne    10dc <fourfiles+0x198>
      printf(1, "wrong length %d\n", total);
      exit();
    }
    unlink(fname);
    1014:	83 ec 0c             	sub    $0xc,%esp
    1017:	ff 75 d4             	pushl  -0x2c(%ebp)
    101a:	e8 08 26 00 00       	call   3627 <unlink>

  for(pi = 0; pi < 4; pi++){
    wait();
  }

  for(i = 0; i < 2; i++){
    101f:	83 c4 10             	add    $0x10,%esp
    1022:	83 ff 31             	cmp    $0x31,%edi
    1025:	75 1a                	jne    1041 <fourfiles+0xfd>
      exit();
    }
    unlink(fname);
  }

  printf(1, "fourfiles ok\n");
    1027:	83 ec 08             	sub    $0x8,%esp
    102a:	68 6c 3e 00 00       	push   $0x3e6c
    102f:	6a 01                	push   $0x1
    1031:	e8 c2 26 00 00       	call   36f8 <printf>
    1036:	83 c4 10             	add    $0x10,%esp
}
    1039:	8d 65 f4             	lea    -0xc(%ebp),%esp
    103c:	5b                   	pop    %ebx
    103d:	5e                   	pop    %esi
    103e:	5f                   	pop    %edi
    103f:	5d                   	pop    %ebp
    1040:	c3                   	ret    
    1041:	bf 31 00 00 00       	mov    $0x31,%edi
    1046:	e9 64 ff ff ff       	jmp    faf <fourfiles+0x6b>
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
    104b:	83 ec 08             	sub    $0x8,%esp
    104e:	68 4f 3e 00 00       	push   $0x3e4f
    1053:	6a 01                	push   $0x1
    1055:	e8 9e 26 00 00       	call   36f8 <printf>
          exit();
    105a:	e8 78 25 00 00       	call   35d7 <exit>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
    105f:	83 ec 08             	sub    $0x8,%esp
    1062:	68 02 02 00 00       	push   $0x202
    1067:	56                   	push   %esi
    1068:	e8 aa 25 00 00       	call   3617 <open>
    106d:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    106f:	83 c4 10             	add    $0x10,%esp
    1072:	85 c0                	test   %eax,%eax
    1074:	78 52                	js     10c8 <fourfiles+0x184>
        printf(1, "create failed\n");
        exit();
      }

      memset(buf, '0'+pi, 512);
    1076:	50                   	push   %eax
    1077:	68 00 02 00 00       	push   $0x200
    107c:	83 c3 30             	add    $0x30,%ebx
    107f:	53                   	push   %ebx
    1080:	68 40 82 00 00       	push   $0x8240
    1085:	e8 1a 24 00 00       	call   34a4 <memset>
    108a:	83 c4 10             	add    $0x10,%esp
    108d:	bb 0c 00 00 00       	mov    $0xc,%ebx
      for(i = 0; i < 12; i++){
        if((n = write(fd, buf, 500)) != 500){
    1092:	57                   	push   %edi
    1093:	68 f4 01 00 00       	push   $0x1f4
    1098:	68 40 82 00 00       	push   $0x8240
    109d:	56                   	push   %esi
    109e:	e8 54 25 00 00       	call   35f7 <write>
    10a3:	83 c4 10             	add    $0x10,%esp
    10a6:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    10ab:	75 08                	jne    10b5 <fourfiles+0x171>
        printf(1, "create failed\n");
        exit();
      }

      memset(buf, '0'+pi, 512);
      for(i = 0; i < 12; i++){
    10ad:	4b                   	dec    %ebx
    10ae:	75 e2                	jne    1092 <fourfiles+0x14e>
        if((n = write(fd, buf, 500)) != 500){
          printf(1, "write failed %d\n", n);
          exit();
        }
      }
      exit();
    10b0:	e8 22 25 00 00       	call   35d7 <exit>
      }

      memset(buf, '0'+pi, 512);
      for(i = 0; i < 12; i++){
        if((n = write(fd, buf, 500)) != 500){
          printf(1, "write failed %d\n", n);
    10b5:	51                   	push   %ecx
    10b6:	50                   	push   %eax
    10b7:	68 3e 3e 00 00       	push   $0x3e3e
    10bc:	6a 01                	push   $0x1
    10be:	e8 35 26 00 00       	call   36f8 <printf>
          exit();
    10c3:	e8 0f 25 00 00       	call   35d7 <exit>
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "create failed\n");
    10c8:	83 ec 08             	sub    $0x8,%esp
    10cb:	68 cf 40 00 00       	push   $0x40cf
    10d0:	6a 01                	push   $0x1
    10d2:	e8 21 26 00 00       	call   36f8 <printf>
        exit();
    10d7:	e8 fb 24 00 00       	call   35d7 <exit>
      }
      total += n;
    }
    close(fd);
    if(total != 12*500){
      printf(1, "wrong length %d\n", total);
    10dc:	50                   	push   %eax
    10dd:	56                   	push   %esi
    10de:	68 5b 3e 00 00       	push   $0x3e5b
    10e3:	6a 01                	push   $0x1
    10e5:	e8 0e 26 00 00       	call   36f8 <printf>
      exit();
    10ea:	e8 e8 24 00 00       	call   35d7 <exit>
    fname = names[pi];
    unlink(fname);

    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    10ef:	83 ec 08             	sub    $0x8,%esp
    10f2:	68 09 49 00 00       	push   $0x4909
    10f7:	6a 01                	push   $0x1
    10f9:	e8 fa 25 00 00       	call   36f8 <printf>
      exit();
    10fe:	e8 d4 24 00 00       	call   35d7 <exit>
    1103:	90                   	nop

00001104 <createdelete>:
}

// four processes create and delete different files in same directory
void
createdelete(void)
{
    1104:	55                   	push   %ebp
    1105:	89 e5                	mov    %esp,%ebp
    1107:	57                   	push   %edi
    1108:	56                   	push   %esi
    1109:	53                   	push   %ebx
    110a:	83 ec 44             	sub    $0x44,%esp
  enum { N = 20 };
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");
    110d:	68 80 3e 00 00       	push   $0x3e80
    1112:	6a 01                	push   $0x1
    1114:	e8 df 25 00 00       	call   36f8 <printf>
    1119:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    111c:	31 db                	xor    %ebx,%ebx
    pid = fork();
    111e:	e8 ac 24 00 00       	call   35cf <fork>
    if(pid < 0){
    1123:	85 c0                	test   %eax,%eax
    1125:	0f 88 6c 01 00 00    	js     1297 <createdelete+0x193>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
    112b:	0f 84 d3 00 00 00    	je     1204 <createdelete+0x100>
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    1131:	43                   	inc    %ebx
    1132:	83 fb 04             	cmp    $0x4,%ebx
    1135:	75 e7                	jne    111e <createdelete+0x1a>
      exit();
    }
  }

  for(pi = 0; pi < 4; pi++){
    wait();
    1137:	e8 a3 24 00 00       	call   35df <wait>
    113c:	e8 9e 24 00 00       	call   35df <wait>
    1141:	e8 99 24 00 00       	call   35df <wait>
    1146:	e8 94 24 00 00       	call   35df <wait>
  }

  name[0] = name[1] = name[2] = 0;
    114b:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
  for(i = 0; i < N; i++){
    114f:	31 f6                	xor    %esi,%esi
    1151:	8d 7d c8             	lea    -0x38(%ebp),%edi
    1154:	8d 46 30             	lea    0x30(%esi),%eax
    1157:	88 45 c7             	mov    %al,-0x39(%ebp)
      exit();
    }

    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
    115a:	b3 70                	mov    $0x70,%bl
    115c:	8d 46 ff             	lea    -0x1(%esi),%eax
    115f:	89 45 c0             	mov    %eax,-0x40(%ebp)
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
    1162:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[1] = '0' + i;
    1165:	8a 45 c7             	mov    -0x39(%ebp),%al
    1168:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    116b:	83 ec 08             	sub    $0x8,%esp
    116e:	6a 00                	push   $0x0
    1170:	57                   	push   %edi
    1171:	e8 a1 24 00 00       	call   3617 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    1176:	83 c4 10             	add    $0x10,%esp
    1179:	85 f6                	test   %esi,%esi
    117b:	74 05                	je     1182 <createdelete+0x7e>
    117d:	83 fe 09             	cmp    $0x9,%esi
    1180:	7e 6a                	jle    11ec <createdelete+0xe8>
    1182:	85 c0                	test   %eax,%eax
    1184:	0f 88 fa 00 00 00    	js     1284 <createdelete+0x180>
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit();
      } else if((i >= 1 && i < N/2) && fd >= 0){
    118a:	83 7d c0 08          	cmpl   $0x8,-0x40(%ebp)
    118e:	76 60                	jbe    11f0 <createdelete+0xec>
        printf(1, "oops createdelete %s did exist\n", name);
        exit();
      }
      if(fd >= 0)
        close(fd);
    1190:	83 ec 0c             	sub    $0xc,%esp
    1193:	50                   	push   %eax
    1194:	e8 66 24 00 00       	call   35ff <close>
    1199:	83 c4 10             	add    $0x10,%esp
    119c:	43                   	inc    %ebx
    wait();
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    119d:	80 fb 74             	cmp    $0x74,%bl
    11a0:	75 c0                	jne    1162 <createdelete+0x5e>
  for(pi = 0; pi < 4; pi++){
    wait();
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    11a2:	46                   	inc    %esi
    11a3:	83 fe 14             	cmp    $0x14,%esi
    11a6:	75 ac                	jne    1154 <createdelete+0x50>
    11a8:	b3 70                	mov    $0x70,%bl
    11aa:	66 90                	xchg   %ax,%ax
    11ac:	8d 43 c0             	lea    -0x40(%ebx),%eax
    11af:	88 45 c7             	mov    %al,-0x39(%ebp)
    11b2:	be 04 00 00 00       	mov    $0x4,%esi
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + i;
    11b7:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[1] = '0' + i;
    11ba:	8a 45 c7             	mov    -0x39(%ebp),%al
    11bd:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    11c0:	83 ec 0c             	sub    $0xc,%esp
    11c3:	57                   	push   %edi
    11c4:	e8 5e 24 00 00       	call   3627 <unlink>
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    11c9:	83 c4 10             	add    $0x10,%esp
    11cc:	4e                   	dec    %esi
    11cd:	75 e8                	jne    11b7 <createdelete+0xb3>
    11cf:	43                   	inc    %ebx
      if(fd >= 0)
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    11d0:	80 fb 84             	cmp    $0x84,%bl
    11d3:	75 d7                	jne    11ac <createdelete+0xa8>
      name[1] = '0' + i;
      unlink(name);
    }
  }

  printf(1, "createdelete ok\n");
    11d5:	83 ec 08             	sub    $0x8,%esp
    11d8:	68 93 3e 00 00       	push   $0x3e93
    11dd:	6a 01                	push   $0x1
    11df:	e8 14 25 00 00       	call   36f8 <printf>
}
    11e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11e7:	5b                   	pop    %ebx
    11e8:	5e                   	pop    %esi
    11e9:	5f                   	pop    %edi
    11ea:	5d                   	pop    %ebp
    11eb:	c3                   	ret    
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit();
      } else if((i >= 1 && i < N/2) && fd >= 0){
    11ec:	85 c0                	test   %eax,%eax
    11ee:	78 ac                	js     119c <createdelete+0x98>
        printf(1, "oops createdelete %s did exist\n", name);
    11f0:	50                   	push   %eax
    11f1:	57                   	push   %edi
    11f2:	68 64 4b 00 00       	push   $0x4b64
    11f7:	6a 01                	push   $0x1
    11f9:	e8 fa 24 00 00       	call   36f8 <printf>
        exit();
    11fe:	e8 d4 23 00 00       	call   35d7 <exit>
    1203:	90                   	nop
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
      name[0] = 'p' + pi;
    1204:	83 c3 70             	add    $0x70,%ebx
    1207:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[2] = '\0';
    120a:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    120e:	be 01 00 00 00       	mov    $0x1,%esi
    1213:	31 db                	xor    %ebx,%ebx
    1215:	8d 7d c8             	lea    -0x38(%ebp),%edi
    1218:	8d 43 30             	lea    0x30(%ebx),%eax
    121b:	88 45 c9             	mov    %al,-0x37(%ebp)
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
        fd = open(name, O_CREATE | O_RDWR);
    121e:	83 ec 08             	sub    $0x8,%esp
    1221:	68 02 02 00 00       	push   $0x202
    1226:	57                   	push   %edi
    1227:	e8 eb 23 00 00       	call   3617 <open>
        if(fd < 0){
    122c:	83 c4 10             	add    $0x10,%esp
    122f:	85 c0                	test   %eax,%eax
    1231:	78 78                	js     12ab <createdelete+0x1a7>
          printf(1, "create failed\n");
          exit();
        }
        close(fd);
    1233:	83 ec 0c             	sub    $0xc,%esp
    1236:	50                   	push   %eax
    1237:	e8 c3 23 00 00       	call   35ff <close>
        if(i > 0 && (i % 2 ) == 0){
    123c:	83 c4 10             	add    $0x10,%esp
    123f:	85 db                	test   %ebx,%ebx
    1241:	74 0a                	je     124d <createdelete+0x149>
    1243:	f6 c3 01             	test   $0x1,%bl
    1246:	74 0e                	je     1256 <createdelete+0x152>
    }

    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
      for(i = 0; i < N; i++){
    1248:	83 fe 14             	cmp    $0x14,%esi
    124b:	74 04                	je     1251 <createdelete+0x14d>
    124d:	43                   	inc    %ebx
    124e:	46                   	inc    %esi
    124f:	eb c7                	jmp    1218 <createdelete+0x114>
            printf(1, "unlink failed\n");
            exit();
          }
        }
      }
      exit();
    1251:	e8 81 23 00 00       	call   35d7 <exit>
          printf(1, "create failed\n");
          exit();
        }
        close(fd);
        if(i > 0 && (i % 2 ) == 0){
          name[1] = '0' + (i / 2);
    1256:	89 d8                	mov    %ebx,%eax
    1258:	d1 f8                	sar    %eax
    125a:	83 c0 30             	add    $0x30,%eax
    125d:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    1260:	83 ec 0c             	sub    $0xc,%esp
    1263:	57                   	push   %edi
    1264:	e8 be 23 00 00       	call   3627 <unlink>
    1269:	83 c4 10             	add    $0x10,%esp
    126c:	85 c0                	test   %eax,%eax
    126e:	79 d8                	jns    1248 <createdelete+0x144>
            printf(1, "unlink failed\n");
    1270:	83 ec 08             	sub    $0x8,%esp
    1273:	68 81 3a 00 00       	push   $0x3a81
    1278:	6a 01                	push   $0x1
    127a:	e8 79 24 00 00       	call   36f8 <printf>
            exit();
    127f:	e8 53 23 00 00       	call   35d7 <exit>
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
    1284:	52                   	push   %edx
    1285:	57                   	push   %edi
    1286:	68 40 4b 00 00       	push   $0x4b40
    128b:	6a 01                	push   $0x1
    128d:	e8 66 24 00 00       	call   36f8 <printf>
        exit();
    1292:	e8 40 23 00 00       	call   35d7 <exit>
  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    1297:	83 ec 08             	sub    $0x8,%esp
    129a:	68 09 49 00 00       	push   $0x4909
    129f:	6a 01                	push   $0x1
    12a1:	e8 52 24 00 00       	call   36f8 <printf>
      exit();
    12a6:	e8 2c 23 00 00       	call   35d7 <exit>
      name[2] = '\0';
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
        fd = open(name, O_CREATE | O_RDWR);
        if(fd < 0){
          printf(1, "create failed\n");
    12ab:	83 ec 08             	sub    $0x8,%esp
    12ae:	68 cf 40 00 00       	push   $0x40cf
    12b3:	6a 01                	push   $0x1
    12b5:	e8 3e 24 00 00       	call   36f8 <printf>
          exit();
    12ba:	e8 18 23 00 00       	call   35d7 <exit>
    12bf:	90                   	nop

000012c0 <unlinkread>:
}

// can I unlink a file and still read it?
void
unlinkread(void)
{
    12c0:	55                   	push   %ebp
    12c1:	89 e5                	mov    %esp,%ebp
    12c3:	56                   	push   %esi
    12c4:	53                   	push   %ebx
  int fd, fd1;

  printf(1, "unlinkread test\n");
    12c5:	83 ec 08             	sub    $0x8,%esp
    12c8:	68 a4 3e 00 00       	push   $0x3ea4
    12cd:	6a 01                	push   $0x1
    12cf:	e8 24 24 00 00       	call   36f8 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    12d4:	5b                   	pop    %ebx
    12d5:	5e                   	pop    %esi
    12d6:	68 02 02 00 00       	push   $0x202
    12db:	68 b5 3e 00 00       	push   $0x3eb5
    12e0:	e8 32 23 00 00       	call   3617 <open>
    12e5:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    12e7:	83 c4 10             	add    $0x10,%esp
    12ea:	85 c0                	test   %eax,%eax
    12ec:	0f 88 e0 00 00 00    	js     13d2 <unlinkread+0x112>
    printf(1, "create unlinkread failed\n");
    exit();
  }
  write(fd, "hello", 5);
    12f2:	50                   	push   %eax
    12f3:	6a 05                	push   $0x5
    12f5:	68 da 3e 00 00       	push   $0x3eda
    12fa:	53                   	push   %ebx
    12fb:	e8 f7 22 00 00       	call   35f7 <write>
  close(fd);
    1300:	89 1c 24             	mov    %ebx,(%esp)
    1303:	e8 f7 22 00 00       	call   35ff <close>

  fd = open("unlinkread", O_RDWR);
    1308:	58                   	pop    %eax
    1309:	5a                   	pop    %edx
    130a:	6a 02                	push   $0x2
    130c:	68 b5 3e 00 00       	push   $0x3eb5
    1311:	e8 01 23 00 00       	call   3617 <open>
    1316:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1318:	83 c4 10             	add    $0x10,%esp
    131b:	85 c0                	test   %eax,%eax
    131d:	0f 88 0e 01 00 00    	js     1431 <unlinkread+0x171>
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    1323:	83 ec 0c             	sub    $0xc,%esp
    1326:	68 b5 3e 00 00       	push   $0x3eb5
    132b:	e8 f7 22 00 00       	call   3627 <unlink>
    1330:	83 c4 10             	add    $0x10,%esp
    1333:	85 c0                	test   %eax,%eax
    1335:	0f 85 e3 00 00 00    	jne    141e <unlinkread+0x15e>
    printf(1, "unlink unlinkread failed\n");
    exit();
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    133b:	83 ec 08             	sub    $0x8,%esp
    133e:	68 02 02 00 00       	push   $0x202
    1343:	68 b5 3e 00 00       	push   $0x3eb5
    1348:	e8 ca 22 00 00       	call   3617 <open>
    134d:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    134f:	83 c4 0c             	add    $0xc,%esp
    1352:	6a 03                	push   $0x3
    1354:	68 12 3f 00 00       	push   $0x3f12
    1359:	50                   	push   %eax
    135a:	e8 98 22 00 00       	call   35f7 <write>
  close(fd1);
    135f:	89 34 24             	mov    %esi,(%esp)
    1362:	e8 98 22 00 00       	call   35ff <close>

  if(read(fd, buf, sizeof(buf)) != 5){
    1367:	83 c4 0c             	add    $0xc,%esp
    136a:	68 00 20 00 00       	push   $0x2000
    136f:	68 40 82 00 00       	push   $0x8240
    1374:	53                   	push   %ebx
    1375:	e8 75 22 00 00       	call   35ef <read>
    137a:	83 c4 10             	add    $0x10,%esp
    137d:	83 f8 05             	cmp    $0x5,%eax
    1380:	0f 85 85 00 00 00    	jne    140b <unlinkread+0x14b>
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    1386:	80 3d 40 82 00 00 68 	cmpb   $0x68,0x8240
    138d:	75 69                	jne    13f8 <unlinkread+0x138>
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    138f:	56                   	push   %esi
    1390:	6a 0a                	push   $0xa
    1392:	68 40 82 00 00       	push   $0x8240
    1397:	53                   	push   %ebx
    1398:	e8 5a 22 00 00       	call   35f7 <write>
    139d:	83 c4 10             	add    $0x10,%esp
    13a0:	83 f8 0a             	cmp    $0xa,%eax
    13a3:	75 40                	jne    13e5 <unlinkread+0x125>
    printf(1, "unlinkread write failed\n");
    exit();
  }
  close(fd);
    13a5:	83 ec 0c             	sub    $0xc,%esp
    13a8:	53                   	push   %ebx
    13a9:	e8 51 22 00 00       	call   35ff <close>
  unlink("unlinkread");
    13ae:	c7 04 24 b5 3e 00 00 	movl   $0x3eb5,(%esp)
    13b5:	e8 6d 22 00 00       	call   3627 <unlink>
  printf(1, "unlinkread ok\n");
    13ba:	58                   	pop    %eax
    13bb:	5a                   	pop    %edx
    13bc:	68 5d 3f 00 00       	push   $0x3f5d
    13c1:	6a 01                	push   $0x1
    13c3:	e8 30 23 00 00       	call   36f8 <printf>
    13c8:	83 c4 10             	add    $0x10,%esp
}
    13cb:	8d 65 f8             	lea    -0x8(%ebp),%esp
    13ce:	5b                   	pop    %ebx
    13cf:	5e                   	pop    %esi
    13d0:	5d                   	pop    %ebp
    13d1:	c3                   	ret    
  int fd, fd1;

  printf(1, "unlinkread test\n");
  fd = open("unlinkread", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create unlinkread failed\n");
    13d2:	51                   	push   %ecx
    13d3:	51                   	push   %ecx
    13d4:	68 c0 3e 00 00       	push   $0x3ec0
    13d9:	6a 01                	push   $0x1
    13db:	e8 18 23 00 00       	call   36f8 <printf>
    exit();
    13e0:	e8 f2 21 00 00       	call   35d7 <exit>
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    printf(1, "unlinkread write failed\n");
    13e5:	51                   	push   %ecx
    13e6:	51                   	push   %ecx
    13e7:	68 44 3f 00 00       	push   $0x3f44
    13ec:	6a 01                	push   $0x1
    13ee:	e8 05 23 00 00       	call   36f8 <printf>
    exit();
    13f3:	e8 df 21 00 00       	call   35d7 <exit>
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    13f8:	50                   	push   %eax
    13f9:	50                   	push   %eax
    13fa:	68 2d 3f 00 00       	push   $0x3f2d
    13ff:	6a 01                	push   $0x1
    1401:	e8 f2 22 00 00       	call   36f8 <printf>
    exit();
    1406:	e8 cc 21 00 00       	call   35d7 <exit>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
  write(fd1, "yyy", 3);
  close(fd1);

  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    140b:	50                   	push   %eax
    140c:	50                   	push   %eax
    140d:	68 16 3f 00 00       	push   $0x3f16
    1412:	6a 01                	push   $0x1
    1414:	e8 df 22 00 00       	call   36f8 <printf>
    exit();
    1419:	e8 b9 21 00 00       	call   35d7 <exit>
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    141e:	50                   	push   %eax
    141f:	50                   	push   %eax
    1420:	68 f8 3e 00 00       	push   $0x3ef8
    1425:	6a 01                	push   $0x1
    1427:	e8 cc 22 00 00       	call   36f8 <printf>
    exit();
    142c:	e8 a6 21 00 00       	call   35d7 <exit>
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    1431:	50                   	push   %eax
    1432:	50                   	push   %eax
    1433:	68 e0 3e 00 00       	push   $0x3ee0
    1438:	6a 01                	push   $0x1
    143a:	e8 b9 22 00 00       	call   36f8 <printf>
    exit();
    143f:	e8 93 21 00 00       	call   35d7 <exit>

00001444 <linktest>:
  printf(1, "unlinkread ok\n");
}

void
linktest(void)
{
    1444:	55                   	push   %ebp
    1445:	89 e5                	mov    %esp,%ebp
    1447:	53                   	push   %ebx
    1448:	83 ec 0c             	sub    $0xc,%esp
  int fd;

  printf(1, "linktest\n");
    144b:	68 6c 3f 00 00       	push   $0x3f6c
    1450:	6a 01                	push   $0x1
    1452:	e8 a1 22 00 00       	call   36f8 <printf>

  unlink("lf1");
    1457:	c7 04 24 76 3f 00 00 	movl   $0x3f76,(%esp)
    145e:	e8 c4 21 00 00       	call   3627 <unlink>
  unlink("lf2");
    1463:	c7 04 24 7a 3f 00 00 	movl   $0x3f7a,(%esp)
    146a:	e8 b8 21 00 00       	call   3627 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    146f:	58                   	pop    %eax
    1470:	5a                   	pop    %edx
    1471:	68 02 02 00 00       	push   $0x202
    1476:	68 76 3f 00 00       	push   $0x3f76
    147b:	e8 97 21 00 00       	call   3617 <open>
    1480:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1482:	83 c4 10             	add    $0x10,%esp
    1485:	85 c0                	test   %eax,%eax
    1487:	0f 88 18 01 00 00    	js     15a5 <linktest+0x161>
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    148d:	50                   	push   %eax
    148e:	6a 05                	push   $0x5
    1490:	68 da 3e 00 00       	push   $0x3eda
    1495:	53                   	push   %ebx
    1496:	e8 5c 21 00 00       	call   35f7 <write>
    149b:	83 c4 10             	add    $0x10,%esp
    149e:	83 f8 05             	cmp    $0x5,%eax
    14a1:	0f 85 96 01 00 00    	jne    163d <linktest+0x1f9>
    printf(1, "write lf1 failed\n");
    exit();
  }
  close(fd);
    14a7:	83 ec 0c             	sub    $0xc,%esp
    14aa:	53                   	push   %ebx
    14ab:	e8 4f 21 00 00       	call   35ff <close>

  if(link("lf1", "lf2") < 0){
    14b0:	5b                   	pop    %ebx
    14b1:	58                   	pop    %eax
    14b2:	68 7a 3f 00 00       	push   $0x3f7a
    14b7:	68 76 3f 00 00       	push   $0x3f76
    14bc:	e8 76 21 00 00       	call   3637 <link>
    14c1:	83 c4 10             	add    $0x10,%esp
    14c4:	85 c0                	test   %eax,%eax
    14c6:	0f 88 5e 01 00 00    	js     162a <linktest+0x1e6>
    printf(1, "link lf1 lf2 failed\n");
    exit();
  }
  unlink("lf1");
    14cc:	83 ec 0c             	sub    $0xc,%esp
    14cf:	68 76 3f 00 00       	push   $0x3f76
    14d4:	e8 4e 21 00 00       	call   3627 <unlink>

  if(open("lf1", 0) >= 0){
    14d9:	58                   	pop    %eax
    14da:	5a                   	pop    %edx
    14db:	6a 00                	push   $0x0
    14dd:	68 76 3f 00 00       	push   $0x3f76
    14e2:	e8 30 21 00 00       	call   3617 <open>
    14e7:	83 c4 10             	add    $0x10,%esp
    14ea:	85 c0                	test   %eax,%eax
    14ec:	0f 89 25 01 00 00    	jns    1617 <linktest+0x1d3>
    printf(1, "unlinked lf1 but it is still there!\n");
    exit();
  }

  fd = open("lf2", 0);
    14f2:	83 ec 08             	sub    $0x8,%esp
    14f5:	6a 00                	push   $0x0
    14f7:	68 7a 3f 00 00       	push   $0x3f7a
    14fc:	e8 16 21 00 00       	call   3617 <open>
    1501:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1503:	83 c4 10             	add    $0x10,%esp
    1506:	85 c0                	test   %eax,%eax
    1508:	0f 88 f6 00 00 00    	js     1604 <linktest+0x1c0>
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    150e:	50                   	push   %eax
    150f:	68 00 20 00 00       	push   $0x2000
    1514:	68 40 82 00 00       	push   $0x8240
    1519:	53                   	push   %ebx
    151a:	e8 d0 20 00 00       	call   35ef <read>
    151f:	83 c4 10             	add    $0x10,%esp
    1522:	83 f8 05             	cmp    $0x5,%eax
    1525:	0f 85 c6 00 00 00    	jne    15f1 <linktest+0x1ad>
    printf(1, "read lf2 failed\n");
    exit();
  }
  close(fd);
    152b:	83 ec 0c             	sub    $0xc,%esp
    152e:	53                   	push   %ebx
    152f:	e8 cb 20 00 00       	call   35ff <close>

  if(link("lf2", "lf2") >= 0){
    1534:	58                   	pop    %eax
    1535:	5a                   	pop    %edx
    1536:	68 7a 3f 00 00       	push   $0x3f7a
    153b:	68 7a 3f 00 00       	push   $0x3f7a
    1540:	e8 f2 20 00 00       	call   3637 <link>
    1545:	83 c4 10             	add    $0x10,%esp
    1548:	85 c0                	test   %eax,%eax
    154a:	0f 89 8e 00 00 00    	jns    15de <linktest+0x19a>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    exit();
  }

  unlink("lf2");
    1550:	83 ec 0c             	sub    $0xc,%esp
    1553:	68 7a 3f 00 00       	push   $0x3f7a
    1558:	e8 ca 20 00 00       	call   3627 <unlink>
  if(link("lf2", "lf1") >= 0){
    155d:	59                   	pop    %ecx
    155e:	5b                   	pop    %ebx
    155f:	68 76 3f 00 00       	push   $0x3f76
    1564:	68 7a 3f 00 00       	push   $0x3f7a
    1569:	e8 c9 20 00 00       	call   3637 <link>
    156e:	83 c4 10             	add    $0x10,%esp
    1571:	85 c0                	test   %eax,%eax
    1573:	79 56                	jns    15cb <linktest+0x187>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    1575:	83 ec 08             	sub    $0x8,%esp
    1578:	68 76 3f 00 00       	push   $0x3f76
    157d:	68 3e 42 00 00       	push   $0x423e
    1582:	e8 b0 20 00 00       	call   3637 <link>
    1587:	83 c4 10             	add    $0x10,%esp
    158a:	85 c0                	test   %eax,%eax
    158c:	79 2a                	jns    15b8 <linktest+0x174>
    printf(1, "link . lf1 succeeded! oops\n");
    exit();
  }

  printf(1, "linktest ok\n");
    158e:	83 ec 08             	sub    $0x8,%esp
    1591:	68 14 40 00 00       	push   $0x4014
    1596:	6a 01                	push   $0x1
    1598:	e8 5b 21 00 00       	call   36f8 <printf>
    159d:	83 c4 10             	add    $0x10,%esp
}
    15a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    15a3:	c9                   	leave  
    15a4:	c3                   	ret    
  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    15a5:	50                   	push   %eax
    15a6:	50                   	push   %eax
    15a7:	68 7e 3f 00 00       	push   $0x3f7e
    15ac:	6a 01                	push   $0x1
    15ae:	e8 45 21 00 00       	call   36f8 <printf>
    exit();
    15b3:	e8 1f 20 00 00       	call   35d7 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    printf(1, "link . lf1 succeeded! oops\n");
    15b8:	50                   	push   %eax
    15b9:	50                   	push   %eax
    15ba:	68 f8 3f 00 00       	push   $0x3ff8
    15bf:	6a 01                	push   $0x1
    15c1:	e8 32 21 00 00       	call   36f8 <printf>
    exit();
    15c6:	e8 0c 20 00 00       	call   35d7 <exit>
    exit();
  }

  unlink("lf2");
  if(link("lf2", "lf1") >= 0){
    printf(1, "link non-existant succeeded! oops\n");
    15cb:	52                   	push   %edx
    15cc:	52                   	push   %edx
    15cd:	68 ac 4b 00 00       	push   $0x4bac
    15d2:	6a 01                	push   $0x1
    15d4:	e8 1f 21 00 00       	call   36f8 <printf>
    exit();
    15d9:	e8 f9 1f 00 00       	call   35d7 <exit>
    exit();
  }
  close(fd);

  if(link("lf2", "lf2") >= 0){
    printf(1, "link lf2 lf2 succeeded! oops\n");
    15de:	50                   	push   %eax
    15df:	50                   	push   %eax
    15e0:	68 da 3f 00 00       	push   $0x3fda
    15e5:	6a 01                	push   $0x1
    15e7:	e8 0c 21 00 00       	call   36f8 <printf>
    exit();
    15ec:	e8 e6 1f 00 00       	call   35d7 <exit>
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "read lf2 failed\n");
    15f1:	51                   	push   %ecx
    15f2:	51                   	push   %ecx
    15f3:	68 c9 3f 00 00       	push   $0x3fc9
    15f8:	6a 01                	push   $0x1
    15fa:	e8 f9 20 00 00       	call   36f8 <printf>
    exit();
    15ff:	e8 d3 1f 00 00       	call   35d7 <exit>
    exit();
  }

  fd = open("lf2", 0);
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    1604:	50                   	push   %eax
    1605:	50                   	push   %eax
    1606:	68 b8 3f 00 00       	push   $0x3fb8
    160b:	6a 01                	push   $0x1
    160d:	e8 e6 20 00 00       	call   36f8 <printf>
    exit();
    1612:	e8 c0 1f 00 00       	call   35d7 <exit>
    exit();
  }
  unlink("lf1");

  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    1617:	50                   	push   %eax
    1618:	50                   	push   %eax
    1619:	68 84 4b 00 00       	push   $0x4b84
    161e:	6a 01                	push   $0x1
    1620:	e8 d3 20 00 00       	call   36f8 <printf>
    exit();
    1625:	e8 ad 1f 00 00       	call   35d7 <exit>
    exit();
  }
  close(fd);

  if(link("lf1", "lf2") < 0){
    printf(1, "link lf1 lf2 failed\n");
    162a:	51                   	push   %ecx
    162b:	51                   	push   %ecx
    162c:	68 a3 3f 00 00       	push   $0x3fa3
    1631:	6a 01                	push   $0x1
    1633:	e8 c0 20 00 00       	call   36f8 <printf>
    exit();
    1638:	e8 9a 1f 00 00       	call   35d7 <exit>
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    printf(1, "write lf1 failed\n");
    163d:	50                   	push   %eax
    163e:	50                   	push   %eax
    163f:	68 91 3f 00 00       	push   $0x3f91
    1644:	6a 01                	push   $0x1
    1646:	e8 ad 20 00 00       	call   36f8 <printf>
    exit();
    164b:	e8 87 1f 00 00       	call   35d7 <exit>

00001650 <concreate>:
}

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    1650:	55                   	push   %ebp
    1651:	89 e5                	mov    %esp,%ebp
    1653:	57                   	push   %edi
    1654:	56                   	push   %esi
    1655:	53                   	push   %ebx
    1656:	83 ec 64             	sub    $0x64,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    1659:	68 21 40 00 00       	push   $0x4021
    165e:	6a 01                	push   $0x1
    1660:	e8 93 20 00 00       	call   36f8 <printf>
  file[0] = 'C';
    1665:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
  file[2] = '\0';
    1669:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
    166d:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 40; i++){
    1670:	31 f6                	xor    %esi,%esi
    1672:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
    1675:	bf 03 00 00 00       	mov    $0x3,%edi
    167a:	8d 46 30             	lea    0x30(%esi),%eax
    167d:	88 45 ae             	mov    %al,-0x52(%ebp)
  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    1680:	83 ec 0c             	sub    $0xc,%esp
    1683:	53                   	push   %ebx
    1684:	e8 9e 1f 00 00       	call   3627 <unlink>
    pid = fork();
    1689:	e8 41 1f 00 00       	call   35cf <fork>
    if(pid && (i % 3) == 1){
    168e:	83 c4 10             	add    $0x10,%esp
    1691:	85 c0                	test   %eax,%eax
    1693:	0f 84 b7 00 00 00    	je     1750 <concreate+0x100>
    1699:	89 f0                	mov    %esi,%eax
    169b:	99                   	cltd   
    169c:	f7 ff                	idiv   %edi
    169e:	4a                   	dec    %edx
    169f:	0f 84 f7 00 00 00    	je     179c <concreate+0x14c>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    16a5:	83 ec 08             	sub    $0x8,%esp
    16a8:	68 02 02 00 00       	push   $0x202
    16ad:	53                   	push   %ebx
    16ae:	e8 64 1f 00 00       	call   3617 <open>
      if(fd < 0){
    16b3:	83 c4 10             	add    $0x10,%esp
    16b6:	85 c0                	test   %eax,%eax
    16b8:	0f 88 f5 01 00 00    	js     18b3 <concreate+0x263>
        printf(1, "concreate create %s failed\n", file);
        exit();
      }
      close(fd);
    16be:	83 ec 0c             	sub    $0xc,%esp
    16c1:	50                   	push   %eax
    16c2:	e8 38 1f 00 00       	call   35ff <close>
    16c7:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
      exit();
    else
      wait();
    16ca:	e8 10 1f 00 00       	call   35df <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    16cf:	46                   	inc    %esi
    16d0:	83 fe 28             	cmp    $0x28,%esi
    16d3:	75 a5                	jne    167a <concreate+0x2a>
      exit();
    else
      wait();
  }

  memset(fa, 0, sizeof(fa));
    16d5:	57                   	push   %edi
    16d6:	6a 28                	push   $0x28
    16d8:	6a 00                	push   $0x0
    16da:	8d 45 c0             	lea    -0x40(%ebp),%eax
    16dd:	50                   	push   %eax
    16de:	e8 c1 1d 00 00       	call   34a4 <memset>
  fd = open(".", 0);
    16e3:	58                   	pop    %eax
    16e4:	5a                   	pop    %edx
    16e5:	6a 00                	push   $0x0
    16e7:	68 3e 42 00 00       	push   $0x423e
    16ec:	e8 26 1f 00 00       	call   3617 <open>
    16f1:	89 c6                	mov    %eax,%esi
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    16f3:	83 c4 10             	add    $0x10,%esp
      wait();
  }

  memset(fa, 0, sizeof(fa));
  fd = open(".", 0);
  n = 0;
    16f6:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    16fd:	8d 7d b0             	lea    -0x50(%ebp),%edi
  while(read(fd, &de, sizeof(de)) > 0){
    1700:	51                   	push   %ecx
    1701:	6a 10                	push   $0x10
    1703:	57                   	push   %edi
    1704:	56                   	push   %esi
    1705:	e8 e5 1e 00 00       	call   35ef <read>
    170a:	83 c4 10             	add    $0x10,%esp
    170d:	85 c0                	test   %eax,%eax
    170f:	0f 8e af 00 00 00    	jle    17c4 <concreate+0x174>
    if(de.inum == 0)
    1715:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    171a:	74 e4                	je     1700 <concreate+0xb0>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    171c:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    1720:	75 de                	jne    1700 <concreate+0xb0>
    1722:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    1726:	75 d8                	jne    1700 <concreate+0xb0>
      i = de.name[1] - '0';
    1728:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    172c:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    172f:	83 f8 27             	cmp    $0x27,%eax
    1732:	0f 87 cc 01 00 00    	ja     1904 <concreate+0x2b4>
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
    1738:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    173d:	0f 85 ab 01 00 00    	jne    18ee <concreate+0x29e>
        printf(1, "concreate duplicate file %s\n", de.name);
        exit();
      }
      fa[i] = 1;
    1743:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
      n++;
    1748:	ff 45 a4             	incl   -0x5c(%ebp)
    174b:	eb b3                	jmp    1700 <concreate+0xb0>
    174d:	8d 76 00             	lea    0x0(%esi),%esi
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
    1750:	b9 05 00 00 00       	mov    $0x5,%ecx
    1755:	89 f0                	mov    %esi,%eax
    1757:	99                   	cltd   
    1758:	f7 f9                	idiv   %ecx
    175a:	4a                   	dec    %edx
    175b:	74 27                	je     1784 <concreate+0x134>
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    175d:	83 ec 08             	sub    $0x8,%esp
    1760:	68 02 02 00 00       	push   $0x202
    1765:	53                   	push   %ebx
    1766:	e8 ac 1e 00 00       	call   3617 <open>
      if(fd < 0){
    176b:	83 c4 10             	add    $0x10,%esp
    176e:	85 c0                	test   %eax,%eax
    1770:	0f 88 3d 01 00 00    	js     18b3 <concreate+0x263>
        printf(1, "concreate create %s failed\n", file);
        exit();
      }
      close(fd);
    1776:	83 ec 0c             	sub    $0xc,%esp
    1779:	50                   	push   %eax
    177a:	e8 80 1e 00 00       	call   35ff <close>
    177f:	83 c4 10             	add    $0x10,%esp
    1782:	eb 11                	jmp    1795 <concreate+0x145>
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    1784:	83 ec 08             	sub    $0x8,%esp
    1787:	53                   	push   %ebx
    1788:	68 31 40 00 00       	push   $0x4031
    178d:	e8 a5 1e 00 00       	call   3637 <link>
    1792:	83 c4 10             	add    $0x10,%esp
        exit();
      }
      close(fd);
    }
    if(pid == 0)
      exit();
    1795:	e8 3d 1e 00 00       	call   35d7 <exit>
    179a:	66 90                	xchg   %ax,%ax
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    179c:	83 ec 08             	sub    $0x8,%esp
    179f:	53                   	push   %ebx
    17a0:	68 31 40 00 00       	push   $0x4031
    17a5:	e8 8d 1e 00 00       	call   3637 <link>
    17aa:	83 c4 10             	add    $0x10,%esp
      close(fd);
    }
    if(pid == 0)
      exit();
    else
      wait();
    17ad:	e8 2d 1e 00 00       	call   35df <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    17b2:	46                   	inc    %esi
    17b3:	83 fe 28             	cmp    $0x28,%esi
    17b6:	0f 85 be fe ff ff    	jne    167a <concreate+0x2a>
    17bc:	e9 14 ff ff ff       	jmp    16d5 <concreate+0x85>
    17c1:	8d 76 00             	lea    0x0(%esi),%esi
      }
      fa[i] = 1;
      n++;
    }
  }
  close(fd);
    17c4:	83 ec 0c             	sub    $0xc,%esp
    17c7:	56                   	push   %esi
    17c8:	e8 32 1e 00 00       	call   35ff <close>

  if(n != 40){
    17cd:	83 c4 10             	add    $0x10,%esp
    17d0:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    17d4:	0f 85 00 01 00 00    	jne    18da <concreate+0x28a>
    17da:	31 f6                	xor    %esi,%esi
    17dc:	eb 69                	jmp    1847 <concreate+0x1f7>
    17de:	66 90                	xchg   %ax,%ax
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    17e0:	85 ff                	test   %edi,%edi
    17e2:	0f 85 8d 00 00 00    	jne    1875 <concreate+0x225>
       ((i % 3) == 1 && pid != 0)){
      close(open(file, 0));
    17e8:	83 ec 08             	sub    $0x8,%esp
    17eb:	6a 00                	push   $0x0
    17ed:	53                   	push   %ebx
    17ee:	e8 24 1e 00 00       	call   3617 <open>
    17f3:	89 04 24             	mov    %eax,(%esp)
    17f6:	e8 04 1e 00 00       	call   35ff <close>
      close(open(file, 0));
    17fb:	58                   	pop    %eax
    17fc:	5a                   	pop    %edx
    17fd:	6a 00                	push   $0x0
    17ff:	53                   	push   %ebx
    1800:	e8 12 1e 00 00       	call   3617 <open>
    1805:	89 04 24             	mov    %eax,(%esp)
    1808:	e8 f2 1d 00 00       	call   35ff <close>
      close(open(file, 0));
    180d:	59                   	pop    %ecx
    180e:	58                   	pop    %eax
    180f:	6a 00                	push   $0x0
    1811:	53                   	push   %ebx
    1812:	e8 00 1e 00 00       	call   3617 <open>
    1817:	89 04 24             	mov    %eax,(%esp)
    181a:	e8 e0 1d 00 00       	call   35ff <close>
      close(open(file, 0));
    181f:	58                   	pop    %eax
    1820:	5a                   	pop    %edx
    1821:	6a 00                	push   $0x0
    1823:	53                   	push   %ebx
    1824:	e8 ee 1d 00 00       	call   3617 <open>
    1829:	89 04 24             	mov    %eax,(%esp)
    182c:	e8 ce 1d 00 00       	call   35ff <close>
    1831:	83 c4 10             	add    $0x10,%esp
      unlink(file);
      unlink(file);
      unlink(file);
      unlink(file);
    }
    if(pid == 0)
    1834:	85 ff                	test   %edi,%edi
    1836:	0f 84 59 ff ff ff    	je     1795 <concreate+0x145>
      exit();
    else
      wait();
    183c:	e8 9e 1d 00 00       	call   35df <wait>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    1841:	46                   	inc    %esi
    1842:	83 fe 28             	cmp    $0x28,%esi
    1845:	74 55                	je     189c <concreate+0x24c>
    1847:	8d 46 30             	lea    0x30(%esi),%eax
    184a:	88 45 ae             	mov    %al,-0x52(%ebp)
    file[1] = '0' + i;
    pid = fork();
    184d:	e8 7d 1d 00 00       	call   35cf <fork>
    1852:	89 c7                	mov    %eax,%edi
    if(pid < 0){
    1854:	85 c0                	test   %eax,%eax
    1856:	78 6e                	js     18c6 <concreate+0x276>
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    1858:	89 f0                	mov    %esi,%eax
    185a:	b9 03 00 00 00       	mov    $0x3,%ecx
    185f:	99                   	cltd   
    1860:	f7 f9                	idiv   %ecx
    1862:	85 d2                	test   %edx,%edx
    1864:	0f 84 76 ff ff ff    	je     17e0 <concreate+0x190>
    186a:	4a                   	dec    %edx
    186b:	75 08                	jne    1875 <concreate+0x225>
       ((i % 3) == 1 && pid != 0)){
    186d:	85 ff                	test   %edi,%edi
    186f:	0f 85 73 ff ff ff    	jne    17e8 <concreate+0x198>
      close(open(file, 0));
      close(open(file, 0));
      close(open(file, 0));
      close(open(file, 0));
    } else {
      unlink(file);
    1875:	83 ec 0c             	sub    $0xc,%esp
    1878:	53                   	push   %ebx
    1879:	e8 a9 1d 00 00       	call   3627 <unlink>
      unlink(file);
    187e:	89 1c 24             	mov    %ebx,(%esp)
    1881:	e8 a1 1d 00 00       	call   3627 <unlink>
      unlink(file);
    1886:	89 1c 24             	mov    %ebx,(%esp)
    1889:	e8 99 1d 00 00       	call   3627 <unlink>
      unlink(file);
    188e:	89 1c 24             	mov    %ebx,(%esp)
    1891:	e8 91 1d 00 00       	call   3627 <unlink>
    1896:	83 c4 10             	add    $0x10,%esp
    1899:	eb 99                	jmp    1834 <concreate+0x1e4>
    189b:	90                   	nop
      exit();
    else
      wait();
  }

  printf(1, "concreate ok\n");
    189c:	83 ec 08             	sub    $0x8,%esp
    189f:	68 86 40 00 00       	push   $0x4086
    18a4:	6a 01                	push   $0x1
    18a6:	e8 4d 1e 00 00       	call   36f8 <printf>
}
    18ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
    18ae:	5b                   	pop    %ebx
    18af:	5e                   	pop    %esi
    18b0:	5f                   	pop    %edi
    18b1:	5d                   	pop    %ebp
    18b2:	c3                   	ret    
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "concreate create %s failed\n", file);
    18b3:	51                   	push   %ecx
    18b4:	53                   	push   %ebx
    18b5:	68 34 40 00 00       	push   $0x4034
    18ba:	6a 01                	push   $0x1
    18bc:	e8 37 1e 00 00       	call   36f8 <printf>
        exit();
    18c1:	e8 11 1d 00 00       	call   35d7 <exit>

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    18c6:	83 ec 08             	sub    $0x8,%esp
    18c9:	68 09 49 00 00       	push   $0x4909
    18ce:	6a 01                	push   $0x1
    18d0:	e8 23 1e 00 00       	call   36f8 <printf>
      exit();
    18d5:	e8 fd 1c 00 00       	call   35d7 <exit>
    }
  }
  close(fd);

  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    18da:	83 ec 08             	sub    $0x8,%esp
    18dd:	68 d0 4b 00 00       	push   $0x4bd0
    18e2:	6a 01                	push   $0x1
    18e4:	e8 0f 1e 00 00       	call   36f8 <printf>
    exit();
    18e9:	e8 e9 1c 00 00       	call   35d7 <exit>
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
        printf(1, "concreate duplicate file %s\n", de.name);
    18ee:	53                   	push   %ebx
    18ef:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    18f2:	50                   	push   %eax
    18f3:	68 69 40 00 00       	push   $0x4069
    18f8:	6a 01                	push   $0x1
    18fa:	e8 f9 1d 00 00       	call   36f8 <printf>
        exit();
    18ff:	e8 d3 1c 00 00       	call   35d7 <exit>
    if(de.inum == 0)
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
      i = de.name[1] - '0';
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
    1904:	56                   	push   %esi
    1905:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1908:	50                   	push   %eax
    1909:	68 50 40 00 00       	push   $0x4050
    190e:	6a 01                	push   $0x1
    1910:	e8 e3 1d 00 00       	call   36f8 <printf>
        exit();
    1915:	e8 bd 1c 00 00       	call   35d7 <exit>
    191a:	66 90                	xchg   %ax,%ax

0000191c <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    191c:	55                   	push   %ebp
    191d:	89 e5                	mov    %esp,%ebp
    191f:	57                   	push   %edi
    1920:	56                   	push   %esi
    1921:	53                   	push   %ebx
    1922:	83 ec 24             	sub    $0x24,%esp
  int pid, i;

  printf(1, "linkunlink test\n");
    1925:	68 94 40 00 00       	push   $0x4094
    192a:	6a 01                	push   $0x1
    192c:	e8 c7 1d 00 00       	call   36f8 <printf>

  unlink("x");
    1931:	c7 04 24 21 43 00 00 	movl   $0x4321,(%esp)
    1938:	e8 ea 1c 00 00       	call   3627 <unlink>
  pid = fork();
    193d:	e8 8d 1c 00 00       	call   35cf <fork>
    1942:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    1945:	83 c4 10             	add    $0x10,%esp
    1948:	85 c0                	test   %eax,%eax
    194a:	0f 88 c2 00 00 00    	js     1a12 <linkunlink+0xf6>
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
    1950:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1954:	19 ff                	sbb    %edi,%edi
    1956:	83 e7 60             	and    $0x60,%edi
    1959:	47                   	inc    %edi
    195a:	bb 64 00 00 00       	mov    $0x64,%ebx
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
    195f:	be 03 00 00 00       	mov    $0x3,%esi
    1964:	eb 1c                	jmp    1982 <linkunlink+0x66>
    1966:	66 90                	xchg   %ax,%ax
      close(open("x", O_RDWR | O_CREATE));
    } else if((x % 3) == 1){
    1968:	4a                   	dec    %edx
    1969:	0f 84 89 00 00 00    	je     19f8 <linkunlink+0xdc>
      link("cat", "x");
    } else {
      unlink("x");
    196f:	83 ec 0c             	sub    $0xc,%esp
    1972:	68 21 43 00 00       	push   $0x4321
    1977:	e8 ab 1c 00 00       	call   3627 <unlink>
    197c:	83 c4 10             	add    $0x10,%esp
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    197f:	4b                   	dec    %ebx
    1980:	74 52                	je     19d4 <linkunlink+0xb8>
    x = x * 1103515245 + 12345;
    1982:	89 f8                	mov    %edi,%eax
    1984:	c1 e0 09             	shl    $0x9,%eax
    1987:	29 f8                	sub    %edi,%eax
    1989:	8d 14 87             	lea    (%edi,%eax,4),%edx
    198c:	89 d0                	mov    %edx,%eax
    198e:	c1 e0 09             	shl    $0x9,%eax
    1991:	29 d0                	sub    %edx,%eax
    1993:	01 c0                	add    %eax,%eax
    1995:	01 f8                	add    %edi,%eax
    1997:	89 c2                	mov    %eax,%edx
    1999:	c1 e2 05             	shl    $0x5,%edx
    199c:	01 d0                	add    %edx,%eax
    199e:	c1 e0 02             	shl    $0x2,%eax
    19a1:	29 f8                	sub    %edi,%eax
    19a3:	8d bc 87 39 30 00 00 	lea    0x3039(%edi,%eax,4),%edi
    if((x % 3) == 0){
    19aa:	89 f8                	mov    %edi,%eax
    19ac:	31 d2                	xor    %edx,%edx
    19ae:	f7 f6                	div    %esi
    19b0:	85 d2                	test   %edx,%edx
    19b2:	75 b4                	jne    1968 <linkunlink+0x4c>
      close(open("x", O_RDWR | O_CREATE));
    19b4:	83 ec 08             	sub    $0x8,%esp
    19b7:	68 02 02 00 00       	push   $0x202
    19bc:	68 21 43 00 00       	push   $0x4321
    19c1:	e8 51 1c 00 00       	call   3617 <open>
    19c6:	89 04 24             	mov    %eax,(%esp)
    19c9:	e8 31 1c 00 00       	call   35ff <close>
    19ce:	83 c4 10             	add    $0x10,%esp
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    19d1:	4b                   	dec    %ebx
    19d2:	75 ae                	jne    1982 <linkunlink+0x66>
    } else {
      unlink("x");
    }
  }

  if(pid)
    19d4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    19d7:	85 c0                	test   %eax,%eax
    19d9:	74 4b                	je     1a26 <linkunlink+0x10a>
    wait();
    19db:	e8 ff 1b 00 00       	call   35df <wait>
  else
    exit();

  printf(1, "linkunlink ok\n");
    19e0:	83 ec 08             	sub    $0x8,%esp
    19e3:	68 a9 40 00 00       	push   $0x40a9
    19e8:	6a 01                	push   $0x1
    19ea:	e8 09 1d 00 00       	call   36f8 <printf>
}
    19ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
    19f2:	5b                   	pop    %ebx
    19f3:	5e                   	pop    %esi
    19f4:	5f                   	pop    %edi
    19f5:	5d                   	pop    %ebp
    19f6:	c3                   	ret    
    19f7:	90                   	nop
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
      close(open("x", O_RDWR | O_CREATE));
    } else if((x % 3) == 1){
      link("cat", "x");
    19f8:	83 ec 08             	sub    $0x8,%esp
    19fb:	68 21 43 00 00       	push   $0x4321
    1a00:	68 a5 40 00 00       	push   $0x40a5
    1a05:	e8 2d 1c 00 00       	call   3637 <link>
    1a0a:	83 c4 10             	add    $0x10,%esp
    1a0d:	e9 6d ff ff ff       	jmp    197f <linkunlink+0x63>
  printf(1, "linkunlink test\n");

  unlink("x");
  pid = fork();
  if(pid < 0){
    printf(1, "fork failed\n");
    1a12:	83 ec 08             	sub    $0x8,%esp
    1a15:	68 09 49 00 00       	push   $0x4909
    1a1a:	6a 01                	push   $0x1
    1a1c:	e8 d7 1c 00 00       	call   36f8 <printf>
    exit();
    1a21:	e8 b1 1b 00 00       	call   35d7 <exit>
  }

  if(pid)
    wait();
  else
    exit();
    1a26:	e8 ac 1b 00 00       	call   35d7 <exit>
    1a2b:	90                   	nop

00001a2c <bigdir>:
}

// directory that uses indirect blocks
void
bigdir(void)
{
    1a2c:	55                   	push   %ebp
    1a2d:	89 e5                	mov    %esp,%ebp
    1a2f:	56                   	push   %esi
    1a30:	53                   	push   %ebx
    1a31:	83 ec 18             	sub    $0x18,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    1a34:	68 b8 40 00 00       	push   $0x40b8
    1a39:	6a 01                	push   $0x1
    1a3b:	e8 b8 1c 00 00       	call   36f8 <printf>
  unlink("bd");
    1a40:	c7 04 24 c5 40 00 00 	movl   $0x40c5,(%esp)
    1a47:	e8 db 1b 00 00       	call   3627 <unlink>

  fd = open("bd", O_CREATE);
    1a4c:	58                   	pop    %eax
    1a4d:	5a                   	pop    %edx
    1a4e:	68 00 02 00 00       	push   $0x200
    1a53:	68 c5 40 00 00       	push   $0x40c5
    1a58:	e8 ba 1b 00 00       	call   3617 <open>
  if(fd < 0){
    1a5d:	83 c4 10             	add    $0x10,%esp
    1a60:	85 c0                	test   %eax,%eax
    1a62:	0f 88 dc 00 00 00    	js     1b44 <bigdir+0x118>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);
    1a68:	83 ec 0c             	sub    $0xc,%esp
    1a6b:	50                   	push   %eax
    1a6c:	e8 8e 1b 00 00       	call   35ff <close>
    1a71:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 500; i++){
    1a74:	31 db                	xor    %ebx,%ebx
    1a76:	8d 75 ee             	lea    -0x12(%ebp),%esi
    1a79:	8d 76 00             	lea    0x0(%esi),%esi
    name[0] = 'x';
    1a7c:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    1a80:	89 d8                	mov    %ebx,%eax
    1a82:	c1 f8 06             	sar    $0x6,%eax
    1a85:	83 c0 30             	add    $0x30,%eax
    1a88:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    1a8b:	89 d8                	mov    %ebx,%eax
    1a8d:	83 e0 3f             	and    $0x3f,%eax
    1a90:	83 c0 30             	add    $0x30,%eax
    1a93:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    1a96:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(link("bd", name) != 0){
    1a9a:	83 ec 08             	sub    $0x8,%esp
    1a9d:	56                   	push   %esi
    1a9e:	68 c5 40 00 00       	push   $0x40c5
    1aa3:	e8 8f 1b 00 00       	call   3637 <link>
    1aa8:	83 c4 10             	add    $0x10,%esp
    1aab:	85 c0                	test   %eax,%eax
    1aad:	75 6d                	jne    1b1c <bigdir+0xf0>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    1aaf:	43                   	inc    %ebx
    1ab0:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1ab6:	75 c4                	jne    1a7c <bigdir+0x50>
      printf(1, "bigdir link failed\n");
      exit();
    }
  }

  unlink("bd");
    1ab8:	83 ec 0c             	sub    $0xc,%esp
    1abb:	68 c5 40 00 00       	push   $0x40c5
    1ac0:	e8 62 1b 00 00       	call   3627 <unlink>
    1ac5:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 500; i++){
    1ac8:	66 31 db             	xor    %bx,%bx
    1acb:	90                   	nop
    name[0] = 'x';
    1acc:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    1ad0:	89 d8                	mov    %ebx,%eax
    1ad2:	c1 f8 06             	sar    $0x6,%eax
    1ad5:	83 c0 30             	add    $0x30,%eax
    1ad8:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    1adb:	89 d8                	mov    %ebx,%eax
    1add:	83 e0 3f             	and    $0x3f,%eax
    1ae0:	83 c0 30             	add    $0x30,%eax
    1ae3:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    1ae6:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(unlink(name) != 0){
    1aea:	83 ec 0c             	sub    $0xc,%esp
    1aed:	56                   	push   %esi
    1aee:	e8 34 1b 00 00       	call   3627 <unlink>
    1af3:	83 c4 10             	add    $0x10,%esp
    1af6:	85 c0                	test   %eax,%eax
    1af8:	75 36                	jne    1b30 <bigdir+0x104>
      exit();
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    1afa:	43                   	inc    %ebx
    1afb:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1b01:	75 c9                	jne    1acc <bigdir+0xa0>
      printf(1, "bigdir unlink failed");
      exit();
    }
  }

  printf(1, "bigdir ok\n");
    1b03:	83 ec 08             	sub    $0x8,%esp
    1b06:	68 07 41 00 00       	push   $0x4107
    1b0b:	6a 01                	push   $0x1
    1b0d:	e8 e6 1b 00 00       	call   36f8 <printf>
    1b12:	83 c4 10             	add    $0x10,%esp
}
    1b15:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1b18:	5b                   	pop    %ebx
    1b19:	5e                   	pop    %esi
    1b1a:	5d                   	pop    %ebp
    1b1b:	c3                   	ret    
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(link("bd", name) != 0){
      printf(1, "bigdir link failed\n");
    1b1c:	83 ec 08             	sub    $0x8,%esp
    1b1f:	68 de 40 00 00       	push   $0x40de
    1b24:	6a 01                	push   $0x1
    1b26:	e8 cd 1b 00 00       	call   36f8 <printf>
      exit();
    1b2b:	e8 a7 1a 00 00       	call   35d7 <exit>
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(unlink(name) != 0){
      printf(1, "bigdir unlink failed");
    1b30:	83 ec 08             	sub    $0x8,%esp
    1b33:	68 f2 40 00 00       	push   $0x40f2
    1b38:	6a 01                	push   $0x1
    1b3a:	e8 b9 1b 00 00       	call   36f8 <printf>
      exit();
    1b3f:	e8 93 1a 00 00       	call   35d7 <exit>
  printf(1, "bigdir test\n");
  unlink("bd");

  fd = open("bd", O_CREATE);
  if(fd < 0){
    printf(1, "bigdir create failed\n");
    1b44:	83 ec 08             	sub    $0x8,%esp
    1b47:	68 c8 40 00 00       	push   $0x40c8
    1b4c:	6a 01                	push   $0x1
    1b4e:	e8 a5 1b 00 00       	call   36f8 <printf>
    exit();
    1b53:	e8 7f 1a 00 00       	call   35d7 <exit>

00001b58 <subdir>:
  printf(1, "bigdir ok\n");
}

void
subdir(void)
{
    1b58:	55                   	push   %ebp
    1b59:	89 e5                	mov    %esp,%ebp
    1b5b:	53                   	push   %ebx
    1b5c:	83 ec 0c             	sub    $0xc,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    1b5f:	68 12 41 00 00       	push   $0x4112
    1b64:	6a 01                	push   $0x1
    1b66:	e8 8d 1b 00 00       	call   36f8 <printf>

  unlink("ff");
    1b6b:	c7 04 24 9b 41 00 00 	movl   $0x419b,(%esp)
    1b72:	e8 b0 1a 00 00       	call   3627 <unlink>
  if(mkdir("dd") != 0){
    1b77:	c7 04 24 38 42 00 00 	movl   $0x4238,(%esp)
    1b7e:	e8 bc 1a 00 00       	call   363f <mkdir>
    1b83:	83 c4 10             	add    $0x10,%esp
    1b86:	85 c0                	test   %eax,%eax
    1b88:	0f 85 ab 05 00 00    	jne    2139 <subdir+0x5e1>
    printf(1, "subdir mkdir dd failed\n");
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1b8e:	83 ec 08             	sub    $0x8,%esp
    1b91:	68 02 02 00 00       	push   $0x202
    1b96:	68 71 41 00 00       	push   $0x4171
    1b9b:	e8 77 1a 00 00       	call   3617 <open>
    1ba0:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1ba2:	83 c4 10             	add    $0x10,%esp
    1ba5:	85 c0                	test   %eax,%eax
    1ba7:	0f 88 79 05 00 00    	js     2126 <subdir+0x5ce>
    printf(1, "create dd/ff failed\n");
    exit();
  }
  write(fd, "ff", 2);
    1bad:	50                   	push   %eax
    1bae:	6a 02                	push   $0x2
    1bb0:	68 9b 41 00 00       	push   $0x419b
    1bb5:	53                   	push   %ebx
    1bb6:	e8 3c 1a 00 00       	call   35f7 <write>
  close(fd);
    1bbb:	89 1c 24             	mov    %ebx,(%esp)
    1bbe:	e8 3c 1a 00 00       	call   35ff <close>

  if(unlink("dd") >= 0){
    1bc3:	c7 04 24 38 42 00 00 	movl   $0x4238,(%esp)
    1bca:	e8 58 1a 00 00       	call   3627 <unlink>
    1bcf:	83 c4 10             	add    $0x10,%esp
    1bd2:	85 c0                	test   %eax,%eax
    1bd4:	0f 89 39 05 00 00    	jns    2113 <subdir+0x5bb>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    1bda:	83 ec 0c             	sub    $0xc,%esp
    1bdd:	68 4c 41 00 00       	push   $0x414c
    1be2:	e8 58 1a 00 00       	call   363f <mkdir>
    1be7:	83 c4 10             	add    $0x10,%esp
    1bea:	85 c0                	test   %eax,%eax
    1bec:	0f 85 0e 05 00 00    	jne    2100 <subdir+0x5a8>
    printf(1, "subdir mkdir dd/dd failed\n");
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1bf2:	83 ec 08             	sub    $0x8,%esp
    1bf5:	68 02 02 00 00       	push   $0x202
    1bfa:	68 6e 41 00 00       	push   $0x416e
    1bff:	e8 13 1a 00 00       	call   3617 <open>
    1c04:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1c06:	83 c4 10             	add    $0x10,%esp
    1c09:	85 c0                	test   %eax,%eax
    1c0b:	0f 88 1e 04 00 00    	js     202f <subdir+0x4d7>
    printf(1, "create dd/dd/ff failed\n");
    exit();
  }
  write(fd, "FF", 2);
    1c11:	50                   	push   %eax
    1c12:	6a 02                	push   $0x2
    1c14:	68 8f 41 00 00       	push   $0x418f
    1c19:	53                   	push   %ebx
    1c1a:	e8 d8 19 00 00       	call   35f7 <write>
  close(fd);
    1c1f:	89 1c 24             	mov    %ebx,(%esp)
    1c22:	e8 d8 19 00 00       	call   35ff <close>

  fd = open("dd/dd/../ff", 0);
    1c27:	58                   	pop    %eax
    1c28:	5a                   	pop    %edx
    1c29:	6a 00                	push   $0x0
    1c2b:	68 92 41 00 00       	push   $0x4192
    1c30:	e8 e2 19 00 00       	call   3617 <open>
    1c35:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1c37:	83 c4 10             	add    $0x10,%esp
    1c3a:	85 c0                	test   %eax,%eax
    1c3c:	0f 88 da 03 00 00    	js     201c <subdir+0x4c4>
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
    1c42:	50                   	push   %eax
    1c43:	68 00 20 00 00       	push   $0x2000
    1c48:	68 40 82 00 00       	push   $0x8240
    1c4d:	53                   	push   %ebx
    1c4e:	e8 9c 19 00 00       	call   35ef <read>
  if(cc != 2 || buf[0] != 'f'){
    1c53:	83 c4 10             	add    $0x10,%esp
    1c56:	83 f8 02             	cmp    $0x2,%eax
    1c59:	0f 85 38 03 00 00    	jne    1f97 <subdir+0x43f>
    1c5f:	80 3d 40 82 00 00 66 	cmpb   $0x66,0x8240
    1c66:	0f 85 2b 03 00 00    	jne    1f97 <subdir+0x43f>
    printf(1, "dd/dd/../ff wrong content\n");
    exit();
  }
  close(fd);
    1c6c:	83 ec 0c             	sub    $0xc,%esp
    1c6f:	53                   	push   %ebx
    1c70:	e8 8a 19 00 00       	call   35ff <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1c75:	58                   	pop    %eax
    1c76:	5a                   	pop    %edx
    1c77:	68 d2 41 00 00       	push   $0x41d2
    1c7c:	68 6e 41 00 00       	push   $0x416e
    1c81:	e8 b1 19 00 00       	call   3637 <link>
    1c86:	83 c4 10             	add    $0x10,%esp
    1c89:	85 c0                	test   %eax,%eax
    1c8b:	0f 85 c4 03 00 00    	jne    2055 <subdir+0x4fd>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit();
  }

  if(unlink("dd/dd/ff") != 0){
    1c91:	83 ec 0c             	sub    $0xc,%esp
    1c94:	68 6e 41 00 00       	push   $0x416e
    1c99:	e8 89 19 00 00       	call   3627 <unlink>
    1c9e:	83 c4 10             	add    $0x10,%esp
    1ca1:	85 c0                	test   %eax,%eax
    1ca3:	0f 85 14 03 00 00    	jne    1fbd <subdir+0x465>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1ca9:	83 ec 08             	sub    $0x8,%esp
    1cac:	6a 00                	push   $0x0
    1cae:	68 6e 41 00 00       	push   $0x416e
    1cb3:	e8 5f 19 00 00       	call   3617 <open>
    1cb8:	83 c4 10             	add    $0x10,%esp
    1cbb:	85 c0                	test   %eax,%eax
    1cbd:	0f 89 2a 04 00 00    	jns    20ed <subdir+0x595>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    1cc3:	83 ec 0c             	sub    $0xc,%esp
    1cc6:	68 38 42 00 00       	push   $0x4238
    1ccb:	e8 77 19 00 00       	call   3647 <chdir>
    1cd0:	83 c4 10             	add    $0x10,%esp
    1cd3:	85 c0                	test   %eax,%eax
    1cd5:	0f 85 ff 03 00 00    	jne    20da <subdir+0x582>
    printf(1, "chdir dd failed\n");
    exit();
  }
  if(chdir("dd/../../dd") != 0){
    1cdb:	83 ec 0c             	sub    $0xc,%esp
    1cde:	68 06 42 00 00       	push   $0x4206
    1ce3:	e8 5f 19 00 00       	call   3647 <chdir>
    1ce8:	83 c4 10             	add    $0x10,%esp
    1ceb:	85 c0                	test   %eax,%eax
    1ced:	0f 85 b7 02 00 00    	jne    1faa <subdir+0x452>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("dd/../../../dd") != 0){
    1cf3:	83 ec 0c             	sub    $0xc,%esp
    1cf6:	68 2c 42 00 00       	push   $0x422c
    1cfb:	e8 47 19 00 00       	call   3647 <chdir>
    1d00:	83 c4 10             	add    $0x10,%esp
    1d03:	85 c0                	test   %eax,%eax
    1d05:	0f 85 9f 02 00 00    	jne    1faa <subdir+0x452>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    1d0b:	83 ec 0c             	sub    $0xc,%esp
    1d0e:	68 3b 42 00 00       	push   $0x423b
    1d13:	e8 2f 19 00 00       	call   3647 <chdir>
    1d18:	83 c4 10             	add    $0x10,%esp
    1d1b:	85 c0                	test   %eax,%eax
    1d1d:	0f 85 1f 03 00 00    	jne    2042 <subdir+0x4ea>
    printf(1, "chdir ./.. failed\n");
    exit();
  }

  fd = open("dd/dd/ffff", 0);
    1d23:	83 ec 08             	sub    $0x8,%esp
    1d26:	6a 00                	push   $0x0
    1d28:	68 d2 41 00 00       	push   $0x41d2
    1d2d:	e8 e5 18 00 00       	call   3617 <open>
    1d32:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1d34:	83 c4 10             	add    $0x10,%esp
    1d37:	85 c0                	test   %eax,%eax
    1d39:	0f 88 de 04 00 00    	js     221d <subdir+0x6c5>
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    1d3f:	50                   	push   %eax
    1d40:	68 00 20 00 00       	push   $0x2000
    1d45:	68 40 82 00 00       	push   $0x8240
    1d4a:	53                   	push   %ebx
    1d4b:	e8 9f 18 00 00       	call   35ef <read>
    1d50:	83 c4 10             	add    $0x10,%esp
    1d53:	83 f8 02             	cmp    $0x2,%eax
    1d56:	0f 85 ae 04 00 00    	jne    220a <subdir+0x6b2>
    printf(1, "read dd/dd/ffff wrong len\n");
    exit();
  }
  close(fd);
    1d5c:	83 ec 0c             	sub    $0xc,%esp
    1d5f:	53                   	push   %ebx
    1d60:	e8 9a 18 00 00       	call   35ff <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1d65:	59                   	pop    %ecx
    1d66:	5b                   	pop    %ebx
    1d67:	6a 00                	push   $0x0
    1d69:	68 6e 41 00 00       	push   $0x416e
    1d6e:	e8 a4 18 00 00       	call   3617 <open>
    1d73:	83 c4 10             	add    $0x10,%esp
    1d76:	85 c0                	test   %eax,%eax
    1d78:	0f 89 65 02 00 00    	jns    1fe3 <subdir+0x48b>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1d7e:	83 ec 08             	sub    $0x8,%esp
    1d81:	68 02 02 00 00       	push   $0x202
    1d86:	68 86 42 00 00       	push   $0x4286
    1d8b:	e8 87 18 00 00       	call   3617 <open>
    1d90:	83 c4 10             	add    $0x10,%esp
    1d93:	85 c0                	test   %eax,%eax
    1d95:	0f 89 35 02 00 00    	jns    1fd0 <subdir+0x478>
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    1d9b:	83 ec 08             	sub    $0x8,%esp
    1d9e:	68 02 02 00 00       	push   $0x202
    1da3:	68 ab 42 00 00       	push   $0x42ab
    1da8:	e8 6a 18 00 00       	call   3617 <open>
    1dad:	83 c4 10             	add    $0x10,%esp
    1db0:	85 c0                	test   %eax,%eax
    1db2:	0f 89 0f 03 00 00    	jns    20c7 <subdir+0x56f>
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    1db8:	83 ec 08             	sub    $0x8,%esp
    1dbb:	68 00 02 00 00       	push   $0x200
    1dc0:	68 38 42 00 00       	push   $0x4238
    1dc5:	e8 4d 18 00 00       	call   3617 <open>
    1dca:	83 c4 10             	add    $0x10,%esp
    1dcd:	85 c0                	test   %eax,%eax
    1dcf:	0f 89 df 02 00 00    	jns    20b4 <subdir+0x55c>
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    1dd5:	83 ec 08             	sub    $0x8,%esp
    1dd8:	6a 02                	push   $0x2
    1dda:	68 38 42 00 00       	push   $0x4238
    1ddf:	e8 33 18 00 00       	call   3617 <open>
    1de4:	83 c4 10             	add    $0x10,%esp
    1de7:	85 c0                	test   %eax,%eax
    1de9:	0f 89 b2 02 00 00    	jns    20a1 <subdir+0x549>
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    1def:	83 ec 08             	sub    $0x8,%esp
    1df2:	6a 01                	push   $0x1
    1df4:	68 38 42 00 00       	push   $0x4238
    1df9:	e8 19 18 00 00       	call   3617 <open>
    1dfe:	83 c4 10             	add    $0x10,%esp
    1e01:	85 c0                	test   %eax,%eax
    1e03:	0f 89 85 02 00 00    	jns    208e <subdir+0x536>
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    1e09:	83 ec 08             	sub    $0x8,%esp
    1e0c:	68 1a 43 00 00       	push   $0x431a
    1e11:	68 86 42 00 00       	push   $0x4286
    1e16:	e8 1c 18 00 00       	call   3637 <link>
    1e1b:	83 c4 10             	add    $0x10,%esp
    1e1e:	85 c0                	test   %eax,%eax
    1e20:	0f 84 55 02 00 00    	je     207b <subdir+0x523>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    1e26:	83 ec 08             	sub    $0x8,%esp
    1e29:	68 1a 43 00 00       	push   $0x431a
    1e2e:	68 ab 42 00 00       	push   $0x42ab
    1e33:	e8 ff 17 00 00       	call   3637 <link>
    1e38:	83 c4 10             	add    $0x10,%esp
    1e3b:	85 c0                	test   %eax,%eax
    1e3d:	0f 84 25 02 00 00    	je     2068 <subdir+0x510>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    1e43:	83 ec 08             	sub    $0x8,%esp
    1e46:	68 d2 41 00 00       	push   $0x41d2
    1e4b:	68 71 41 00 00       	push   $0x4171
    1e50:	e8 e2 17 00 00       	call   3637 <link>
    1e55:	83 c4 10             	add    $0x10,%esp
    1e58:	85 c0                	test   %eax,%eax
    1e5a:	0f 84 a9 01 00 00    	je     2009 <subdir+0x4b1>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    1e60:	83 ec 0c             	sub    $0xc,%esp
    1e63:	68 86 42 00 00       	push   $0x4286
    1e68:	e8 d2 17 00 00       	call   363f <mkdir>
    1e6d:	83 c4 10             	add    $0x10,%esp
    1e70:	85 c0                	test   %eax,%eax
    1e72:	0f 84 7e 01 00 00    	je     1ff6 <subdir+0x49e>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    1e78:	83 ec 0c             	sub    $0xc,%esp
    1e7b:	68 ab 42 00 00       	push   $0x42ab
    1e80:	e8 ba 17 00 00       	call   363f <mkdir>
    1e85:	83 c4 10             	add    $0x10,%esp
    1e88:	85 c0                	test   %eax,%eax
    1e8a:	0f 84 67 03 00 00    	je     21f7 <subdir+0x69f>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    1e90:	83 ec 0c             	sub    $0xc,%esp
    1e93:	68 d2 41 00 00       	push   $0x41d2
    1e98:	e8 a2 17 00 00       	call   363f <mkdir>
    1e9d:	83 c4 10             	add    $0x10,%esp
    1ea0:	85 c0                	test   %eax,%eax
    1ea2:	0f 84 3c 03 00 00    	je     21e4 <subdir+0x68c>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    1ea8:	83 ec 0c             	sub    $0xc,%esp
    1eab:	68 ab 42 00 00       	push   $0x42ab
    1eb0:	e8 72 17 00 00       	call   3627 <unlink>
    1eb5:	83 c4 10             	add    $0x10,%esp
    1eb8:	85 c0                	test   %eax,%eax
    1eba:	0f 84 11 03 00 00    	je     21d1 <subdir+0x679>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    1ec0:	83 ec 0c             	sub    $0xc,%esp
    1ec3:	68 86 42 00 00       	push   $0x4286
    1ec8:	e8 5a 17 00 00       	call   3627 <unlink>
    1ecd:	83 c4 10             	add    $0x10,%esp
    1ed0:	85 c0                	test   %eax,%eax
    1ed2:	0f 84 e6 02 00 00    	je     21be <subdir+0x666>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    1ed8:	83 ec 0c             	sub    $0xc,%esp
    1edb:	68 71 41 00 00       	push   $0x4171
    1ee0:	e8 62 17 00 00       	call   3647 <chdir>
    1ee5:	83 c4 10             	add    $0x10,%esp
    1ee8:	85 c0                	test   %eax,%eax
    1eea:	0f 84 bb 02 00 00    	je     21ab <subdir+0x653>
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    1ef0:	83 ec 0c             	sub    $0xc,%esp
    1ef3:	68 1d 43 00 00       	push   $0x431d
    1ef8:	e8 4a 17 00 00       	call   3647 <chdir>
    1efd:	83 c4 10             	add    $0x10,%esp
    1f00:	85 c0                	test   %eax,%eax
    1f02:	0f 84 90 02 00 00    	je     2198 <subdir+0x640>
    printf(1, "chdir dd/xx succeeded!\n");
    exit();
  }

  if(unlink("dd/dd/ffff") != 0){
    1f08:	83 ec 0c             	sub    $0xc,%esp
    1f0b:	68 d2 41 00 00       	push   $0x41d2
    1f10:	e8 12 17 00 00       	call   3627 <unlink>
    1f15:	83 c4 10             	add    $0x10,%esp
    1f18:	85 c0                	test   %eax,%eax
    1f1a:	0f 85 9d 00 00 00    	jne    1fbd <subdir+0x465>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    1f20:	83 ec 0c             	sub    $0xc,%esp
    1f23:	68 71 41 00 00       	push   $0x4171
    1f28:	e8 fa 16 00 00       	call   3627 <unlink>
    1f2d:	83 c4 10             	add    $0x10,%esp
    1f30:	85 c0                	test   %eax,%eax
    1f32:	0f 85 4d 02 00 00    	jne    2185 <subdir+0x62d>
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    1f38:	83 ec 0c             	sub    $0xc,%esp
    1f3b:	68 38 42 00 00       	push   $0x4238
    1f40:	e8 e2 16 00 00       	call   3627 <unlink>
    1f45:	83 c4 10             	add    $0x10,%esp
    1f48:	85 c0                	test   %eax,%eax
    1f4a:	0f 84 22 02 00 00    	je     2172 <subdir+0x61a>
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    1f50:	83 ec 0c             	sub    $0xc,%esp
    1f53:	68 4d 41 00 00       	push   $0x414d
    1f58:	e8 ca 16 00 00       	call   3627 <unlink>
    1f5d:	83 c4 10             	add    $0x10,%esp
    1f60:	85 c0                	test   %eax,%eax
    1f62:	0f 88 f7 01 00 00    	js     215f <subdir+0x607>
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    1f68:	83 ec 0c             	sub    $0xc,%esp
    1f6b:	68 38 42 00 00       	push   $0x4238
    1f70:	e8 b2 16 00 00       	call   3627 <unlink>
    1f75:	83 c4 10             	add    $0x10,%esp
    1f78:	85 c0                	test   %eax,%eax
    1f7a:	0f 88 cc 01 00 00    	js     214c <subdir+0x5f4>
    printf(1, "unlink dd failed\n");
    exit();
  }

  printf(1, "subdir ok\n");
    1f80:	83 ec 08             	sub    $0x8,%esp
    1f83:	68 1a 44 00 00       	push   $0x441a
    1f88:	6a 01                	push   $0x1
    1f8a:	e8 69 17 00 00       	call   36f8 <printf>
    1f8f:	83 c4 10             	add    $0x10,%esp
}
    1f92:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1f95:	c9                   	leave  
    1f96:	c3                   	ret    
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
  if(cc != 2 || buf[0] != 'f'){
    printf(1, "dd/dd/../ff wrong content\n");
    1f97:	51                   	push   %ecx
    1f98:	51                   	push   %ecx
    1f99:	68 b7 41 00 00       	push   $0x41b7
    1f9e:	6a 01                	push   $0x1
    1fa0:	e8 53 17 00 00       	call   36f8 <printf>
    exit();
    1fa5:	e8 2d 16 00 00       	call   35d7 <exit>
  if(chdir("dd") != 0){
    printf(1, "chdir dd failed\n");
    exit();
  }
  if(chdir("dd/../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    1faa:	50                   	push   %eax
    1fab:	50                   	push   %eax
    1fac:	68 12 42 00 00       	push   $0x4212
    1fb1:	6a 01                	push   $0x1
    1fb3:	e8 40 17 00 00       	call   36f8 <printf>
    exit();
    1fb8:	e8 1a 16 00 00       	call   35d7 <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit();
  }

  if(unlink("dd/dd/ff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    1fbd:	51                   	push   %ecx
    1fbe:	51                   	push   %ecx
    1fbf:	68 dd 41 00 00       	push   $0x41dd
    1fc4:	6a 01                	push   $0x1
    1fc6:	e8 2d 17 00 00       	call   36f8 <printf>
    exit();
    1fcb:	e8 07 16 00 00       	call   35d7 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    1fd0:	50                   	push   %eax
    1fd1:	50                   	push   %eax
    1fd2:	68 8f 42 00 00       	push   $0x428f
    1fd7:	6a 01                	push   $0x1
    1fd9:	e8 1a 17 00 00       	call   36f8 <printf>
    exit();
    1fde:	e8 f4 15 00 00       	call   35d7 <exit>
    exit();
  }
  close(fd);

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    1fe3:	52                   	push   %edx
    1fe4:	52                   	push   %edx
    1fe5:	68 74 4c 00 00       	push   $0x4c74
    1fea:	6a 01                	push   $0x1
    1fec:	e8 07 17 00 00       	call   36f8 <printf>
    exit();
    1ff1:	e8 e1 15 00 00       	call   35d7 <exit>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    1ff6:	52                   	push   %edx
    1ff7:	52                   	push   %edx
    1ff8:	68 23 43 00 00       	push   $0x4323
    1ffd:	6a 01                	push   $0x1
    1fff:	e8 f4 16 00 00       	call   36f8 <printf>
    exit();
    2004:	e8 ce 15 00 00       	call   35d7 <exit>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    2009:	51                   	push   %ecx
    200a:	51                   	push   %ecx
    200b:	68 e4 4c 00 00       	push   $0x4ce4
    2010:	6a 01                	push   $0x1
    2012:	e8 e1 16 00 00       	call   36f8 <printf>
    exit();
    2017:	e8 bb 15 00 00       	call   35d7 <exit>
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/../ff failed\n");
    201c:	50                   	push   %eax
    201d:	50                   	push   %eax
    201e:	68 9e 41 00 00       	push   $0x419e
    2023:	6a 01                	push   $0x1
    2025:	e8 ce 16 00 00       	call   36f8 <printf>
    exit();
    202a:	e8 a8 15 00 00       	call   35d7 <exit>
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/dd/ff failed\n");
    202f:	51                   	push   %ecx
    2030:	51                   	push   %ecx
    2031:	68 77 41 00 00       	push   $0x4177
    2036:	6a 01                	push   $0x1
    2038:	e8 bb 16 00 00       	call   36f8 <printf>
    exit();
    203d:	e8 95 15 00 00       	call   35d7 <exit>
  if(chdir("dd/../../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    2042:	50                   	push   %eax
    2043:	50                   	push   %eax
    2044:	68 40 42 00 00       	push   $0x4240
    2049:	6a 01                	push   $0x1
    204b:	e8 a8 16 00 00       	call   36f8 <printf>
    exit();
    2050:	e8 82 15 00 00       	call   35d7 <exit>
    exit();
  }
  close(fd);

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    2055:	53                   	push   %ebx
    2056:	53                   	push   %ebx
    2057:	68 2c 4c 00 00       	push   $0x4c2c
    205c:	6a 01                	push   $0x1
    205e:	e8 95 16 00 00       	call   36f8 <printf>
    exit();
    2063:	e8 6f 15 00 00       	call   35d7 <exit>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    2068:	53                   	push   %ebx
    2069:	53                   	push   %ebx
    206a:	68 c0 4c 00 00       	push   $0x4cc0
    206f:	6a 01                	push   $0x1
    2071:	e8 82 16 00 00       	call   36f8 <printf>
    exit();
    2076:	e8 5c 15 00 00       	call   35d7 <exit>
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    207b:	50                   	push   %eax
    207c:	50                   	push   %eax
    207d:	68 9c 4c 00 00       	push   $0x4c9c
    2082:	6a 01                	push   $0x1
    2084:	e8 6f 16 00 00       	call   36f8 <printf>
    exit();
    2089:	e8 49 15 00 00       	call   35d7 <exit>
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    208e:	50                   	push   %eax
    208f:	50                   	push   %eax
    2090:	68 ff 42 00 00       	push   $0x42ff
    2095:	6a 01                	push   $0x1
    2097:	e8 5c 16 00 00       	call   36f8 <printf>
    exit();
    209c:	e8 36 15 00 00       	call   35d7 <exit>
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    20a1:	50                   	push   %eax
    20a2:	50                   	push   %eax
    20a3:	68 e6 42 00 00       	push   $0x42e6
    20a8:	6a 01                	push   $0x1
    20aa:	e8 49 16 00 00       	call   36f8 <printf>
    exit();
    20af:	e8 23 15 00 00       	call   35d7 <exit>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    20b4:	50                   	push   %eax
    20b5:	50                   	push   %eax
    20b6:	68 d0 42 00 00       	push   $0x42d0
    20bb:	6a 01                	push   $0x1
    20bd:	e8 36 16 00 00       	call   36f8 <printf>
    exit();
    20c2:	e8 10 15 00 00       	call   35d7 <exit>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    20c7:	50                   	push   %eax
    20c8:	50                   	push   %eax
    20c9:	68 b4 42 00 00       	push   $0x42b4
    20ce:	6a 01                	push   $0x1
    20d0:	e8 23 16 00 00       	call   36f8 <printf>
    exit();
    20d5:	e8 fd 14 00 00       	call   35d7 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    printf(1, "chdir dd failed\n");
    20da:	50                   	push   %eax
    20db:	50                   	push   %eax
    20dc:	68 f5 41 00 00       	push   $0x41f5
    20e1:	6a 01                	push   $0x1
    20e3:	e8 10 16 00 00       	call   36f8 <printf>
    exit();
    20e8:	e8 ea 14 00 00       	call   35d7 <exit>
  if(unlink("dd/dd/ff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    20ed:	52                   	push   %edx
    20ee:	52                   	push   %edx
    20ef:	68 50 4c 00 00       	push   $0x4c50
    20f4:	6a 01                	push   $0x1
    20f6:	e8 fd 15 00 00       	call   36f8 <printf>
    exit();
    20fb:	e8 d7 14 00 00       	call   35d7 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    2100:	53                   	push   %ebx
    2101:	53                   	push   %ebx
    2102:	68 53 41 00 00       	push   $0x4153
    2107:	6a 01                	push   $0x1
    2109:	e8 ea 15 00 00       	call   36f8 <printf>
    exit();
    210e:	e8 c4 14 00 00       	call   35d7 <exit>
  }
  write(fd, "ff", 2);
  close(fd);

  if(unlink("dd") >= 0){
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    2113:	50                   	push   %eax
    2114:	50                   	push   %eax
    2115:	68 04 4c 00 00       	push   $0x4c04
    211a:	6a 01                	push   $0x1
    211c:	e8 d7 15 00 00       	call   36f8 <printf>
    exit();
    2121:	e8 b1 14 00 00       	call   35d7 <exit>
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/ff failed\n");
    2126:	50                   	push   %eax
    2127:	50                   	push   %eax
    2128:	68 37 41 00 00       	push   $0x4137
    212d:	6a 01                	push   $0x1
    212f:	e8 c4 15 00 00       	call   36f8 <printf>
    exit();
    2134:	e8 9e 14 00 00       	call   35d7 <exit>

  printf(1, "subdir test\n");

  unlink("ff");
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    2139:	50                   	push   %eax
    213a:	50                   	push   %eax
    213b:	68 1f 41 00 00       	push   $0x411f
    2140:	6a 01                	push   $0x1
    2142:	e8 b1 15 00 00       	call   36f8 <printf>
    exit();
    2147:	e8 8b 14 00 00       	call   35d7 <exit>
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    printf(1, "unlink dd failed\n");
    214c:	50                   	push   %eax
    214d:	50                   	push   %eax
    214e:	68 08 44 00 00       	push   $0x4408
    2153:	6a 01                	push   $0x1
    2155:	e8 9e 15 00 00       	call   36f8 <printf>
    exit();
    215a:	e8 78 14 00 00       	call   35d7 <exit>
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    215f:	52                   	push   %edx
    2160:	52                   	push   %edx
    2161:	68 f3 43 00 00       	push   $0x43f3
    2166:	6a 01                	push   $0x1
    2168:	e8 8b 15 00 00       	call   36f8 <printf>
    exit();
    216d:	e8 65 14 00 00       	call   35d7 <exit>
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    2172:	51                   	push   %ecx
    2173:	51                   	push   %ecx
    2174:	68 08 4d 00 00       	push   $0x4d08
    2179:	6a 01                	push   $0x1
    217b:	e8 78 15 00 00       	call   36f8 <printf>
    exit();
    2180:	e8 52 14 00 00       	call   35d7 <exit>
  if(unlink("dd/dd/ffff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    2185:	53                   	push   %ebx
    2186:	53                   	push   %ebx
    2187:	68 de 43 00 00       	push   $0x43de
    218c:	6a 01                	push   $0x1
    218e:	e8 65 15 00 00       	call   36f8 <printf>
    exit();
    2193:	e8 3f 14 00 00       	call   35d7 <exit>
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    printf(1, "chdir dd/xx succeeded!\n");
    2198:	50                   	push   %eax
    2199:	50                   	push   %eax
    219a:	68 c6 43 00 00       	push   $0x43c6
    219f:	6a 01                	push   $0x1
    21a1:	e8 52 15 00 00       	call   36f8 <printf>
    exit();
    21a6:	e8 2c 14 00 00       	call   35d7 <exit>
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    21ab:	50                   	push   %eax
    21ac:	50                   	push   %eax
    21ad:	68 ae 43 00 00       	push   $0x43ae
    21b2:	6a 01                	push   $0x1
    21b4:	e8 3f 15 00 00       	call   36f8 <printf>
    exit();
    21b9:	e8 19 14 00 00       	call   35d7 <exit>
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    21be:	50                   	push   %eax
    21bf:	50                   	push   %eax
    21c0:	68 92 43 00 00       	push   $0x4392
    21c5:	6a 01                	push   $0x1
    21c7:	e8 2c 15 00 00       	call   36f8 <printf>
    exit();
    21cc:	e8 06 14 00 00       	call   35d7 <exit>
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    21d1:	50                   	push   %eax
    21d2:	50                   	push   %eax
    21d3:	68 76 43 00 00       	push   $0x4376
    21d8:	6a 01                	push   $0x1
    21da:	e8 19 15 00 00       	call   36f8 <printf>
    exit();
    21df:	e8 f3 13 00 00       	call   35d7 <exit>
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    21e4:	50                   	push   %eax
    21e5:	50                   	push   %eax
    21e6:	68 59 43 00 00       	push   $0x4359
    21eb:	6a 01                	push   $0x1
    21ed:	e8 06 15 00 00       	call   36f8 <printf>
    exit();
    21f2:	e8 e0 13 00 00       	call   35d7 <exit>
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    21f7:	50                   	push   %eax
    21f8:	50                   	push   %eax
    21f9:	68 3e 43 00 00       	push   $0x433e
    21fe:	6a 01                	push   $0x1
    2200:	e8 f3 14 00 00       	call   36f8 <printf>
    exit();
    2205:	e8 cd 13 00 00       	call   35d7 <exit>
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    printf(1, "read dd/dd/ffff wrong len\n");
    220a:	50                   	push   %eax
    220b:	50                   	push   %eax
    220c:	68 6b 42 00 00       	push   $0x426b
    2211:	6a 01                	push   $0x1
    2213:	e8 e0 14 00 00       	call   36f8 <printf>
    exit();
    2218:	e8 ba 13 00 00       	call   35d7 <exit>
    exit();
  }

  fd = open("dd/dd/ffff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    221d:	50                   	push   %eax
    221e:	50                   	push   %eax
    221f:	68 53 42 00 00       	push   $0x4253
    2224:	6a 01                	push   $0x1
    2226:	e8 cd 14 00 00       	call   36f8 <printf>
    exit();
    222b:	e8 a7 13 00 00       	call   35d7 <exit>

00002230 <bigwrite>:
}

// test writes that are larger than the log.
void
bigwrite(void)
{
    2230:	55                   	push   %ebp
    2231:	89 e5                	mov    %esp,%ebp
    2233:	56                   	push   %esi
    2234:	53                   	push   %ebx
  int fd, sz;

  printf(1, "bigwrite test\n");
    2235:	83 ec 08             	sub    $0x8,%esp
    2238:	68 25 44 00 00       	push   $0x4425
    223d:	6a 01                	push   $0x1
    223f:	e8 b4 14 00 00       	call   36f8 <printf>

  unlink("bigwrite");
    2244:	c7 04 24 34 44 00 00 	movl   $0x4434,(%esp)
    224b:	e8 d7 13 00 00       	call   3627 <unlink>
    2250:	83 c4 10             	add    $0x10,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    2253:	bb f3 01 00 00       	mov    $0x1f3,%ebx
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2258:	83 ec 08             	sub    $0x8,%esp
    225b:	68 02 02 00 00       	push   $0x202
    2260:	68 34 44 00 00       	push   $0x4434
    2265:	e8 ad 13 00 00       	call   3617 <open>
    226a:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    226c:	83 c4 10             	add    $0x10,%esp
    226f:	85 c0                	test   %eax,%eax
    2271:	78 7a                	js     22ed <bigwrite+0xbd>
      printf(1, "cannot create bigwrite\n");
      exit();
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
    2273:	52                   	push   %edx
    2274:	53                   	push   %ebx
    2275:	68 40 82 00 00       	push   $0x8240
    227a:	50                   	push   %eax
    227b:	e8 77 13 00 00       	call   35f7 <write>
      if(cc != sz){
    2280:	83 c4 10             	add    $0x10,%esp
    2283:	39 d8                	cmp    %ebx,%eax
    2285:	75 53                	jne    22da <bigwrite+0xaa>
      printf(1, "cannot create bigwrite\n");
      exit();
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
    2287:	50                   	push   %eax
    2288:	53                   	push   %ebx
    2289:	68 40 82 00 00       	push   $0x8240
    228e:	56                   	push   %esi
    228f:	e8 63 13 00 00       	call   35f7 <write>
      if(cc != sz){
    2294:	83 c4 10             	add    $0x10,%esp
    2297:	39 c3                	cmp    %eax,%ebx
    2299:	75 3f                	jne    22da <bigwrite+0xaa>
        printf(1, "write(%d) ret %d\n", sz, cc);
        exit();
      }
    }
    close(fd);
    229b:	83 ec 0c             	sub    $0xc,%esp
    229e:	56                   	push   %esi
    229f:	e8 5b 13 00 00       	call   35ff <close>
    unlink("bigwrite");
    22a4:	c7 04 24 34 44 00 00 	movl   $0x4434,(%esp)
    22ab:	e8 77 13 00 00       	call   3627 <unlink>
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    22b0:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
    22b6:	83 c4 10             	add    $0x10,%esp
    22b9:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    22bf:	75 97                	jne    2258 <bigwrite+0x28>
    }
    close(fd);
    unlink("bigwrite");
  }

  printf(1, "bigwrite ok\n");
    22c1:	83 ec 08             	sub    $0x8,%esp
    22c4:	68 67 44 00 00       	push   $0x4467
    22c9:	6a 01                	push   $0x1
    22cb:	e8 28 14 00 00       	call   36f8 <printf>
    22d0:	83 c4 10             	add    $0x10,%esp
}
    22d3:	8d 65 f8             	lea    -0x8(%ebp),%esp
    22d6:	5b                   	pop    %ebx
    22d7:	5e                   	pop    %esi
    22d8:	5d                   	pop    %ebp
    22d9:	c3                   	ret    
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
    22da:	50                   	push   %eax
    22db:	53                   	push   %ebx
    22dc:	68 55 44 00 00       	push   $0x4455
    22e1:	6a 01                	push   $0x1
    22e3:	e8 10 14 00 00       	call   36f8 <printf>
        exit();
    22e8:	e8 ea 12 00 00       	call   35d7 <exit>

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    fd = open("bigwrite", O_CREATE | O_RDWR);
    if(fd < 0){
      printf(1, "cannot create bigwrite\n");
    22ed:	83 ec 08             	sub    $0x8,%esp
    22f0:	68 3d 44 00 00       	push   $0x443d
    22f5:	6a 01                	push   $0x1
    22f7:	e8 fc 13 00 00       	call   36f8 <printf>
      exit();
    22fc:	e8 d6 12 00 00       	call   35d7 <exit>
    2301:	8d 76 00             	lea    0x0(%esi),%esi

00002304 <bigfile>:
  printf(1, "bigwrite ok\n");
}

void
bigfile(void)
{
    2304:	55                   	push   %ebp
    2305:	89 e5                	mov    %esp,%ebp
    2307:	57                   	push   %edi
    2308:	56                   	push   %esi
    2309:	53                   	push   %ebx
    230a:	83 ec 14             	sub    $0x14,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    230d:	68 74 44 00 00       	push   $0x4474
    2312:	6a 01                	push   $0x1
    2314:	e8 df 13 00 00       	call   36f8 <printf>

  unlink("bigfile");
    2319:	c7 04 24 90 44 00 00 	movl   $0x4490,(%esp)
    2320:	e8 02 13 00 00       	call   3627 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    2325:	58                   	pop    %eax
    2326:	5a                   	pop    %edx
    2327:	68 02 02 00 00       	push   $0x202
    232c:	68 90 44 00 00       	push   $0x4490
    2331:	e8 e1 12 00 00       	call   3617 <open>
    2336:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2338:	83 c4 10             	add    $0x10,%esp
    233b:	85 c0                	test   %eax,%eax
    233d:	0f 88 51 01 00 00    	js     2494 <bigfile+0x190>
    2343:	31 db                	xor    %ebx,%ebx
    2345:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    2348:	57                   	push   %edi
    2349:	68 58 02 00 00       	push   $0x258
    234e:	53                   	push   %ebx
    234f:	68 40 82 00 00       	push   $0x8240
    2354:	e8 4b 11 00 00       	call   34a4 <memset>
    if(write(fd, buf, 600) != 600){
    2359:	83 c4 0c             	add    $0xc,%esp
    235c:	68 58 02 00 00       	push   $0x258
    2361:	68 40 82 00 00       	push   $0x8240
    2366:	56                   	push   %esi
    2367:	e8 8b 12 00 00       	call   35f7 <write>
    236c:	83 c4 10             	add    $0x10,%esp
    236f:	3d 58 02 00 00       	cmp    $0x258,%eax
    2374:	0f 85 f2 00 00 00    	jne    246c <bigfile+0x168>
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    237a:	43                   	inc    %ebx
    237b:	83 fb 14             	cmp    $0x14,%ebx
    237e:	75 c8                	jne    2348 <bigfile+0x44>
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
      exit();
    }
  }
  close(fd);
    2380:	83 ec 0c             	sub    $0xc,%esp
    2383:	56                   	push   %esi
    2384:	e8 76 12 00 00       	call   35ff <close>

  fd = open("bigfile", 0);
    2389:	5b                   	pop    %ebx
    238a:	5e                   	pop    %esi
    238b:	6a 00                	push   $0x0
    238d:	68 90 44 00 00       	push   $0x4490
    2392:	e8 80 12 00 00       	call   3617 <open>
    2397:	89 c7                	mov    %eax,%edi
  if(fd < 0){
    2399:	83 c4 10             	add    $0x10,%esp
    239c:	85 c0                	test   %eax,%eax
    239e:	0f 88 dc 00 00 00    	js     2480 <bigfile+0x17c>
    23a4:	31 f6                	xor    %esi,%esi
    23a6:	31 db                	xor    %ebx,%ebx
    23a8:	eb 2e                	jmp    23d8 <bigfile+0xd4>
    23aa:	66 90                	xchg   %ax,%ax
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
    23ac:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    23b1:	0f 85 8d 00 00 00    	jne    2444 <bigfile+0x140>
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    23b7:	0f be 05 40 82 00 00 	movsbl 0x8240,%eax
    23be:	89 da                	mov    %ebx,%edx
    23c0:	d1 fa                	sar    %edx
    23c2:	39 d0                	cmp    %edx,%eax
    23c4:	75 6a                	jne    2430 <bigfile+0x12c>
    23c6:	0f be 15 6b 83 00 00 	movsbl 0x836b,%edx
    23cd:	39 d0                	cmp    %edx,%eax
    23cf:	75 5f                	jne    2430 <bigfile+0x12c>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
    23d1:	81 c6 2c 01 00 00    	add    $0x12c,%esi
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    exit();
  }
  total = 0;
  for(i = 0; ; i++){
    23d7:	43                   	inc    %ebx
    cc = read(fd, buf, 300);
    23d8:	51                   	push   %ecx
    23d9:	68 2c 01 00 00       	push   $0x12c
    23de:	68 40 82 00 00       	push   $0x8240
    23e3:	57                   	push   %edi
    23e4:	e8 06 12 00 00       	call   35ef <read>
    if(cc < 0){
    23e9:	83 c4 10             	add    $0x10,%esp
    23ec:	85 c0                	test   %eax,%eax
    23ee:	78 68                	js     2458 <bigfile+0x154>
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
    23f0:	75 ba                	jne    23ac <bigfile+0xa8>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
  }
  close(fd);
    23f2:	83 ec 0c             	sub    $0xc,%esp
    23f5:	57                   	push   %edi
    23f6:	e8 04 12 00 00       	call   35ff <close>
  if(total != 20*600){
    23fb:	83 c4 10             	add    $0x10,%esp
    23fe:	81 fe e0 2e 00 00    	cmp    $0x2ee0,%esi
    2404:	0f 85 9e 00 00 00    	jne    24a8 <bigfile+0x1a4>
    printf(1, "read bigfile wrong total\n");
    exit();
  }
  unlink("bigfile");
    240a:	83 ec 0c             	sub    $0xc,%esp
    240d:	68 90 44 00 00       	push   $0x4490
    2412:	e8 10 12 00 00       	call   3627 <unlink>

  printf(1, "bigfile test ok\n");
    2417:	58                   	pop    %eax
    2418:	5a                   	pop    %edx
    2419:	68 1f 45 00 00       	push   $0x451f
    241e:	6a 01                	push   $0x1
    2420:	e8 d3 12 00 00       	call   36f8 <printf>
    2425:	83 c4 10             	add    $0x10,%esp
}
    2428:	8d 65 f4             	lea    -0xc(%ebp),%esp
    242b:	5b                   	pop    %ebx
    242c:	5e                   	pop    %esi
    242d:	5f                   	pop    %edi
    242e:	5d                   	pop    %ebp
    242f:	c3                   	ret    
    if(cc != 300){
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
      printf(1, "read bigfile wrong data\n");
    2430:	83 ec 08             	sub    $0x8,%esp
    2433:	68 ec 44 00 00       	push   $0x44ec
    2438:	6a 01                	push   $0x1
    243a:	e8 b9 12 00 00       	call   36f8 <printf>
      exit();
    243f:	e8 93 11 00 00       	call   35d7 <exit>
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
      printf(1, "short read bigfile\n");
    2444:	83 ec 08             	sub    $0x8,%esp
    2447:	68 d8 44 00 00       	push   $0x44d8
    244c:	6a 01                	push   $0x1
    244e:	e8 a5 12 00 00       	call   36f8 <printf>
      exit();
    2453:	e8 7f 11 00 00       	call   35d7 <exit>
  }
  total = 0;
  for(i = 0; ; i++){
    cc = read(fd, buf, 300);
    if(cc < 0){
      printf(1, "read bigfile failed\n");
    2458:	83 ec 08             	sub    $0x8,%esp
    245b:	68 c3 44 00 00       	push   $0x44c3
    2460:	6a 01                	push   $0x1
    2462:	e8 91 12 00 00       	call   36f8 <printf>
      exit();
    2467:	e8 6b 11 00 00       	call   35d7 <exit>
    exit();
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
    246c:	83 ec 08             	sub    $0x8,%esp
    246f:	68 98 44 00 00       	push   $0x4498
    2474:	6a 01                	push   $0x1
    2476:	e8 7d 12 00 00       	call   36f8 <printf>
      exit();
    247b:	e8 57 11 00 00       	call   35d7 <exit>
  }
  close(fd);

  fd = open("bigfile", 0);
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    2480:	83 ec 08             	sub    $0x8,%esp
    2483:	68 ae 44 00 00       	push   $0x44ae
    2488:	6a 01                	push   $0x1
    248a:	e8 69 12 00 00       	call   36f8 <printf>
    exit();
    248f:	e8 43 11 00 00       	call   35d7 <exit>
  printf(1, "bigfile test\n");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    2494:	83 ec 08             	sub    $0x8,%esp
    2497:	68 82 44 00 00       	push   $0x4482
    249c:	6a 01                	push   $0x1
    249e:	e8 55 12 00 00       	call   36f8 <printf>
    exit();
    24a3:	e8 2f 11 00 00       	call   35d7 <exit>
    }
    total += cc;
  }
  close(fd);
  if(total != 20*600){
    printf(1, "read bigfile wrong total\n");
    24a8:	83 ec 08             	sub    $0x8,%esp
    24ab:	68 05 45 00 00       	push   $0x4505
    24b0:	6a 01                	push   $0x1
    24b2:	e8 41 12 00 00       	call   36f8 <printf>
    exit();
    24b7:	e8 1b 11 00 00       	call   35d7 <exit>

000024bc <fourteen>:
  printf(1, "bigfile test ok\n");
}

void
fourteen(void)
{
    24bc:	55                   	push   %ebp
    24bd:	89 e5                	mov    %esp,%ebp
    24bf:	83 ec 10             	sub    $0x10,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    24c2:	68 30 45 00 00       	push   $0x4530
    24c7:	6a 01                	push   $0x1
    24c9:	e8 2a 12 00 00       	call   36f8 <printf>

  if(mkdir("12345678901234") != 0){
    24ce:	c7 04 24 6b 45 00 00 	movl   $0x456b,(%esp)
    24d5:	e8 65 11 00 00       	call   363f <mkdir>
    24da:	83 c4 10             	add    $0x10,%esp
    24dd:	85 c0                	test   %eax,%eax
    24df:	0f 85 97 00 00 00    	jne    257c <fourteen+0xc0>
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    24e5:	83 ec 0c             	sub    $0xc,%esp
    24e8:	68 28 4d 00 00       	push   $0x4d28
    24ed:	e8 4d 11 00 00       	call   363f <mkdir>
    24f2:	83 c4 10             	add    $0x10,%esp
    24f5:	85 c0                	test   %eax,%eax
    24f7:	0f 85 de 00 00 00    	jne    25db <fourteen+0x11f>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    24fd:	83 ec 08             	sub    $0x8,%esp
    2500:	68 00 02 00 00       	push   $0x200
    2505:	68 78 4d 00 00       	push   $0x4d78
    250a:	e8 08 11 00 00       	call   3617 <open>
  if(fd < 0){
    250f:	83 c4 10             	add    $0x10,%esp
    2512:	85 c0                	test   %eax,%eax
    2514:	0f 88 ae 00 00 00    	js     25c8 <fourteen+0x10c>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    exit();
  }
  close(fd);
    251a:	83 ec 0c             	sub    $0xc,%esp
    251d:	50                   	push   %eax
    251e:	e8 dc 10 00 00       	call   35ff <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2523:	58                   	pop    %eax
    2524:	5a                   	pop    %edx
    2525:	6a 00                	push   $0x0
    2527:	68 e8 4d 00 00       	push   $0x4de8
    252c:	e8 e6 10 00 00       	call   3617 <open>
  if(fd < 0){
    2531:	83 c4 10             	add    $0x10,%esp
    2534:	85 c0                	test   %eax,%eax
    2536:	78 7d                	js     25b5 <fourteen+0xf9>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    exit();
  }
  close(fd);
    2538:	83 ec 0c             	sub    $0xc,%esp
    253b:	50                   	push   %eax
    253c:	e8 be 10 00 00       	call   35ff <close>

  if(mkdir("12345678901234/12345678901234") == 0){
    2541:	c7 04 24 5c 45 00 00 	movl   $0x455c,(%esp)
    2548:	e8 f2 10 00 00       	call   363f <mkdir>
    254d:	83 c4 10             	add    $0x10,%esp
    2550:	85 c0                	test   %eax,%eax
    2552:	74 4e                	je     25a2 <fourteen+0xe6>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    2554:	83 ec 0c             	sub    $0xc,%esp
    2557:	68 84 4e 00 00       	push   $0x4e84
    255c:	e8 de 10 00 00       	call   363f <mkdir>
    2561:	83 c4 10             	add    $0x10,%esp
    2564:	85 c0                	test   %eax,%eax
    2566:	74 27                	je     258f <fourteen+0xd3>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    exit();
  }

  printf(1, "fourteen ok\n");
    2568:	83 ec 08             	sub    $0x8,%esp
    256b:	68 7a 45 00 00       	push   $0x457a
    2570:	6a 01                	push   $0x1
    2572:	e8 81 11 00 00       	call   36f8 <printf>
    2577:	83 c4 10             	add    $0x10,%esp
}
    257a:	c9                   	leave  
    257b:	c3                   	ret    

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");

  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    257c:	50                   	push   %eax
    257d:	50                   	push   %eax
    257e:	68 3f 45 00 00       	push   $0x453f
    2583:	6a 01                	push   $0x1
    2585:	e8 6e 11 00 00       	call   36f8 <printf>
    exit();
    258a:	e8 48 10 00 00       	call   35d7 <exit>
  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    258f:	50                   	push   %eax
    2590:	50                   	push   %eax
    2591:	68 a4 4e 00 00       	push   $0x4ea4
    2596:	6a 01                	push   $0x1
    2598:	e8 5b 11 00 00       	call   36f8 <printf>
    exit();
    259d:	e8 35 10 00 00       	call   35d7 <exit>
    exit();
  }
  close(fd);

  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    25a2:	52                   	push   %edx
    25a3:	52                   	push   %edx
    25a4:	68 54 4e 00 00       	push   $0x4e54
    25a9:	6a 01                	push   $0x1
    25ab:	e8 48 11 00 00       	call   36f8 <printf>
    exit();
    25b0:	e8 22 10 00 00       	call   35d7 <exit>
    exit();
  }
  close(fd);
  fd = open("12345678901234/12345678901234/12345678901234", 0);
  if(fd < 0){
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    25b5:	51                   	push   %ecx
    25b6:	51                   	push   %ecx
    25b7:	68 18 4e 00 00       	push   $0x4e18
    25bc:	6a 01                	push   $0x1
    25be:	e8 35 11 00 00       	call   36f8 <printf>
    exit();
    25c3:	e8 0f 10 00 00       	call   35d7 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
  if(fd < 0){
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    25c8:	51                   	push   %ecx
    25c9:	51                   	push   %ecx
    25ca:	68 a8 4d 00 00       	push   $0x4da8
    25cf:	6a 01                	push   $0x1
    25d1:	e8 22 11 00 00       	call   36f8 <printf>
    exit();
    25d6:	e8 fc 0f 00 00       	call   35d7 <exit>
  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    25db:	50                   	push   %eax
    25dc:	50                   	push   %eax
    25dd:	68 48 4d 00 00       	push   $0x4d48
    25e2:	6a 01                	push   $0x1
    25e4:	e8 0f 11 00 00       	call   36f8 <printf>
    exit();
    25e9:	e8 e9 0f 00 00       	call   35d7 <exit>
    25ee:	66 90                	xchg   %ax,%ax

000025f0 <rmdot>:
  printf(1, "fourteen ok\n");
}

void
rmdot(void)
{
    25f0:	55                   	push   %ebp
    25f1:	89 e5                	mov    %esp,%ebp
    25f3:	83 ec 10             	sub    $0x10,%esp
  printf(1, "rmdot test\n");
    25f6:	68 87 45 00 00       	push   $0x4587
    25fb:	6a 01                	push   $0x1
    25fd:	e8 f6 10 00 00       	call   36f8 <printf>
  if(mkdir("dots") != 0){
    2602:	c7 04 24 93 45 00 00 	movl   $0x4593,(%esp)
    2609:	e8 31 10 00 00       	call   363f <mkdir>
    260e:	83 c4 10             	add    $0x10,%esp
    2611:	85 c0                	test   %eax,%eax
    2613:	0f 85 b0 00 00 00    	jne    26c9 <rmdot+0xd9>
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
    2619:	83 ec 0c             	sub    $0xc,%esp
    261c:	68 93 45 00 00       	push   $0x4593
    2621:	e8 21 10 00 00       	call   3647 <chdir>
    2626:	83 c4 10             	add    $0x10,%esp
    2629:	85 c0                	test   %eax,%eax
    262b:	0f 85 1d 01 00 00    	jne    274e <rmdot+0x15e>
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
    2631:	83 ec 0c             	sub    $0xc,%esp
    2634:	68 3e 42 00 00       	push   $0x423e
    2639:	e8 e9 0f 00 00       	call   3627 <unlink>
    263e:	83 c4 10             	add    $0x10,%esp
    2641:	85 c0                	test   %eax,%eax
    2643:	0f 84 f2 00 00 00    	je     273b <rmdot+0x14b>
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
    2649:	83 ec 0c             	sub    $0xc,%esp
    264c:	68 3d 42 00 00       	push   $0x423d
    2651:	e8 d1 0f 00 00       	call   3627 <unlink>
    2656:	83 c4 10             	add    $0x10,%esp
    2659:	85 c0                	test   %eax,%eax
    265b:	0f 84 c7 00 00 00    	je     2728 <rmdot+0x138>
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
    2661:	83 ec 0c             	sub    $0xc,%esp
    2664:	68 11 3a 00 00       	push   $0x3a11
    2669:	e8 d9 0f 00 00       	call   3647 <chdir>
    266e:	83 c4 10             	add    $0x10,%esp
    2671:	85 c0                	test   %eax,%eax
    2673:	0f 85 9c 00 00 00    	jne    2715 <rmdot+0x125>
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
    2679:	83 ec 0c             	sub    $0xc,%esp
    267c:	68 db 45 00 00       	push   $0x45db
    2681:	e8 a1 0f 00 00       	call   3627 <unlink>
    2686:	83 c4 10             	add    $0x10,%esp
    2689:	85 c0                	test   %eax,%eax
    268b:	74 75                	je     2702 <rmdot+0x112>
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
    268d:	83 ec 0c             	sub    $0xc,%esp
    2690:	68 f9 45 00 00       	push   $0x45f9
    2695:	e8 8d 0f 00 00       	call   3627 <unlink>
    269a:	83 c4 10             	add    $0x10,%esp
    269d:	85 c0                	test   %eax,%eax
    269f:	74 4e                	je     26ef <rmdot+0xff>
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
    26a1:	83 ec 0c             	sub    $0xc,%esp
    26a4:	68 93 45 00 00       	push   $0x4593
    26a9:	e8 79 0f 00 00       	call   3627 <unlink>
    26ae:	83 c4 10             	add    $0x10,%esp
    26b1:	85 c0                	test   %eax,%eax
    26b3:	75 27                	jne    26dc <rmdot+0xec>
    printf(1, "unlink dots failed!\n");
    exit();
  }
  printf(1, "rmdot ok\n");
    26b5:	83 ec 08             	sub    $0x8,%esp
    26b8:	68 2e 46 00 00       	push   $0x462e
    26bd:	6a 01                	push   $0x1
    26bf:	e8 34 10 00 00       	call   36f8 <printf>
    26c4:	83 c4 10             	add    $0x10,%esp
}
    26c7:	c9                   	leave  
    26c8:	c3                   	ret    
void
rmdot(void)
{
  printf(1, "rmdot test\n");
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    26c9:	50                   	push   %eax
    26ca:	50                   	push   %eax
    26cb:	68 98 45 00 00       	push   $0x4598
    26d0:	6a 01                	push   $0x1
    26d2:	e8 21 10 00 00       	call   36f8 <printf>
    exit();
    26d7:	e8 fb 0e 00 00       	call   35d7 <exit>
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
    printf(1, "unlink dots failed!\n");
    26dc:	50                   	push   %eax
    26dd:	50                   	push   %eax
    26de:	68 19 46 00 00       	push   $0x4619
    26e3:	6a 01                	push   $0x1
    26e5:	e8 0e 10 00 00       	call   36f8 <printf>
    exit();
    26ea:	e8 e8 0e 00 00       	call   35d7 <exit>
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    26ef:	52                   	push   %edx
    26f0:	52                   	push   %edx
    26f1:	68 01 46 00 00       	push   $0x4601
    26f6:	6a 01                	push   $0x1
    26f8:	e8 fb 0f 00 00       	call   36f8 <printf>
    exit();
    26fd:	e8 d5 0e 00 00       	call   35d7 <exit>
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    2702:	51                   	push   %ecx
    2703:	51                   	push   %ecx
    2704:	68 e2 45 00 00       	push   $0x45e2
    2709:	6a 01                	push   $0x1
    270b:	e8 e8 0f 00 00       	call   36f8 <printf>
    exit();
    2710:	e8 c2 0e 00 00       	call   35d7 <exit>
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    2715:	50                   	push   %eax
    2716:	50                   	push   %eax
    2717:	68 13 3a 00 00       	push   $0x3a13
    271c:	6a 01                	push   $0x1
    271e:	e8 d5 0f 00 00       	call   36f8 <printf>
    exit();
    2723:	e8 af 0e 00 00       	call   35d7 <exit>
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    2728:	50                   	push   %eax
    2729:	50                   	push   %eax
    272a:	68 cc 45 00 00       	push   $0x45cc
    272f:	6a 01                	push   $0x1
    2731:	e8 c2 0f 00 00       	call   36f8 <printf>
    exit();
    2736:	e8 9c 0e 00 00       	call   35d7 <exit>
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    273b:	50                   	push   %eax
    273c:	50                   	push   %eax
    273d:	68 be 45 00 00       	push   $0x45be
    2742:	6a 01                	push   $0x1
    2744:	e8 af 0f 00 00       	call   36f8 <printf>
    exit();
    2749:	e8 89 0e 00 00       	call   35d7 <exit>
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    274e:	50                   	push   %eax
    274f:	50                   	push   %eax
    2750:	68 ab 45 00 00       	push   $0x45ab
    2755:	6a 01                	push   $0x1
    2757:	e8 9c 0f 00 00       	call   36f8 <printf>
    exit();
    275c:	e8 76 0e 00 00       	call   35d7 <exit>
    2761:	8d 76 00             	lea    0x0(%esi),%esi

00002764 <dirfile>:
  printf(1, "rmdot ok\n");
}

void
dirfile(void)
{
    2764:	55                   	push   %ebp
    2765:	89 e5                	mov    %esp,%ebp
    2767:	53                   	push   %ebx
    2768:	83 ec 0c             	sub    $0xc,%esp
  int fd;

  printf(1, "dir vs file\n");
    276b:	68 38 46 00 00       	push   $0x4638
    2770:	6a 01                	push   $0x1
    2772:	e8 81 0f 00 00       	call   36f8 <printf>

  fd = open("dirfile", O_CREATE);
    2777:	59                   	pop    %ecx
    2778:	5b                   	pop    %ebx
    2779:	68 00 02 00 00       	push   $0x200
    277e:	68 45 46 00 00       	push   $0x4645
    2783:	e8 8f 0e 00 00       	call   3617 <open>
  if(fd < 0){
    2788:	83 c4 10             	add    $0x10,%esp
    278b:	85 c0                	test   %eax,%eax
    278d:	0f 88 43 01 00 00    	js     28d6 <dirfile+0x172>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
    2793:	83 ec 0c             	sub    $0xc,%esp
    2796:	50                   	push   %eax
    2797:	e8 63 0e 00 00       	call   35ff <close>
  if(chdir("dirfile") == 0){
    279c:	c7 04 24 45 46 00 00 	movl   $0x4645,(%esp)
    27a3:	e8 9f 0e 00 00       	call   3647 <chdir>
    27a8:	83 c4 10             	add    $0x10,%esp
    27ab:	85 c0                	test   %eax,%eax
    27ad:	0f 84 10 01 00 00    	je     28c3 <dirfile+0x15f>
    printf(1, "chdir dirfile succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", 0);
    27b3:	83 ec 08             	sub    $0x8,%esp
    27b6:	6a 00                	push   $0x0
    27b8:	68 7e 46 00 00       	push   $0x467e
    27bd:	e8 55 0e 00 00       	call   3617 <open>
  if(fd >= 0){
    27c2:	83 c4 10             	add    $0x10,%esp
    27c5:	85 c0                	test   %eax,%eax
    27c7:	0f 89 e3 00 00 00    	jns    28b0 <dirfile+0x14c>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", O_CREATE);
    27cd:	83 ec 08             	sub    $0x8,%esp
    27d0:	68 00 02 00 00       	push   $0x200
    27d5:	68 7e 46 00 00       	push   $0x467e
    27da:	e8 38 0e 00 00       	call   3617 <open>
  if(fd >= 0){
    27df:	83 c4 10             	add    $0x10,%esp
    27e2:	85 c0                	test   %eax,%eax
    27e4:	0f 89 c6 00 00 00    	jns    28b0 <dirfile+0x14c>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
    27ea:	83 ec 0c             	sub    $0xc,%esp
    27ed:	68 7e 46 00 00       	push   $0x467e
    27f2:	e8 48 0e 00 00       	call   363f <mkdir>
    27f7:	83 c4 10             	add    $0x10,%esp
    27fa:	85 c0                	test   %eax,%eax
    27fc:	0f 84 46 01 00 00    	je     2948 <dirfile+0x1e4>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
    2802:	83 ec 0c             	sub    $0xc,%esp
    2805:	68 7e 46 00 00       	push   $0x467e
    280a:	e8 18 0e 00 00       	call   3627 <unlink>
    280f:	83 c4 10             	add    $0x10,%esp
    2812:	85 c0                	test   %eax,%eax
    2814:	0f 84 1b 01 00 00    	je     2935 <dirfile+0x1d1>
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
    281a:	83 ec 08             	sub    $0x8,%esp
    281d:	68 7e 46 00 00       	push   $0x467e
    2822:	68 e2 46 00 00       	push   $0x46e2
    2827:	e8 0b 0e 00 00       	call   3637 <link>
    282c:	83 c4 10             	add    $0x10,%esp
    282f:	85 c0                	test   %eax,%eax
    2831:	0f 84 eb 00 00 00    	je     2922 <dirfile+0x1be>
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
    2837:	83 ec 0c             	sub    $0xc,%esp
    283a:	68 45 46 00 00       	push   $0x4645
    283f:	e8 e3 0d 00 00       	call   3627 <unlink>
    2844:	83 c4 10             	add    $0x10,%esp
    2847:	85 c0                	test   %eax,%eax
    2849:	0f 85 c0 00 00 00    	jne    290f <dirfile+0x1ab>
    printf(1, "unlink dirfile failed!\n");
    exit();
  }

  fd = open(".", O_RDWR);
    284f:	83 ec 08             	sub    $0x8,%esp
    2852:	6a 02                	push   $0x2
    2854:	68 3e 42 00 00       	push   $0x423e
    2859:	e8 b9 0d 00 00       	call   3617 <open>
  if(fd >= 0){
    285e:	83 c4 10             	add    $0x10,%esp
    2861:	85 c0                	test   %eax,%eax
    2863:	0f 89 93 00 00 00    	jns    28fc <dirfile+0x198>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
    2869:	83 ec 08             	sub    $0x8,%esp
    286c:	6a 00                	push   $0x0
    286e:	68 3e 42 00 00       	push   $0x423e
    2873:	e8 9f 0d 00 00       	call   3617 <open>
    2878:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    287a:	83 c4 0c             	add    $0xc,%esp
    287d:	6a 01                	push   $0x1
    287f:	68 21 43 00 00       	push   $0x4321
    2884:	50                   	push   %eax
    2885:	e8 6d 0d 00 00       	call   35f7 <write>
    288a:	83 c4 10             	add    $0x10,%esp
    288d:	85 c0                	test   %eax,%eax
    288f:	7f 58                	jg     28e9 <dirfile+0x185>
    printf(1, "write . succeeded!\n");
    exit();
  }
  close(fd);
    2891:	83 ec 0c             	sub    $0xc,%esp
    2894:	53                   	push   %ebx
    2895:	e8 65 0d 00 00       	call   35ff <close>

  printf(1, "dir vs file OK\n");
    289a:	58                   	pop    %eax
    289b:	5a                   	pop    %edx
    289c:	68 15 47 00 00       	push   $0x4715
    28a1:	6a 01                	push   $0x1
    28a3:	e8 50 0e 00 00       	call   36f8 <printf>
    28a8:	83 c4 10             	add    $0x10,%esp
}
    28ab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    28ae:	c9                   	leave  
    28af:	c3                   	ret    
    printf(1, "chdir dirfile succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", 0);
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    28b0:	50                   	push   %eax
    28b1:	50                   	push   %eax
    28b2:	68 89 46 00 00       	push   $0x4689
    28b7:	6a 01                	push   $0x1
    28b9:	e8 3a 0e 00 00       	call   36f8 <printf>
    exit();
    28be:	e8 14 0d 00 00       	call   35d7 <exit>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
  if(chdir("dirfile") == 0){
    printf(1, "chdir dirfile succeeded!\n");
    28c3:	50                   	push   %eax
    28c4:	50                   	push   %eax
    28c5:	68 64 46 00 00       	push   $0x4664
    28ca:	6a 01                	push   $0x1
    28cc:	e8 27 0e 00 00       	call   36f8 <printf>
    exit();
    28d1:	e8 01 0d 00 00       	call   35d7 <exit>

  printf(1, "dir vs file\n");

  fd = open("dirfile", O_CREATE);
  if(fd < 0){
    printf(1, "create dirfile failed\n");
    28d6:	52                   	push   %edx
    28d7:	52                   	push   %edx
    28d8:	68 4d 46 00 00       	push   $0x464d
    28dd:	6a 01                	push   $0x1
    28df:	e8 14 0e 00 00       	call   36f8 <printf>
    exit();
    28e4:	e8 ee 0c 00 00       	call   35d7 <exit>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
  if(write(fd, "x", 1) > 0){
    printf(1, "write . succeeded!\n");
    28e9:	51                   	push   %ecx
    28ea:	51                   	push   %ecx
    28eb:	68 01 47 00 00       	push   $0x4701
    28f0:	6a 01                	push   $0x1
    28f2:	e8 01 0e 00 00       	call   36f8 <printf>
    exit();
    28f7:	e8 db 0c 00 00       	call   35d7 <exit>
    exit();
  }

  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
    28fc:	53                   	push   %ebx
    28fd:	53                   	push   %ebx
    28fe:	68 f8 4e 00 00       	push   $0x4ef8
    2903:	6a 01                	push   $0x1
    2905:	e8 ee 0d 00 00       	call   36f8 <printf>
    exit();
    290a:	e8 c8 0c 00 00       	call   35d7 <exit>
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
    printf(1, "unlink dirfile failed!\n");
    290f:	50                   	push   %eax
    2910:	50                   	push   %eax
    2911:	68 e9 46 00 00       	push   $0x46e9
    2916:	6a 01                	push   $0x1
    2918:	e8 db 0d 00 00       	call   36f8 <printf>
    exit();
    291d:	e8 b5 0c 00 00       	call   35d7 <exit>
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    2922:	50                   	push   %eax
    2923:	50                   	push   %eax
    2924:	68 d8 4e 00 00       	push   $0x4ed8
    2929:	6a 01                	push   $0x1
    292b:	e8 c8 0d 00 00       	call   36f8 <printf>
    exit();
    2930:	e8 a2 0c 00 00       	call   35d7 <exit>
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    2935:	50                   	push   %eax
    2936:	50                   	push   %eax
    2937:	68 c4 46 00 00       	push   $0x46c4
    293c:	6a 01                	push   $0x1
    293e:	e8 b5 0d 00 00       	call   36f8 <printf>
    exit();
    2943:	e8 8f 0c 00 00       	call   35d7 <exit>
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2948:	50                   	push   %eax
    2949:	50                   	push   %eax
    294a:	68 a7 46 00 00       	push   $0x46a7
    294f:	6a 01                	push   $0x1
    2951:	e8 a2 0d 00 00       	call   36f8 <printf>
    exit();
    2956:	e8 7c 0c 00 00       	call   35d7 <exit>
    295b:	90                   	nop

0000295c <iref>:
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
    295c:	55                   	push   %ebp
    295d:	89 e5                	mov    %esp,%ebp
    295f:	53                   	push   %ebx
    2960:	83 ec 0c             	sub    $0xc,%esp
  int i, fd;

  printf(1, "empty file name\n");
    2963:	68 25 47 00 00       	push   $0x4725
    2968:	6a 01                	push   $0x1
    296a:	e8 89 0d 00 00       	call   36f8 <printf>
    296f:	83 c4 10             	add    $0x10,%esp
    2972:	bb 33 00 00 00       	mov    $0x33,%ebx
    2977:	90                   	nop

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
    2978:	83 ec 0c             	sub    $0xc,%esp
    297b:	68 36 47 00 00       	push   $0x4736
    2980:	e8 ba 0c 00 00       	call   363f <mkdir>
    2985:	83 c4 10             	add    $0x10,%esp
    2988:	85 c0                	test   %eax,%eax
    298a:	0f 85 b9 00 00 00    	jne    2a49 <iref+0xed>
      printf(1, "mkdir irefd failed\n");
      exit();
    }
    if(chdir("irefd") != 0){
    2990:	83 ec 0c             	sub    $0xc,%esp
    2993:	68 36 47 00 00       	push   $0x4736
    2998:	e8 aa 0c 00 00       	call   3647 <chdir>
    299d:	83 c4 10             	add    $0x10,%esp
    29a0:	85 c0                	test   %eax,%eax
    29a2:	0f 85 b5 00 00 00    	jne    2a5d <iref+0x101>
      printf(1, "chdir irefd failed\n");
      exit();
    }

    mkdir("");
    29a8:	83 ec 0c             	sub    $0xc,%esp
    29ab:	68 eb 3d 00 00       	push   $0x3deb
    29b0:	e8 8a 0c 00 00       	call   363f <mkdir>
    link("README", "");
    29b5:	59                   	pop    %ecx
    29b6:	58                   	pop    %eax
    29b7:	68 eb 3d 00 00       	push   $0x3deb
    29bc:	68 e2 46 00 00       	push   $0x46e2
    29c1:	e8 71 0c 00 00       	call   3637 <link>
    fd = open("", O_CREATE);
    29c6:	58                   	pop    %eax
    29c7:	5a                   	pop    %edx
    29c8:	68 00 02 00 00       	push   $0x200
    29cd:	68 eb 3d 00 00       	push   $0x3deb
    29d2:	e8 40 0c 00 00       	call   3617 <open>
    if(fd >= 0)
    29d7:	83 c4 10             	add    $0x10,%esp
    29da:	85 c0                	test   %eax,%eax
    29dc:	78 0c                	js     29ea <iref+0x8e>
      close(fd);
    29de:	83 ec 0c             	sub    $0xc,%esp
    29e1:	50                   	push   %eax
    29e2:	e8 18 0c 00 00       	call   35ff <close>
    29e7:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    29ea:	83 ec 08             	sub    $0x8,%esp
    29ed:	68 00 02 00 00       	push   $0x200
    29f2:	68 20 43 00 00       	push   $0x4320
    29f7:	e8 1b 0c 00 00       	call   3617 <open>
    if(fd >= 0)
    29fc:	83 c4 10             	add    $0x10,%esp
    29ff:	85 c0                	test   %eax,%eax
    2a01:	78 0c                	js     2a0f <iref+0xb3>
      close(fd);
    2a03:	83 ec 0c             	sub    $0xc,%esp
    2a06:	50                   	push   %eax
    2a07:	e8 f3 0b 00 00       	call   35ff <close>
    2a0c:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    2a0f:	83 ec 0c             	sub    $0xc,%esp
    2a12:	68 20 43 00 00       	push   $0x4320
    2a17:	e8 0b 0c 00 00       	call   3627 <unlink>
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2a1c:	83 c4 10             	add    $0x10,%esp
    2a1f:	4b                   	dec    %ebx
    2a20:	0f 85 52 ff ff ff    	jne    2978 <iref+0x1c>
    if(fd >= 0)
      close(fd);
    unlink("xx");
  }

  chdir("/");
    2a26:	83 ec 0c             	sub    $0xc,%esp
    2a29:	68 11 3a 00 00       	push   $0x3a11
    2a2e:	e8 14 0c 00 00       	call   3647 <chdir>
  printf(1, "empty file name OK\n");
    2a33:	58                   	pop    %eax
    2a34:	5a                   	pop    %edx
    2a35:	68 64 47 00 00       	push   $0x4764
    2a3a:	6a 01                	push   $0x1
    2a3c:	e8 b7 0c 00 00       	call   36f8 <printf>
    2a41:	83 c4 10             	add    $0x10,%esp
}
    2a44:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2a47:	c9                   	leave  
    2a48:	c3                   	ret    
  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
      printf(1, "mkdir irefd failed\n");
    2a49:	83 ec 08             	sub    $0x8,%esp
    2a4c:	68 3c 47 00 00       	push   $0x473c
    2a51:	6a 01                	push   $0x1
    2a53:	e8 a0 0c 00 00       	call   36f8 <printf>
      exit();
    2a58:	e8 7a 0b 00 00       	call   35d7 <exit>
    }
    if(chdir("irefd") != 0){
      printf(1, "chdir irefd failed\n");
    2a5d:	83 ec 08             	sub    $0x8,%esp
    2a60:	68 50 47 00 00       	push   $0x4750
    2a65:	6a 01                	push   $0x1
    2a67:	e8 8c 0c 00 00       	call   36f8 <printf>
      exit();
    2a6c:	e8 66 0b 00 00       	call   35d7 <exit>
    2a71:	8d 76 00             	lea    0x0(%esi),%esi

00002a74 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    2a74:	55                   	push   %ebp
    2a75:	89 e5                	mov    %esp,%ebp
    2a77:	53                   	push   %ebx
    2a78:	83 ec 0c             	sub    $0xc,%esp
  int n, pid;

  printf(1, "fork test\n");
    2a7b:	68 78 47 00 00       	push   $0x4778
    2a80:	6a 01                	push   $0x1
    2a82:	e8 71 0c 00 00       	call   36f8 <printf>
    2a87:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<1000; n++){
    2a8a:	31 db                	xor    %ebx,%ebx
    2a8c:	eb 0d                	jmp    2a9b <forktest+0x27>
    2a8e:	66 90                	xchg   %ax,%ax
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
    2a90:	74 52                	je     2ae4 <forktest+0x70>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
    2a92:	43                   	inc    %ebx
    2a93:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2a99:	74 35                	je     2ad0 <forktest+0x5c>
    pid = fork();
    2a9b:	e8 2f 0b 00 00       	call   35cf <fork>
    if(pid < 0)
    2aa0:	85 c0                	test   %eax,%eax
    2aa2:	79 ec                	jns    2a90 <forktest+0x1c>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }

  for(; n > 0; n--){
    2aa4:	85 db                	test   %ebx,%ebx
    2aa6:	74 0c                	je     2ab4 <forktest+0x40>
    if(wait() < 0){
    2aa8:	e8 32 0b 00 00       	call   35df <wait>
    2aad:	85 c0                	test   %eax,%eax
    2aaf:	78 38                	js     2ae9 <forktest+0x75>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }

  for(; n > 0; n--){
    2ab1:	4b                   	dec    %ebx
    2ab2:	75 f4                	jne    2aa8 <forktest+0x34>
      printf(1, "wait stopped early\n");
      exit();
    }
  }

  if(wait() != -1){
    2ab4:	e8 26 0b 00 00       	call   35df <wait>
    2ab9:	40                   	inc    %eax
    2aba:	75 41                	jne    2afd <forktest+0x89>
    printf(1, "wait got too many\n");
    exit();
  }

  printf(1, "fork test OK\n");
    2abc:	83 ec 08             	sub    $0x8,%esp
    2abf:	68 aa 47 00 00       	push   $0x47aa
    2ac4:	6a 01                	push   $0x1
    2ac6:	e8 2d 0c 00 00       	call   36f8 <printf>
}
    2acb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2ace:	c9                   	leave  
    2acf:	c3                   	ret    
    if(pid == 0)
      exit();
  }

  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    2ad0:	83 ec 08             	sub    $0x8,%esp
    2ad3:	68 18 4f 00 00       	push   $0x4f18
    2ad8:	6a 01                	push   $0x1
    2ada:	e8 19 0c 00 00       	call   36f8 <printf>
    exit();
    2adf:	e8 f3 0a 00 00       	call   35d7 <exit>
  for(n=0; n<1000; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
      exit();
    2ae4:	e8 ee 0a 00 00       	call   35d7 <exit>
    exit();
  }

  for(; n > 0; n--){
    if(wait() < 0){
      printf(1, "wait stopped early\n");
    2ae9:	83 ec 08             	sub    $0x8,%esp
    2aec:	68 83 47 00 00       	push   $0x4783
    2af1:	6a 01                	push   $0x1
    2af3:	e8 00 0c 00 00       	call   36f8 <printf>
      exit();
    2af8:	e8 da 0a 00 00       	call   35d7 <exit>
    }
  }

  if(wait() != -1){
    printf(1, "wait got too many\n");
    2afd:	83 ec 08             	sub    $0x8,%esp
    2b00:	68 97 47 00 00       	push   $0x4797
    2b05:	6a 01                	push   $0x1
    2b07:	e8 ec 0b 00 00       	call   36f8 <printf>
    exit();
    2b0c:	e8 c6 0a 00 00       	call   35d7 <exit>
    2b11:	8d 76 00             	lea    0x0(%esi),%esi

00002b14 <sbrktest>:
  printf(1, "fork test OK\n");
}

void
sbrktest(void)
{
    2b14:	55                   	push   %ebp
    2b15:	89 e5                	mov    %esp,%ebp
    2b17:	57                   	push   %edi
    2b18:	56                   	push   %esi
    2b19:	53                   	push   %ebx
    2b1a:	83 ec 64             	sub    $0x64,%esp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    2b1d:	68 b8 47 00 00       	push   $0x47b8
    2b22:	ff 35 58 5a 00 00    	pushl  0x5a58
    2b28:	e8 cb 0b 00 00       	call   36f8 <printf>
  oldbrk = sbrk(0);
    2b2d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b34:	e8 26 0b 00 00       	call   365f <sbrk>
    2b39:	89 45 a4             	mov    %eax,-0x5c(%ebp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    2b3c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b43:	e8 17 0b 00 00       	call   365f <sbrk>
    2b48:	89 c3                	mov    %eax,%ebx
    2b4a:	83 c4 10             	add    $0x10,%esp
  int i;
  for(i = 0; i < 5000; i++){
    2b4d:	31 ff                	xor    %edi,%edi
    2b4f:	90                   	nop
    b = sbrk(1);
    2b50:	83 ec 0c             	sub    $0xc,%esp
    2b53:	6a 01                	push   $0x1
    2b55:	e8 05 0b 00 00       	call   365f <sbrk>
    if(b != a){
    2b5a:	83 c4 10             	add    $0x10,%esp
    2b5d:	39 d8                	cmp    %ebx,%eax
    2b5f:	0f 85 71 02 00 00    	jne    2dd6 <sbrktest+0x2c2>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
      exit();
    }
    *b = 1;
    2b65:	c6 03 01             	movb   $0x1,(%ebx)
    a = b + 1;
    2b68:	43                   	inc    %ebx
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    2b69:	47                   	inc    %edi
    2b6a:	81 ff 88 13 00 00    	cmp    $0x1388,%edi
    2b70:	75 de                	jne    2b50 <sbrktest+0x3c>
      exit();
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
    2b72:	e8 58 0a 00 00       	call   35cf <fork>
    2b77:	89 c7                	mov    %eax,%edi
  if(pid < 0){
    2b79:	85 c0                	test   %eax,%eax
    2b7b:	0f 88 83 03 00 00    	js     2f04 <sbrktest+0x3f0>
    printf(stdout, "sbrk test fork failed\n");
    exit();
  }
  c = sbrk(1);
    2b81:	83 ec 0c             	sub    $0xc,%esp
    2b84:	6a 01                	push   $0x1
    2b86:	e8 d4 0a 00 00       	call   365f <sbrk>
  c = sbrk(1);
    2b8b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b92:	e8 c8 0a 00 00       	call   365f <sbrk>
  if(c != a + 1){
    2b97:	43                   	inc    %ebx
    2b98:	83 c4 10             	add    $0x10,%esp
    2b9b:	39 d8                	cmp    %ebx,%eax
    2b9d:	0f 85 49 03 00 00    	jne    2eec <sbrktest+0x3d8>
    printf(stdout, "sbrk test failed post-fork\n");
    exit();
  }
  if(pid == 0)
    2ba3:	85 ff                	test   %edi,%edi
    2ba5:	0f 84 3c 03 00 00    	je     2ee7 <sbrktest+0x3d3>
    exit();
  wait();
    2bab:	e8 2f 0a 00 00       	call   35df <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    2bb0:	83 ec 0c             	sub    $0xc,%esp
    2bb3:	6a 00                	push   $0x0
    2bb5:	e8 a5 0a 00 00       	call   365f <sbrk>
    2bba:	89 c3                	mov    %eax,%ebx
  amt = (BIG) - (uint)a;
    2bbc:	ba 00 00 40 06       	mov    $0x6400000,%edx
    2bc1:	29 c2                	sub    %eax,%edx
  p = sbrk(amt);
    2bc3:	89 14 24             	mov    %edx,(%esp)
    2bc6:	e8 94 0a 00 00       	call   365f <sbrk>
  if (p != a) {
    2bcb:	83 c4 10             	add    $0x10,%esp
    2bce:	39 d8                	cmp    %ebx,%eax
    2bd0:	0f 85 f9 02 00 00    	jne    2ecf <sbrktest+0x3bb>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    exit();
  }
  lastaddr = (char*) (BIG-1);
  *lastaddr = 99;
    2bd6:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff

  // can one de-allocate?
  a = sbrk(0);
    2bdd:	83 ec 0c             	sub    $0xc,%esp
    2be0:	6a 00                	push   $0x0
    2be2:	e8 78 0a 00 00       	call   365f <sbrk>
    2be7:	89 c3                	mov    %eax,%ebx
  c = sbrk(-4096);
    2be9:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
    2bf0:	e8 6a 0a 00 00       	call   365f <sbrk>
  if(c == (char*)0xffffffff){
    2bf5:	83 c4 10             	add    $0x10,%esp
    2bf8:	40                   	inc    %eax
    2bf9:	0f 84 b8 02 00 00    	je     2eb7 <sbrktest+0x3a3>
    printf(stdout, "sbrk could not deallocate\n");
    exit();
  }
  c = sbrk(0);
    2bff:	83 ec 0c             	sub    $0xc,%esp
    2c02:	6a 00                	push   $0x0
    2c04:	e8 56 0a 00 00       	call   365f <sbrk>
  if(c != a - 4096){
    2c09:	8d 93 00 f0 ff ff    	lea    -0x1000(%ebx),%edx
    2c0f:	83 c4 10             	add    $0x10,%esp
    2c12:	39 d0                	cmp    %edx,%eax
    2c14:	0f 85 86 02 00 00    	jne    2ea0 <sbrktest+0x38c>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    exit();
  }

  // can one re-allocate that page?
  a = sbrk(0);
    2c1a:	83 ec 0c             	sub    $0xc,%esp
    2c1d:	6a 00                	push   $0x0
    2c1f:	e8 3b 0a 00 00       	call   365f <sbrk>
    2c24:	89 c7                	mov    %eax,%edi
  c = sbrk(4096);
    2c26:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    2c2d:	e8 2d 0a 00 00       	call   365f <sbrk>
    2c32:	89 c3                	mov    %eax,%ebx
  if(c != a || sbrk(0) != a + 4096){
    2c34:	83 c4 10             	add    $0x10,%esp
    2c37:	39 f8                	cmp    %edi,%eax
    2c39:	0f 85 4a 02 00 00    	jne    2e89 <sbrktest+0x375>
    2c3f:	83 ec 0c             	sub    $0xc,%esp
    2c42:	6a 00                	push   $0x0
    2c44:	e8 16 0a 00 00       	call   365f <sbrk>
    2c49:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    2c4f:	83 c4 10             	add    $0x10,%esp
    2c52:	39 d0                	cmp    %edx,%eax
    2c54:	0f 85 2f 02 00 00    	jne    2e89 <sbrktest+0x375>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit();
  }
  if(*lastaddr == 99){
    2c5a:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    2c61:	0f 84 0a 02 00 00    	je     2e71 <sbrktest+0x35d>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit();
  }

  a = sbrk(0);
    2c67:	83 ec 0c             	sub    $0xc,%esp
    2c6a:	6a 00                	push   $0x0
    2c6c:	e8 ee 09 00 00       	call   365f <sbrk>
    2c71:	89 c3                	mov    %eax,%ebx
  c = sbrk(-(sbrk(0) - oldbrk));
    2c73:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2c7a:	e8 e0 09 00 00       	call   365f <sbrk>
    2c7f:	8b 4d a4             	mov    -0x5c(%ebp),%ecx
    2c82:	29 c1                	sub    %eax,%ecx
    2c84:	89 0c 24             	mov    %ecx,(%esp)
    2c87:	e8 d3 09 00 00       	call   365f <sbrk>
  if(c != a){
    2c8c:	83 c4 10             	add    $0x10,%esp
    2c8f:	39 d8                	cmp    %ebx,%eax
    2c91:	0f 85 c3 01 00 00    	jne    2e5a <sbrktest+0x346>
    2c97:	bb 00 00 00 80       	mov    $0x80000000,%ebx
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    ppid = getpid();
    2c9c:	e8 b6 09 00 00       	call   3657 <getpid>
    2ca1:	89 c7                	mov    %eax,%edi
    pid = fork();
    2ca3:	e8 27 09 00 00       	call   35cf <fork>
    if(pid < 0){
    2ca8:	85 c0                	test   %eax,%eax
    2caa:	0f 88 92 01 00 00    	js     2e42 <sbrktest+0x32e>
      printf(stdout, "fork failed\n");
      exit();
    }
    if(pid == 0){
    2cb0:	0f 84 6a 01 00 00    	je     2e20 <sbrktest+0x30c>
      printf(stdout, "oops could read %x = %x\n", a, *a);
      kill(ppid);
      exit();
    }
    wait();
    2cb6:	e8 24 09 00 00       	call   35df <wait>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2cbb:	81 c3 50 c3 00 00    	add    $0xc350,%ebx
    2cc1:	81 fb 80 84 1e 80    	cmp    $0x801e8480,%ebx
    2cc7:	75 d3                	jne    2c9c <sbrktest+0x188>
    wait();
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    2cc9:	83 ec 0c             	sub    $0xc,%esp
    2ccc:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2ccf:	50                   	push   %eax
    2cd0:	e8 12 09 00 00       	call   35e7 <pipe>
    2cd5:	83 c4 10             	add    $0x10,%esp
    2cd8:	85 c0                	test   %eax,%eax
    2cda:	0f 85 2c 01 00 00    	jne    2e0c <sbrktest+0x2f8>
    2ce0:	8d 5d c0             	lea    -0x40(%ebp),%ebx
    2ce3:	8d 7d e8             	lea    -0x18(%ebp),%edi
    2ce6:	89 de                	mov    %ebx,%esi
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork()) == 0){
    2ce8:	e8 e2 08 00 00       	call   35cf <fork>
    2ced:	89 06                	mov    %eax,(%esi)
    2cef:	85 c0                	test   %eax,%eax
    2cf1:	0f 84 9d 00 00 00    	je     2d94 <sbrktest+0x280>
      sbrk(BIG - (uint)sbrk(0));
      write(fds[1], "x", 1);
      // sit around until killed
      for(;;) sleep(1000);
    }
    if(pids[i] != -1)
    2cf7:	40                   	inc    %eax
    2cf8:	74 12                	je     2d0c <sbrktest+0x1f8>
      read(fds[0], &scratch, 1);
    2cfa:	50                   	push   %eax
    2cfb:	6a 01                	push   $0x1
    2cfd:	8d 45 b7             	lea    -0x49(%ebp),%eax
    2d00:	50                   	push   %eax
    2d01:	ff 75 b8             	pushl  -0x48(%ebp)
    2d04:	e8 e6 08 00 00       	call   35ef <read>
    2d09:	83 c4 10             	add    $0x10,%esp
    2d0c:	83 c6 04             	add    $0x4,%esi
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2d0f:	39 fe                	cmp    %edi,%esi
    2d11:	75 d5                	jne    2ce8 <sbrktest+0x1d4>
    if(pids[i] != -1)
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    2d13:	83 ec 0c             	sub    $0xc,%esp
    2d16:	68 00 10 00 00       	push   $0x1000
    2d1b:	e8 3f 09 00 00       	call   365f <sbrk>
    2d20:	89 c6                	mov    %eax,%esi
    2d22:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if(pids[i] == -1)
    2d25:	8b 03                	mov    (%ebx),%eax
    2d27:	83 f8 ff             	cmp    $0xffffffff,%eax
    2d2a:	74 11                	je     2d3d <sbrktest+0x229>
      continue;
    kill(pids[i]);
    2d2c:	83 ec 0c             	sub    $0xc,%esp
    2d2f:	50                   	push   %eax
    2d30:	e8 d2 08 00 00       	call   3607 <kill>
    wait();
    2d35:	e8 a5 08 00 00       	call   35df <wait>
    2d3a:	83 c4 10             	add    $0x10,%esp
    2d3d:	83 c3 04             	add    $0x4,%ebx
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2d40:	39 df                	cmp    %ebx,%edi
    2d42:	75 e1                	jne    2d25 <sbrktest+0x211>
    if(pids[i] == -1)
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff){
    2d44:	89 f0                	mov    %esi,%eax
    2d46:	40                   	inc    %eax
    2d47:	0f 84 a7 00 00 00    	je     2df4 <sbrktest+0x2e0>
    printf(stdout, "failed sbrk leaked memory\n");
    exit();
  }

  if(sbrk(0) > oldbrk)
    2d4d:	83 ec 0c             	sub    $0xc,%esp
    2d50:	6a 00                	push   $0x0
    2d52:	e8 08 09 00 00       	call   365f <sbrk>
    2d57:	83 c4 10             	add    $0x10,%esp
    2d5a:	39 45 a4             	cmp    %eax,-0x5c(%ebp)
    2d5d:	73 1a                	jae    2d79 <sbrktest+0x265>
    sbrk(-(sbrk(0) - oldbrk));
    2d5f:	83 ec 0c             	sub    $0xc,%esp
    2d62:	6a 00                	push   $0x0
    2d64:	e8 f6 08 00 00       	call   365f <sbrk>
    2d69:	8b 75 a4             	mov    -0x5c(%ebp),%esi
    2d6c:	29 c6                	sub    %eax,%esi
    2d6e:	89 34 24             	mov    %esi,(%esp)
    2d71:	e8 e9 08 00 00       	call   365f <sbrk>
    2d76:	83 c4 10             	add    $0x10,%esp

  printf(stdout, "sbrk test OK\n");
    2d79:	83 ec 08             	sub    $0x8,%esp
    2d7c:	68 60 48 00 00       	push   $0x4860
    2d81:	ff 35 58 5a 00 00    	pushl  0x5a58
    2d87:	e8 6c 09 00 00       	call   36f8 <printf>
}
    2d8c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2d8f:	5b                   	pop    %ebx
    2d90:	5e                   	pop    %esi
    2d91:	5f                   	pop    %edi
    2d92:	5d                   	pop    %ebp
    2d93:	c3                   	ret    
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork()) == 0){
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    2d94:	83 ec 0c             	sub    $0xc,%esp
    2d97:	6a 00                	push   $0x0
    2d99:	e8 c1 08 00 00       	call   365f <sbrk>
    2d9e:	ba 00 00 40 06       	mov    $0x6400000,%edx
    2da3:	29 c2                	sub    %eax,%edx
    2da5:	89 14 24             	mov    %edx,(%esp)
    2da8:	e8 b2 08 00 00       	call   365f <sbrk>
      write(fds[1], "x", 1);
    2dad:	83 c4 0c             	add    $0xc,%esp
    2db0:	6a 01                	push   $0x1
    2db2:	68 21 43 00 00       	push   $0x4321
    2db7:	ff 75 bc             	pushl  -0x44(%ebp)
    2dba:	e8 38 08 00 00       	call   35f7 <write>
    2dbf:	83 c4 10             	add    $0x10,%esp
    2dc2:	66 90                	xchg   %ax,%ax
      // sit around until killed
      for(;;) sleep(1000);
    2dc4:	83 ec 0c             	sub    $0xc,%esp
    2dc7:	68 e8 03 00 00       	push   $0x3e8
    2dcc:	e8 96 08 00 00       	call   3667 <sleep>
    2dd1:	83 c4 10             	add    $0x10,%esp
    2dd4:	eb ee                	jmp    2dc4 <sbrktest+0x2b0>
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    b = sbrk(1);
    if(b != a){
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    2dd6:	83 ec 0c             	sub    $0xc,%esp
    2dd9:	50                   	push   %eax
    2dda:	53                   	push   %ebx
    2ddb:	57                   	push   %edi
    2ddc:	68 c3 47 00 00       	push   $0x47c3
    2de1:	ff 35 58 5a 00 00    	pushl  0x5a58
    2de7:	e8 0c 09 00 00       	call   36f8 <printf>
      exit();
    2dec:	83 c4 20             	add    $0x20,%esp
    2def:	e8 e3 07 00 00       	call   35d7 <exit>
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff){
    printf(stdout, "failed sbrk leaked memory\n");
    2df4:	83 ec 08             	sub    $0x8,%esp
    2df7:	68 45 48 00 00       	push   $0x4845
    2dfc:	ff 35 58 5a 00 00    	pushl  0x5a58
    2e02:	e8 f1 08 00 00       	call   36f8 <printf>
    exit();
    2e07:	e8 cb 07 00 00       	call   35d7 <exit>
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    2e0c:	83 ec 08             	sub    $0x8,%esp
    2e0f:	68 01 3d 00 00       	push   $0x3d01
    2e14:	6a 01                	push   $0x1
    2e16:	e8 dd 08 00 00       	call   36f8 <printf>
    exit();
    2e1b:	e8 b7 07 00 00       	call   35d7 <exit>
    if(pid < 0){
      printf(stdout, "fork failed\n");
      exit();
    }
    if(pid == 0){
      printf(stdout, "oops could read %x = %x\n", a, *a);
    2e20:	0f be 03             	movsbl (%ebx),%eax
    2e23:	50                   	push   %eax
    2e24:	53                   	push   %ebx
    2e25:	68 2c 48 00 00       	push   $0x482c
    2e2a:	ff 35 58 5a 00 00    	pushl  0x5a58
    2e30:	e8 c3 08 00 00       	call   36f8 <printf>
      kill(ppid);
    2e35:	89 3c 24             	mov    %edi,(%esp)
    2e38:	e8 ca 07 00 00       	call   3607 <kill>
      exit();
    2e3d:	e8 95 07 00 00       	call   35d7 <exit>
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    ppid = getpid();
    pid = fork();
    if(pid < 0){
      printf(stdout, "fork failed\n");
    2e42:	83 ec 08             	sub    $0x8,%esp
    2e45:	68 09 49 00 00       	push   $0x4909
    2e4a:	ff 35 58 5a 00 00    	pushl  0x5a58
    2e50:	e8 a3 08 00 00       	call   36f8 <printf>
      exit();
    2e55:	e8 7d 07 00 00       	call   35d7 <exit>
  }

  a = sbrk(0);
  c = sbrk(-(sbrk(0) - oldbrk));
  if(c != a){
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    2e5a:	50                   	push   %eax
    2e5b:	53                   	push   %ebx
    2e5c:	68 0c 50 00 00       	push   $0x500c
    2e61:	ff 35 58 5a 00 00    	pushl  0x5a58
    2e67:	e8 8c 08 00 00       	call   36f8 <printf>
    exit();
    2e6c:	e8 66 07 00 00       	call   35d7 <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit();
  }
  if(*lastaddr == 99){
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    2e71:	83 ec 08             	sub    $0x8,%esp
    2e74:	68 dc 4f 00 00       	push   $0x4fdc
    2e79:	ff 35 58 5a 00 00    	pushl  0x5a58
    2e7f:	e8 74 08 00 00       	call   36f8 <printf>
    exit();
    2e84:	e8 4e 07 00 00       	call   35d7 <exit>

  // can one re-allocate that page?
  a = sbrk(0);
  c = sbrk(4096);
  if(c != a || sbrk(0) != a + 4096){
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    2e89:	53                   	push   %ebx
    2e8a:	57                   	push   %edi
    2e8b:	68 b4 4f 00 00       	push   $0x4fb4
    2e90:	ff 35 58 5a 00 00    	pushl  0x5a58
    2e96:	e8 5d 08 00 00       	call   36f8 <printf>
    exit();
    2e9b:	e8 37 07 00 00       	call   35d7 <exit>
    printf(stdout, "sbrk could not deallocate\n");
    exit();
  }
  c = sbrk(0);
  if(c != a - 4096){
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    2ea0:	50                   	push   %eax
    2ea1:	53                   	push   %ebx
    2ea2:	68 7c 4f 00 00       	push   $0x4f7c
    2ea7:	ff 35 58 5a 00 00    	pushl  0x5a58
    2ead:	e8 46 08 00 00       	call   36f8 <printf>
    exit();
    2eb2:	e8 20 07 00 00       	call   35d7 <exit>

  // can one de-allocate?
  a = sbrk(0);
  c = sbrk(-4096);
  if(c == (char*)0xffffffff){
    printf(stdout, "sbrk could not deallocate\n");
    2eb7:	83 ec 08             	sub    $0x8,%esp
    2eba:	68 11 48 00 00       	push   $0x4811
    2ebf:	ff 35 58 5a 00 00    	pushl  0x5a58
    2ec5:	e8 2e 08 00 00       	call   36f8 <printf>
    exit();
    2eca:	e8 08 07 00 00       	call   35d7 <exit>
#define BIG (100*1024*1024)
  a = sbrk(0);
  amt = (BIG) - (uint)a;
  p = sbrk(amt);
  if (p != a) {
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    2ecf:	83 ec 08             	sub    $0x8,%esp
    2ed2:	68 3c 4f 00 00       	push   $0x4f3c
    2ed7:	ff 35 58 5a 00 00    	pushl  0x5a58
    2edd:	e8 16 08 00 00       	call   36f8 <printf>
    exit();
    2ee2:	e8 f0 06 00 00       	call   35d7 <exit>
  if(c != a + 1){
    printf(stdout, "sbrk test failed post-fork\n");
    exit();
  }
  if(pid == 0)
    exit();
    2ee7:	e8 eb 06 00 00       	call   35d7 <exit>
    exit();
  }
  c = sbrk(1);
  c = sbrk(1);
  if(c != a + 1){
    printf(stdout, "sbrk test failed post-fork\n");
    2eec:	83 ec 08             	sub    $0x8,%esp
    2eef:	68 f5 47 00 00       	push   $0x47f5
    2ef4:	ff 35 58 5a 00 00    	pushl  0x5a58
    2efa:	e8 f9 07 00 00       	call   36f8 <printf>
    exit();
    2eff:	e8 d3 06 00 00       	call   35d7 <exit>
    *b = 1;
    a = b + 1;
  }
  pid = fork();
  if(pid < 0){
    printf(stdout, "sbrk test fork failed\n");
    2f04:	83 ec 08             	sub    $0x8,%esp
    2f07:	68 de 47 00 00       	push   $0x47de
    2f0c:	ff 35 58 5a 00 00    	pushl  0x5a58
    2f12:	e8 e1 07 00 00       	call   36f8 <printf>
    exit();
    2f17:	e8 bb 06 00 00       	call   35d7 <exit>

00002f1c <validateint>:
  printf(stdout, "sbrk test OK\n");
}

void
validateint(int *p)
{
    2f1c:	55                   	push   %ebp
    2f1d:	89 e5                	mov    %esp,%ebp
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
    2f1f:	5d                   	pop    %ebp
    2f20:	c3                   	ret    
    2f21:	8d 76 00             	lea    0x0(%esi),%esi

00002f24 <validatetest>:

void
validatetest(void)
{
    2f24:	55                   	push   %ebp
    2f25:	89 e5                	mov    %esp,%ebp
    2f27:	56                   	push   %esi
    2f28:	53                   	push   %ebx
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    2f29:	83 ec 08             	sub    $0x8,%esp
    2f2c:	68 6e 48 00 00       	push   $0x486e
    2f31:	ff 35 58 5a 00 00    	pushl  0x5a58
    2f37:	e8 bc 07 00 00       	call   36f8 <printf>
    2f3c:	83 c4 10             	add    $0x10,%esp
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    2f3f:	31 db                	xor    %ebx,%ebx
    2f41:	8d 76 00             	lea    0x0(%esi),%esi
    if((pid = fork()) == 0){
    2f44:	e8 86 06 00 00       	call   35cf <fork>
    2f49:	89 c6                	mov    %eax,%esi
    2f4b:	85 c0                	test   %eax,%eax
    2f4d:	74 61                	je     2fb0 <validatetest+0x8c>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
      exit();
    }
    sleep(0);
    2f4f:	83 ec 0c             	sub    $0xc,%esp
    2f52:	6a 00                	push   $0x0
    2f54:	e8 0e 07 00 00       	call   3667 <sleep>
    sleep(0);
    2f59:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f60:	e8 02 07 00 00       	call   3667 <sleep>
    kill(pid);
    2f65:	89 34 24             	mov    %esi,(%esp)
    2f68:	e8 9a 06 00 00       	call   3607 <kill>
    wait();
    2f6d:	e8 6d 06 00 00       	call   35df <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    2f72:	58                   	pop    %eax
    2f73:	5a                   	pop    %edx
    2f74:	53                   	push   %ebx
    2f75:	68 7d 48 00 00       	push   $0x487d
    2f7a:	e8 b8 06 00 00       	call   3637 <link>
    2f7f:	83 c4 10             	add    $0x10,%esp
    2f82:	40                   	inc    %eax
    2f83:	75 30                	jne    2fb5 <validatetest+0x91>
  uint p;

  printf(stdout, "validate test\n");
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    2f85:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    2f8b:	81 fb 00 40 11 00    	cmp    $0x114000,%ebx
    2f91:	75 b1                	jne    2f44 <validatetest+0x20>
      printf(stdout, "link should not succeed\n");
      exit();
    }
  }

  printf(stdout, "validate ok\n");
    2f93:	83 ec 08             	sub    $0x8,%esp
    2f96:	68 a1 48 00 00       	push   $0x48a1
    2f9b:	ff 35 58 5a 00 00    	pushl  0x5a58
    2fa1:	e8 52 07 00 00       	call   36f8 <printf>
    2fa6:	83 c4 10             	add    $0x10,%esp
}
    2fa9:	8d 65 f8             	lea    -0x8(%ebp),%esp
    2fac:	5b                   	pop    %ebx
    2fad:	5e                   	pop    %esi
    2fae:	5d                   	pop    %ebp
    2faf:	c3                   	ret    

  for(p = 0; p <= (uint)hi; p += 4096){
    if((pid = fork()) == 0){
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
      exit();
    2fb0:	e8 22 06 00 00       	call   35d7 <exit>
    kill(pid);
    wait();

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
      printf(stdout, "link should not succeed\n");
    2fb5:	83 ec 08             	sub    $0x8,%esp
    2fb8:	68 88 48 00 00       	push   $0x4888
    2fbd:	ff 35 58 5a 00 00    	pushl  0x5a58
    2fc3:	e8 30 07 00 00       	call   36f8 <printf>
      exit();
    2fc8:	e8 0a 06 00 00       	call   35d7 <exit>
    2fcd:	8d 76 00             	lea    0x0(%esi),%esi

00002fd0 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    2fd0:	55                   	push   %ebp
    2fd1:	89 e5                	mov    %esp,%ebp
    2fd3:	83 ec 10             	sub    $0x10,%esp
  int i;

  printf(stdout, "bss test\n");
    2fd6:	68 ae 48 00 00       	push   $0x48ae
    2fdb:	ff 35 58 5a 00 00    	pushl  0x5a58
    2fe1:	e8 12 07 00 00       	call   36f8 <printf>
  for(i = 0; i < sizeof(uninit); i++){
    if(uninit[i] != '\0'){
    2fe6:	83 c4 10             	add    $0x10,%esp
    2fe9:	80 3d 20 5b 00 00 00 	cmpb   $0x0,0x5b20
    2ff0:	75 2b                	jne    301d <bsstest+0x4d>
    2ff2:	b8 21 5b 00 00       	mov    $0x5b21,%eax
    2ff7:	90                   	nop
    2ff8:	80 38 00             	cmpb   $0x0,(%eax)
    2ffb:	75 20                	jne    301d <bsstest+0x4d>
    2ffd:	40                   	inc    %eax
bsstest(void)
{
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    2ffe:	3d 30 82 00 00       	cmp    $0x8230,%eax
    3003:	75 f3                	jne    2ff8 <bsstest+0x28>
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
      exit();
    }
  }
  printf(stdout, "bss test ok\n");
    3005:	83 ec 08             	sub    $0x8,%esp
    3008:	68 c9 48 00 00       	push   $0x48c9
    300d:	ff 35 58 5a 00 00    	pushl  0x5a58
    3013:	e8 e0 06 00 00       	call   36f8 <printf>
    3018:	83 c4 10             	add    $0x10,%esp
}
    301b:	c9                   	leave  
    301c:	c3                   	ret    
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
    301d:	83 ec 08             	sub    $0x8,%esp
    3020:	68 b8 48 00 00       	push   $0x48b8
    3025:	ff 35 58 5a 00 00    	pushl  0x5a58
    302b:	e8 c8 06 00 00       	call   36f8 <printf>
      exit();
    3030:	e8 a2 05 00 00       	call   35d7 <exit>
    3035:	8d 76 00             	lea    0x0(%esi),%esi

00003038 <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    3038:	55                   	push   %ebp
    3039:	89 e5                	mov    %esp,%ebp
    303b:	83 ec 14             	sub    $0x14,%esp
  int pid, fd;

  unlink("bigarg-ok");
    303e:	68 d6 48 00 00       	push   $0x48d6
    3043:	e8 df 05 00 00       	call   3627 <unlink>
  pid = fork();
    3048:	e8 82 05 00 00       	call   35cf <fork>
  if(pid == 0){
    304d:	83 c4 10             	add    $0x10,%esp
    3050:	85 c0                	test   %eax,%eax
    3052:	74 40                	je     3094 <bigargtest+0x5c>
    exec("echo", args);
    printf(stdout, "bigarg test ok\n");
    fd = open("bigarg-ok", O_CREATE);
    close(fd);
    exit();
  } else if(pid < 0){
    3054:	0f 88 bf 00 00 00    	js     3119 <bigargtest+0xe1>
    printf(stdout, "bigargtest: fork failed\n");
    exit();
  }
  wait();
    305a:	e8 80 05 00 00       	call   35df <wait>
  fd = open("bigarg-ok", 0);
    305f:	83 ec 08             	sub    $0x8,%esp
    3062:	6a 00                	push   $0x0
    3064:	68 d6 48 00 00       	push   $0x48d6
    3069:	e8 a9 05 00 00       	call   3617 <open>
  if(fd < 0){
    306e:	83 c4 10             	add    $0x10,%esp
    3071:	85 c0                	test   %eax,%eax
    3073:	0f 88 89 00 00 00    	js     3102 <bigargtest+0xca>
    printf(stdout, "bigarg test failed!\n");
    exit();
  }
  close(fd);
    3079:	83 ec 0c             	sub    $0xc,%esp
    307c:	50                   	push   %eax
    307d:	e8 7d 05 00 00       	call   35ff <close>
  unlink("bigarg-ok");
    3082:	c7 04 24 d6 48 00 00 	movl   $0x48d6,(%esp)
    3089:	e8 99 05 00 00       	call   3627 <unlink>
    308e:	83 c4 10             	add    $0x10,%esp
}
    3091:	c9                   	leave  
    3092:	c3                   	ret    
    3093:	90                   	nop
  pid = fork();
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    3094:	c7 04 85 80 5a 00 00 	movl   $0x5030,0x5a80(,%eax,4)
    309b:	30 50 00 00 
  unlink("bigarg-ok");
  pid = fork();
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    309f:	40                   	inc    %eax
    30a0:	83 f8 1f             	cmp    $0x1f,%eax
    30a3:	75 ef                	jne    3094 <bigargtest+0x5c>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    args[MAXARG-1] = 0;
    30a5:	c7 05 fc 5a 00 00 00 	movl   $0x0,0x5afc
    30ac:	00 00 00 
    printf(stdout, "bigarg test\n");
    30af:	51                   	push   %ecx
    30b0:	51                   	push   %ecx
    30b1:	68 e0 48 00 00       	push   $0x48e0
    30b6:	ff 35 58 5a 00 00    	pushl  0x5a58
    30bc:	e8 37 06 00 00       	call   36f8 <printf>
    exec("echo", args);
    30c1:	58                   	pop    %eax
    30c2:	5a                   	pop    %edx
    30c3:	68 80 5a 00 00       	push   $0x5a80
    30c8:	68 ad 3a 00 00       	push   $0x3aad
    30cd:	e8 3d 05 00 00       	call   360f <exec>
    printf(stdout, "bigarg test ok\n");
    30d2:	59                   	pop    %ecx
    30d3:	58                   	pop    %eax
    30d4:	68 ed 48 00 00       	push   $0x48ed
    30d9:	ff 35 58 5a 00 00    	pushl  0x5a58
    30df:	e8 14 06 00 00       	call   36f8 <printf>
    fd = open("bigarg-ok", O_CREATE);
    30e4:	58                   	pop    %eax
    30e5:	5a                   	pop    %edx
    30e6:	68 00 02 00 00       	push   $0x200
    30eb:	68 d6 48 00 00       	push   $0x48d6
    30f0:	e8 22 05 00 00       	call   3617 <open>
    close(fd);
    30f5:	89 04 24             	mov    %eax,(%esp)
    30f8:	e8 02 05 00 00       	call   35ff <close>
    exit();
    30fd:	e8 d5 04 00 00       	call   35d7 <exit>
    exit();
  }
  wait();
  fd = open("bigarg-ok", 0);
  if(fd < 0){
    printf(stdout, "bigarg test failed!\n");
    3102:	50                   	push   %eax
    3103:	50                   	push   %eax
    3104:	68 16 49 00 00       	push   $0x4916
    3109:	ff 35 58 5a 00 00    	pushl  0x5a58
    310f:	e8 e4 05 00 00       	call   36f8 <printf>
    exit();
    3114:	e8 be 04 00 00       	call   35d7 <exit>
    printf(stdout, "bigarg test ok\n");
    fd = open("bigarg-ok", O_CREATE);
    close(fd);
    exit();
  } else if(pid < 0){
    printf(stdout, "bigargtest: fork failed\n");
    3119:	52                   	push   %edx
    311a:	52                   	push   %edx
    311b:	68 fd 48 00 00       	push   $0x48fd
    3120:	ff 35 58 5a 00 00    	pushl  0x5a58
    3126:	e8 cd 05 00 00       	call   36f8 <printf>
    exit();
    312b:	e8 a7 04 00 00       	call   35d7 <exit>

00003130 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    3130:	55                   	push   %ebp
    3131:	89 e5                	mov    %esp,%ebp
    3133:	57                   	push   %edi
    3134:	56                   	push   %esi
    3135:	53                   	push   %ebx
    3136:	83 ec 54             	sub    $0x54,%esp
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");
    3139:	68 2b 49 00 00       	push   $0x492b
    313e:	6a 01                	push   $0x1
    3140:	e8 b3 05 00 00       	call   36f8 <printf>
    3145:	83 c4 10             	add    $0x10,%esp

  for(nfiles = 0; ; nfiles++){
    3148:	31 f6                	xor    %esi,%esi
    314a:	66 90                	xchg   %ax,%ax
    char name[64];
    name[0] = 'f';
    314c:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    3150:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    3155:	f7 ee                	imul   %esi
    3157:	89 d0                	mov    %edx,%eax
    3159:	c1 f8 06             	sar    $0x6,%eax
    315c:	89 f3                	mov    %esi,%ebx
    315e:	c1 fb 1f             	sar    $0x1f,%ebx
    3161:	29 d8                	sub    %ebx,%eax
    3163:	8d 50 30             	lea    0x30(%eax),%edx
    3166:	88 55 a9             	mov    %dl,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3169:	8d 04 80             	lea    (%eax,%eax,4),%eax
    316c:	8d 04 80             	lea    (%eax,%eax,4),%eax
    316f:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3172:	c1 e0 03             	shl    $0x3,%eax
    3175:	89 f1                	mov    %esi,%ecx
    3177:	29 c1                	sub    %eax,%ecx
    3179:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    317e:	f7 e9                	imul   %ecx
    3180:	89 d0                	mov    %edx,%eax
    3182:	c1 f8 05             	sar    $0x5,%eax
    3185:	c1 f9 1f             	sar    $0x1f,%ecx
    3188:	29 c8                	sub    %ecx,%eax
    318a:	83 c0 30             	add    $0x30,%eax
    318d:	88 45 aa             	mov    %al,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3190:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3195:	f7 ee                	imul   %esi
    3197:	89 d0                	mov    %edx,%eax
    3199:	c1 f8 05             	sar    $0x5,%eax
    319c:	29 d8                	sub    %ebx,%eax
    319e:	8d 04 80             	lea    (%eax,%eax,4),%eax
    31a1:	8d 04 80             	lea    (%eax,%eax,4),%eax
    31a4:	c1 e0 02             	shl    $0x2,%eax
    31a7:	89 f7                	mov    %esi,%edi
    31a9:	29 c7                	sub    %eax,%edi
    31ab:	b9 67 66 66 66       	mov    $0x66666667,%ecx
    31b0:	89 f8                	mov    %edi,%eax
    31b2:	f7 e9                	imul   %ecx
    31b4:	c1 fa 02             	sar    $0x2,%edx
    31b7:	c1 ff 1f             	sar    $0x1f,%edi
    31ba:	29 fa                	sub    %edi,%edx
    31bc:	83 c2 30             	add    $0x30,%edx
    31bf:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    31c2:	89 c8                	mov    %ecx,%eax
    31c4:	f7 ee                	imul   %esi
    31c6:	89 d0                	mov    %edx,%eax
    31c8:	c1 f8 02             	sar    $0x2,%eax
    31cb:	29 d8                	sub    %ebx,%eax
    31cd:	8d 04 80             	lea    (%eax,%eax,4),%eax
    31d0:	01 c0                	add    %eax,%eax
    31d2:	89 f1                	mov    %esi,%ecx
    31d4:	29 c1                	sub    %eax,%ecx
    31d6:	89 c8                	mov    %ecx,%eax
    31d8:	83 c0 30             	add    $0x30,%eax
    31db:	88 45 ac             	mov    %al,-0x54(%ebp)
    name[5] = '\0';
    31de:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    printf(1, "writing %s\n", name);
    31e2:	53                   	push   %ebx
    31e3:	8d 45 a8             	lea    -0x58(%ebp),%eax
    31e6:	50                   	push   %eax
    31e7:	68 38 49 00 00       	push   $0x4938
    31ec:	6a 01                	push   $0x1
    31ee:	e8 05 05 00 00       	call   36f8 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    31f3:	5f                   	pop    %edi
    31f4:	58                   	pop    %eax
    31f5:	68 02 02 00 00       	push   $0x202
    31fa:	8d 45 a8             	lea    -0x58(%ebp),%eax
    31fd:	50                   	push   %eax
    31fe:	e8 14 04 00 00       	call   3617 <open>
    3203:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    3205:	83 c4 10             	add    $0x10,%esp
    3208:	85 c0                	test   %eax,%eax
    320a:	78 44                	js     3250 <fsfull+0x120>
    320c:	31 db                	xor    %ebx,%ebx
    320e:	eb 02                	jmp    3212 <fsfull+0xe2>
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
      if(cc < 512)
        break;
      total += cc;
    3210:	01 c3                	add    %eax,%ebx
      printf(1, "open %s failed\n", name);
      break;
    }
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
    3212:	52                   	push   %edx
    3213:	68 00 02 00 00       	push   $0x200
    3218:	68 40 82 00 00       	push   $0x8240
    321d:	57                   	push   %edi
    321e:	e8 d4 03 00 00       	call   35f7 <write>
      if(cc < 512)
    3223:	83 c4 10             	add    $0x10,%esp
    3226:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    322b:	7f e3                	jg     3210 <fsfull+0xe0>
        break;
      total += cc;
      fsblocks++;
    }
    printf(1, "wrote %d bytes\n", total);
    322d:	50                   	push   %eax
    322e:	53                   	push   %ebx
    322f:	68 54 49 00 00       	push   $0x4954
    3234:	6a 01                	push   $0x1
    3236:	e8 bd 04 00 00       	call   36f8 <printf>
    close(fd);
    323b:	89 3c 24             	mov    %edi,(%esp)
    323e:	e8 bc 03 00 00       	call   35ff <close>
    if(total == 0)
    3243:	83 c4 10             	add    $0x10,%esp
    3246:	85 db                	test   %ebx,%ebx
    3248:	74 1a                	je     3264 <fsfull+0x134>
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    324a:	46                   	inc    %esi
    }
    printf(1, "wrote %d bytes\n", total);
    close(fd);
    if(total == 0)
      break;
  }
    324b:	e9 fc fe ff ff       	jmp    314c <fsfull+0x1c>
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    int fd = open(name, O_CREATE|O_RDWR);
    if(fd < 0){
      printf(1, "open %s failed\n", name);
    3250:	51                   	push   %ecx
    3251:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3254:	50                   	push   %eax
    3255:	68 44 49 00 00       	push   $0x4944
    325a:	6a 01                	push   $0x1
    325c:	e8 97 04 00 00       	call   36f8 <printf>
      break;
    3261:	83 c4 10             	add    $0x10,%esp
      break;
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    3264:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    3268:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    326d:	f7 ee                	imul   %esi
    326f:	89 d0                	mov    %edx,%eax
    3271:	c1 f8 06             	sar    $0x6,%eax
    3274:	89 f3                	mov    %esi,%ebx
    3276:	c1 fb 1f             	sar    $0x1f,%ebx
    3279:	29 d8                	sub    %ebx,%eax
    327b:	8d 50 30             	lea    0x30(%eax),%edx
    327e:	88 55 a9             	mov    %dl,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3281:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3284:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3287:	8d 04 80             	lea    (%eax,%eax,4),%eax
    328a:	c1 e0 03             	shl    $0x3,%eax
    328d:	89 f1                	mov    %esi,%ecx
    328f:	29 c1                	sub    %eax,%ecx
    3291:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3296:	f7 e9                	imul   %ecx
    3298:	89 d0                	mov    %edx,%eax
    329a:	c1 f8 05             	sar    $0x5,%eax
    329d:	c1 f9 1f             	sar    $0x1f,%ecx
    32a0:	29 c8                	sub    %ecx,%eax
    32a2:	83 c0 30             	add    $0x30,%eax
    32a5:	88 45 aa             	mov    %al,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    32a8:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    32ad:	f7 ee                	imul   %esi
    32af:	89 d0                	mov    %edx,%eax
    32b1:	c1 f8 05             	sar    $0x5,%eax
    32b4:	29 d8                	sub    %ebx,%eax
    32b6:	8d 04 80             	lea    (%eax,%eax,4),%eax
    32b9:	8d 04 80             	lea    (%eax,%eax,4),%eax
    32bc:	c1 e0 02             	shl    $0x2,%eax
    32bf:	89 f7                	mov    %esi,%edi
    32c1:	29 c7                	sub    %eax,%edi
    32c3:	b9 67 66 66 66       	mov    $0x66666667,%ecx
    32c8:	89 f8                	mov    %edi,%eax
    32ca:	f7 e9                	imul   %ecx
    32cc:	c1 fa 02             	sar    $0x2,%edx
    32cf:	c1 ff 1f             	sar    $0x1f,%edi
    32d2:	29 fa                	sub    %edi,%edx
    32d4:	83 c2 30             	add    $0x30,%edx
    32d7:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    32da:	89 c8                	mov    %ecx,%eax
    32dc:	f7 ee                	imul   %esi
    32de:	89 d0                	mov    %edx,%eax
    32e0:	c1 f8 02             	sar    $0x2,%eax
    32e3:	29 d8                	sub    %ebx,%eax
    32e5:	8d 04 80             	lea    (%eax,%eax,4),%eax
    32e8:	01 c0                	add    %eax,%eax
    32ea:	89 f1                	mov    %esi,%ecx
    32ec:	29 c1                	sub    %eax,%ecx
    32ee:	89 c8                	mov    %ecx,%eax
    32f0:	83 c0 30             	add    $0x30,%eax
    32f3:	88 45 ac             	mov    %al,-0x54(%ebp)
    name[5] = '\0';
    32f6:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    unlink(name);
    32fa:	83 ec 0c             	sub    $0xc,%esp
    32fd:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3300:	50                   	push   %eax
    3301:	e8 21 03 00 00       	call   3627 <unlink>
    nfiles--;
    3306:	4e                   	dec    %esi
    close(fd);
    if(total == 0)
      break;
  }

  while(nfiles >= 0){
    3307:	83 c4 10             	add    $0x10,%esp
    330a:	83 fe ff             	cmp    $0xffffffff,%esi
    330d:	0f 85 51 ff ff ff    	jne    3264 <fsfull+0x134>
    name[5] = '\0';
    unlink(name);
    nfiles--;
  }

  printf(1, "fsfull test finished\n");
    3313:	83 ec 08             	sub    $0x8,%esp
    3316:	68 64 49 00 00       	push   $0x4964
    331b:	6a 01                	push   $0x1
    331d:	e8 d6 03 00 00       	call   36f8 <printf>
    3322:	83 c4 10             	add    $0x10,%esp
}
    3325:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3328:	5b                   	pop    %ebx
    3329:	5e                   	pop    %esi
    332a:	5f                   	pop    %edi
    332b:	5d                   	pop    %ebp
    332c:	c3                   	ret    
    332d:	8d 76 00             	lea    0x0(%esi),%esi

00003330 <uio>:

void
uio()
{
    3330:	55                   	push   %ebp
    3331:	89 e5                	mov    %esp,%ebp
    3333:	83 ec 10             	sub    $0x10,%esp

  ushort port = 0;
  uchar val = 0;
  int pid;

  printf(1, "uio test\n");
    3336:	68 7a 49 00 00       	push   $0x497a
    333b:	6a 01                	push   $0x1
    333d:	e8 b6 03 00 00       	call   36f8 <printf>
  pid = fork();
    3342:	e8 88 02 00 00       	call   35cf <fork>
  if(pid == 0){
    3347:	83 c4 10             	add    $0x10,%esp
    334a:	85 c0                	test   %eax,%eax
    334c:	74 1b                	je     3369 <uio+0x39>
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    port = RTC_DATA;
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    printf(1, "uio: uio succeeded; test FAILED\n");
    exit();
  } else if(pid < 0){
    334e:	78 37                	js     3387 <uio+0x57>
    printf (1, "fork failed\n");
    exit();
  }
  wait();
    3350:	e8 8a 02 00 00       	call   35df <wait>
  printf(1, "uio test done\n");
    3355:	83 ec 08             	sub    $0x8,%esp
    3358:	68 84 49 00 00       	push   $0x4984
    335d:	6a 01                	push   $0x1
    335f:	e8 94 03 00 00       	call   36f8 <printf>
    3364:	83 c4 10             	add    $0x10,%esp
}
    3367:	c9                   	leave  
    3368:	c3                   	ret    
  pid = fork();
  if(pid == 0){
    port = RTC_ADDR;
    val = 0x09;  /* year */
    /* http://wiki.osdev.org/Inline_Assembly/Examples */
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    3369:	ba 70 00 00 00       	mov    $0x70,%edx
    336e:	b0 09                	mov    $0x9,%al
    3370:	ee                   	out    %al,(%dx)
    port = RTC_DATA;
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    3371:	b2 71                	mov    $0x71,%dl
    3373:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    3374:	52                   	push   %edx
    3375:	52                   	push   %edx
    3376:	68 10 51 00 00       	push   $0x5110
    337b:	6a 01                	push   $0x1
    337d:	e8 76 03 00 00       	call   36f8 <printf>
    exit();
    3382:	e8 50 02 00 00       	call   35d7 <exit>
  } else if(pid < 0){
    printf (1, "fork failed\n");
    3387:	50                   	push   %eax
    3388:	50                   	push   %eax
    3389:	68 09 49 00 00       	push   $0x4909
    338e:	6a 01                	push   $0x1
    3390:	e8 63 03 00 00       	call   36f8 <printf>
    exit();
    3395:	e8 3d 02 00 00       	call   35d7 <exit>
    339a:	66 90                	xchg   %ax,%ax

0000339c <argptest>:
  wait();
  printf(1, "uio test done\n");
}

void argptest()
{
    339c:	55                   	push   %ebp
    339d:	89 e5                	mov    %esp,%ebp
    339f:	53                   	push   %ebx
    33a0:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  fd = open("init", O_RDONLY);
    33a3:	6a 00                	push   $0x0
    33a5:	68 93 49 00 00       	push   $0x4993
    33aa:	e8 68 02 00 00       	call   3617 <open>
    33af:	89 c3                	mov    %eax,%ebx
  if (fd < 0) {
    33b1:	83 c4 10             	add    $0x10,%esp
    33b4:	85 c0                	test   %eax,%eax
    33b6:	78 35                	js     33ed <argptest+0x51>
    printf(2, "open failed\n");
    exit();
  }
  read(fd, sbrk(0) - 1, -1);
    33b8:	83 ec 0c             	sub    $0xc,%esp
    33bb:	6a 00                	push   $0x0
    33bd:	e8 9d 02 00 00       	call   365f <sbrk>
    33c2:	83 c4 0c             	add    $0xc,%esp
    33c5:	6a ff                	push   $0xffffffff
    33c7:	48                   	dec    %eax
    33c8:	50                   	push   %eax
    33c9:	53                   	push   %ebx
    33ca:	e8 20 02 00 00       	call   35ef <read>
  close(fd);
    33cf:	89 1c 24             	mov    %ebx,(%esp)
    33d2:	e8 28 02 00 00       	call   35ff <close>
  printf(1, "arg test passed\n");
    33d7:	58                   	pop    %eax
    33d8:	5a                   	pop    %edx
    33d9:	68 a5 49 00 00       	push   $0x49a5
    33de:	6a 01                	push   $0x1
    33e0:	e8 13 03 00 00       	call   36f8 <printf>
    33e5:	83 c4 10             	add    $0x10,%esp
}
    33e8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    33eb:	c9                   	leave  
    33ec:	c3                   	ret    
void argptest()
{
  int fd;
  fd = open("init", O_RDONLY);
  if (fd < 0) {
    printf(2, "open failed\n");
    33ed:	51                   	push   %ecx
    33ee:	51                   	push   %ecx
    33ef:	68 98 49 00 00       	push   $0x4998
    33f4:	6a 02                	push   $0x2
    33f6:	e8 fd 02 00 00       	call   36f8 <printf>
    exit();
    33fb:	e8 d7 01 00 00       	call   35d7 <exit>

00003400 <rand>:
}

unsigned long randstate = 1;
unsigned int
rand()
{
    3400:	55                   	push   %ebp
    3401:	89 e5                	mov    %esp,%ebp
  randstate = randstate * 1664525 + 1013904223;
    3403:	a1 54 5a 00 00       	mov    0x5a54,%eax
    3408:	8d 14 00             	lea    (%eax,%eax,1),%edx
    340b:	01 c2                	add    %eax,%edx
    340d:	8d 14 90             	lea    (%eax,%edx,4),%edx
    3410:	c1 e2 08             	shl    $0x8,%edx
    3413:	01 c2                	add    %eax,%edx
    3415:	8d 14 92             	lea    (%edx,%edx,4),%edx
    3418:	8d 04 90             	lea    (%eax,%edx,4),%eax
    341b:	8d 04 80             	lea    (%eax,%eax,4),%eax
    341e:	8d 84 80 5f f3 6e 3c 	lea    0x3c6ef35f(%eax,%eax,4),%eax
    3425:	a3 54 5a 00 00       	mov    %eax,0x5a54
  return randstate;
}
    342a:	5d                   	pop    %ebp
    342b:	c3                   	ret    

0000342c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    342c:	55                   	push   %ebp
    342d:	89 e5                	mov    %esp,%ebp
    342f:	53                   	push   %ebx
    3430:	8b 45 08             	mov    0x8(%ebp),%eax
    3433:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3436:	89 c2                	mov    %eax,%edx
    3438:	42                   	inc    %edx
    3439:	41                   	inc    %ecx
    343a:	8a 59 ff             	mov    -0x1(%ecx),%bl
    343d:	88 5a ff             	mov    %bl,-0x1(%edx)
    3440:	84 db                	test   %bl,%bl
    3442:	75 f4                	jne    3438 <strcpy+0xc>
    ;
  return os;
}
    3444:	5b                   	pop    %ebx
    3445:	5d                   	pop    %ebp
    3446:	c3                   	ret    
    3447:	90                   	nop

00003448 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3448:	55                   	push   %ebp
    3449:	89 e5                	mov    %esp,%ebp
    344b:	56                   	push   %esi
    344c:	53                   	push   %ebx
    344d:	8b 55 08             	mov    0x8(%ebp),%edx
    3450:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
    3453:	0f b6 02             	movzbl (%edx),%eax
    3456:	0f b6 0b             	movzbl (%ebx),%ecx
    3459:	84 c0                	test   %al,%al
    345b:	75 14                	jne    3471 <strcmp+0x29>
    345d:	eb 1d                	jmp    347c <strcmp+0x34>
    345f:	90                   	nop
    p++, q++;
    3460:	42                   	inc    %edx
    3461:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    3464:	0f b6 02             	movzbl (%edx),%eax
    3467:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
    346b:	84 c0                	test   %al,%al
    346d:	74 0d                	je     347c <strcmp+0x34>
    346f:	89 f3                	mov    %esi,%ebx
    3471:	38 c8                	cmp    %cl,%al
    3473:	74 eb                	je     3460 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    3475:	29 c8                	sub    %ecx,%eax
}
    3477:	5b                   	pop    %ebx
    3478:	5e                   	pop    %esi
    3479:	5d                   	pop    %ebp
    347a:	c3                   	ret    
    347b:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    347c:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
    347e:	29 c8                	sub    %ecx,%eax
}
    3480:	5b                   	pop    %ebx
    3481:	5e                   	pop    %esi
    3482:	5d                   	pop    %ebp
    3483:	c3                   	ret    

00003484 <strlen>:

uint
strlen(char *s)
{
    3484:	55                   	push   %ebp
    3485:	89 e5                	mov    %esp,%ebp
    3487:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    348a:	80 39 00             	cmpb   $0x0,(%ecx)
    348d:	74 10                	je     349f <strlen+0x1b>
    348f:	31 d2                	xor    %edx,%edx
    3491:	8d 76 00             	lea    0x0(%esi),%esi
    3494:	42                   	inc    %edx
    3495:	89 d0                	mov    %edx,%eax
    3497:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    349b:	75 f7                	jne    3494 <strlen+0x10>
    ;
  return n;
}
    349d:	5d                   	pop    %ebp
    349e:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
    349f:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
    34a1:	5d                   	pop    %ebp
    34a2:	c3                   	ret    
    34a3:	90                   	nop

000034a4 <memset>:

void*
memset(void *dst, int c, uint n)
{
    34a4:	55                   	push   %ebp
    34a5:	89 e5                	mov    %esp,%ebp
    34a7:	57                   	push   %edi
    34a8:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    34ab:	89 d7                	mov    %edx,%edi
    34ad:	8b 4d 10             	mov    0x10(%ebp),%ecx
    34b0:	8b 45 0c             	mov    0xc(%ebp),%eax
    34b3:	fc                   	cld    
    34b4:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    34b6:	89 d0                	mov    %edx,%eax
    34b8:	5f                   	pop    %edi
    34b9:	5d                   	pop    %ebp
    34ba:	c3                   	ret    
    34bb:	90                   	nop

000034bc <strchr>:

char*
strchr(const char *s, char c)
{
    34bc:	55                   	push   %ebp
    34bd:	89 e5                	mov    %esp,%ebp
    34bf:	53                   	push   %ebx
    34c0:	8b 45 08             	mov    0x8(%ebp),%eax
    34c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
    34c6:	8a 18                	mov    (%eax),%bl
    34c8:	84 db                	test   %bl,%bl
    34ca:	74 13                	je     34df <strchr+0x23>
    34cc:	88 d1                	mov    %dl,%cl
    if(*s == c)
    34ce:	38 d3                	cmp    %dl,%bl
    34d0:	75 06                	jne    34d8 <strchr+0x1c>
    34d2:	eb 0d                	jmp    34e1 <strchr+0x25>
    34d4:	38 ca                	cmp    %cl,%dl
    34d6:	74 09                	je     34e1 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    34d8:	40                   	inc    %eax
    34d9:	8a 10                	mov    (%eax),%dl
    34db:	84 d2                	test   %dl,%dl
    34dd:	75 f5                	jne    34d4 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
    34df:	31 c0                	xor    %eax,%eax
}
    34e1:	5b                   	pop    %ebx
    34e2:	5d                   	pop    %ebp
    34e3:	c3                   	ret    

000034e4 <gets>:

char*
gets(char *buf, int max)
{
    34e4:	55                   	push   %ebp
    34e5:	89 e5                	mov    %esp,%ebp
    34e7:	57                   	push   %edi
    34e8:	56                   	push   %esi
    34e9:	53                   	push   %ebx
    34ea:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    34ed:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
    34ef:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    34f2:	eb 26                	jmp    351a <gets+0x36>
    cc = read(0, &c, 1);
    34f4:	50                   	push   %eax
    34f5:	6a 01                	push   $0x1
    34f7:	57                   	push   %edi
    34f8:	6a 00                	push   $0x0
    34fa:	e8 f0 00 00 00       	call   35ef <read>
    if(cc < 1)
    34ff:	83 c4 10             	add    $0x10,%esp
    3502:	85 c0                	test   %eax,%eax
    3504:	7e 1c                	jle    3522 <gets+0x3e>
      break;
    buf[i++] = c;
    3506:	8a 45 e7             	mov    -0x19(%ebp),%al
    3509:	8b 55 08             	mov    0x8(%ebp),%edx
    350c:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    3510:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
    3512:	3c 0a                	cmp    $0xa,%al
    3514:	74 0c                	je     3522 <gets+0x3e>
    3516:	3c 0d                	cmp    $0xd,%al
    3518:	74 08                	je     3522 <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    351a:	8d 5e 01             	lea    0x1(%esi),%ebx
    351d:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    3520:	7c d2                	jl     34f4 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    3522:	8b 45 08             	mov    0x8(%ebp),%eax
    3525:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    3529:	8d 65 f4             	lea    -0xc(%ebp),%esp
    352c:	5b                   	pop    %ebx
    352d:	5e                   	pop    %esi
    352e:	5f                   	pop    %edi
    352f:	5d                   	pop    %ebp
    3530:	c3                   	ret    
    3531:	8d 76 00             	lea    0x0(%esi),%esi

00003534 <stat>:

int
stat(char *n, struct stat *st)
{
    3534:	55                   	push   %ebp
    3535:	89 e5                	mov    %esp,%ebp
    3537:	56                   	push   %esi
    3538:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3539:	83 ec 08             	sub    $0x8,%esp
    353c:	6a 00                	push   $0x0
    353e:	ff 75 08             	pushl  0x8(%ebp)
    3541:	e8 d1 00 00 00       	call   3617 <open>
    3546:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    3548:	83 c4 10             	add    $0x10,%esp
    354b:	85 c0                	test   %eax,%eax
    354d:	78 25                	js     3574 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    354f:	83 ec 08             	sub    $0x8,%esp
    3552:	ff 75 0c             	pushl  0xc(%ebp)
    3555:	50                   	push   %eax
    3556:	e8 d4 00 00 00       	call   362f <fstat>
    355b:	89 c6                	mov    %eax,%esi
  close(fd);
    355d:	89 1c 24             	mov    %ebx,(%esp)
    3560:	e8 9a 00 00 00       	call   35ff <close>
  return r;
    3565:	83 c4 10             	add    $0x10,%esp
    3568:	89 f0                	mov    %esi,%eax
}
    356a:	8d 65 f8             	lea    -0x8(%ebp),%esp
    356d:	5b                   	pop    %ebx
    356e:	5e                   	pop    %esi
    356f:	5d                   	pop    %ebp
    3570:	c3                   	ret    
    3571:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
    3574:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3579:	eb ef                	jmp    356a <stat+0x36>
    357b:	90                   	nop

0000357c <atoi>:
  return r;
}

int
atoi(const char *s)
{
    357c:	55                   	push   %ebp
    357d:	89 e5                	mov    %esp,%ebp
    357f:	53                   	push   %ebx
    3580:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3583:	0f be 11             	movsbl (%ecx),%edx
    3586:	8d 42 d0             	lea    -0x30(%edx),%eax
    3589:	3c 09                	cmp    $0x9,%al
    358b:	b8 00 00 00 00       	mov    $0x0,%eax
    3590:	77 15                	ja     35a7 <atoi+0x2b>
    3592:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    3594:	41                   	inc    %ecx
    3595:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3598:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    359c:	0f be 11             	movsbl (%ecx),%edx
    359f:	8d 5a d0             	lea    -0x30(%edx),%ebx
    35a2:	80 fb 09             	cmp    $0x9,%bl
    35a5:	76 ed                	jbe    3594 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    35a7:	5b                   	pop    %ebx
    35a8:	5d                   	pop    %ebp
    35a9:	c3                   	ret    
    35aa:	66 90                	xchg   %ax,%ax

000035ac <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    35ac:	55                   	push   %ebp
    35ad:	89 e5                	mov    %esp,%ebp
    35af:	56                   	push   %esi
    35b0:	53                   	push   %ebx
    35b1:	8b 45 08             	mov    0x8(%ebp),%eax
    35b4:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    35b7:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    35ba:	31 d2                	xor    %edx,%edx
    35bc:	85 f6                	test   %esi,%esi
    35be:	7e 0b                	jle    35cb <memmove+0x1f>
    *dst++ = *src++;
    35c0:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
    35c3:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    35c6:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    35c7:	39 f2                	cmp    %esi,%edx
    35c9:	75 f5                	jne    35c0 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
    35cb:	5b                   	pop    %ebx
    35cc:	5e                   	pop    %esi
    35cd:	5d                   	pop    %ebp
    35ce:	c3                   	ret    

000035cf <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    35cf:	b8 01 00 00 00       	mov    $0x1,%eax
    35d4:	cd 40                	int    $0x40
    35d6:	c3                   	ret    

000035d7 <exit>:
SYSCALL(exit)
    35d7:	b8 02 00 00 00       	mov    $0x2,%eax
    35dc:	cd 40                	int    $0x40
    35de:	c3                   	ret    

000035df <wait>:
SYSCALL(wait)
    35df:	b8 03 00 00 00       	mov    $0x3,%eax
    35e4:	cd 40                	int    $0x40
    35e6:	c3                   	ret    

000035e7 <pipe>:
SYSCALL(pipe)
    35e7:	b8 04 00 00 00       	mov    $0x4,%eax
    35ec:	cd 40                	int    $0x40
    35ee:	c3                   	ret    

000035ef <read>:
SYSCALL(read)
    35ef:	b8 05 00 00 00       	mov    $0x5,%eax
    35f4:	cd 40                	int    $0x40
    35f6:	c3                   	ret    

000035f7 <write>:
SYSCALL(write)
    35f7:	b8 10 00 00 00       	mov    $0x10,%eax
    35fc:	cd 40                	int    $0x40
    35fe:	c3                   	ret    

000035ff <close>:
SYSCALL(close)
    35ff:	b8 15 00 00 00       	mov    $0x15,%eax
    3604:	cd 40                	int    $0x40
    3606:	c3                   	ret    

00003607 <kill>:
SYSCALL(kill)
    3607:	b8 06 00 00 00       	mov    $0x6,%eax
    360c:	cd 40                	int    $0x40
    360e:	c3                   	ret    

0000360f <exec>:
SYSCALL(exec)
    360f:	b8 07 00 00 00       	mov    $0x7,%eax
    3614:	cd 40                	int    $0x40
    3616:	c3                   	ret    

00003617 <open>:
SYSCALL(open)
    3617:	b8 0f 00 00 00       	mov    $0xf,%eax
    361c:	cd 40                	int    $0x40
    361e:	c3                   	ret    

0000361f <mknod>:
SYSCALL(mknod)
    361f:	b8 11 00 00 00       	mov    $0x11,%eax
    3624:	cd 40                	int    $0x40
    3626:	c3                   	ret    

00003627 <unlink>:
SYSCALL(unlink)
    3627:	b8 12 00 00 00       	mov    $0x12,%eax
    362c:	cd 40                	int    $0x40
    362e:	c3                   	ret    

0000362f <fstat>:
SYSCALL(fstat)
    362f:	b8 08 00 00 00       	mov    $0x8,%eax
    3634:	cd 40                	int    $0x40
    3636:	c3                   	ret    

00003637 <link>:
SYSCALL(link)
    3637:	b8 13 00 00 00       	mov    $0x13,%eax
    363c:	cd 40                	int    $0x40
    363e:	c3                   	ret    

0000363f <mkdir>:
SYSCALL(mkdir)
    363f:	b8 14 00 00 00       	mov    $0x14,%eax
    3644:	cd 40                	int    $0x40
    3646:	c3                   	ret    

00003647 <chdir>:
SYSCALL(chdir)
    3647:	b8 09 00 00 00       	mov    $0x9,%eax
    364c:	cd 40                	int    $0x40
    364e:	c3                   	ret    

0000364f <dup>:
SYSCALL(dup)
    364f:	b8 0a 00 00 00       	mov    $0xa,%eax
    3654:	cd 40                	int    $0x40
    3656:	c3                   	ret    

00003657 <getpid>:
SYSCALL(getpid)
    3657:	b8 0b 00 00 00       	mov    $0xb,%eax
    365c:	cd 40                	int    $0x40
    365e:	c3                   	ret    

0000365f <sbrk>:
SYSCALL(sbrk)
    365f:	b8 0c 00 00 00       	mov    $0xc,%eax
    3664:	cd 40                	int    $0x40
    3666:	c3                   	ret    

00003667 <sleep>:
SYSCALL(sleep)
    3667:	b8 0d 00 00 00       	mov    $0xd,%eax
    366c:	cd 40                	int    $0x40
    366e:	c3                   	ret    

0000366f <uptime>:
SYSCALL(uptime)
    366f:	b8 0e 00 00 00       	mov    $0xe,%eax
    3674:	cd 40                	int    $0x40
    3676:	c3                   	ret    

00003677 <mike>:
SYSCALL(mike)
    3677:	b8 16 00 00 00       	mov    $0x16,%eax
    367c:	cd 40                	int    $0x40
    367e:	c3                   	ret    
    367f:	90                   	nop

00003680 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3680:	55                   	push   %ebp
    3681:	89 e5                	mov    %esp,%ebp
    3683:	57                   	push   %edi
    3684:	56                   	push   %esi
    3685:	53                   	push   %ebx
    3686:	83 ec 3c             	sub    $0x3c,%esp
    3689:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    368b:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    368d:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3690:	85 db                	test   %ebx,%ebx
    3692:	74 04                	je     3698 <printint+0x18>
    3694:	85 d2                	test   %edx,%edx
    3696:	78 53                	js     36eb <printint+0x6b>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    3698:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
    369f:	31 db                	xor    %ebx,%ebx
    36a1:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
    36a4:	43                   	inc    %ebx
    36a5:	31 d2                	xor    %edx,%edx
    36a7:	f7 f1                	div    %ecx
    36a9:	8a 92 78 51 00 00    	mov    0x5178(%edx),%dl
    36af:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    36b2:	85 c0                	test   %eax,%eax
    36b4:	75 ee                	jne    36a4 <printint+0x24>
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    36b6:	89 d8                	mov    %ebx,%eax
  }while((x /= base) != 0);
  if(neg)
    36b8:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    36bb:	85 d2                	test   %edx,%edx
    36bd:	74 06                	je     36c5 <printint+0x45>
    buf[i++] = '-';
    36bf:	43                   	inc    %ebx
    36c0:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
    36c5:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
    36c9:	8d 76 00             	lea    0x0(%esi),%esi
    36cc:	8a 03                	mov    (%ebx),%al
    36ce:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    36d1:	50                   	push   %eax
    36d2:	6a 01                	push   $0x1
    36d4:	56                   	push   %esi
    36d5:	57                   	push   %edi
    36d6:	e8 1c ff ff ff       	call   35f7 <write>
    36db:	4b                   	dec    %ebx
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    36dc:	83 c4 10             	add    $0x10,%esp
    36df:	39 f3                	cmp    %esi,%ebx
    36e1:	75 e9                	jne    36cc <printint+0x4c>
    putc(fd, buf[i]);
}
    36e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    36e6:	5b                   	pop    %ebx
    36e7:	5e                   	pop    %esi
    36e8:	5f                   	pop    %edi
    36e9:	5d                   	pop    %ebp
    36ea:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    36eb:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    36ed:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
    36f4:	eb a9                	jmp    369f <printint+0x1f>
    36f6:	66 90                	xchg   %ax,%ax

000036f8 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    36f8:	55                   	push   %ebp
    36f9:	89 e5                	mov    %esp,%ebp
    36fb:	57                   	push   %edi
    36fc:	56                   	push   %esi
    36fd:	53                   	push   %ebx
    36fe:	83 ec 2c             	sub    $0x2c,%esp
    3701:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3704:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    3707:	8a 13                	mov    (%ebx),%dl
    3709:	84 d2                	test   %dl,%dl
    370b:	0f 84 a3 00 00 00    	je     37b4 <printf+0xbc>
    3711:	43                   	inc    %ebx
    3712:	8d 45 10             	lea    0x10(%ebp),%eax
    3715:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    3718:	31 ff                	xor    %edi,%edi
    371a:	eb 24                	jmp    3740 <printf+0x48>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    371c:	83 fa 25             	cmp    $0x25,%edx
    371f:	0f 84 97 00 00 00    	je     37bc <printf+0xc4>
        state = '%';
      } else {
        putc(fd, c);
    3725:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3728:	50                   	push   %eax
    3729:	6a 01                	push   $0x1
    372b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    372e:	50                   	push   %eax
    372f:	56                   	push   %esi
    3730:	e8 c2 fe ff ff       	call   35f7 <write>
    3735:	83 c4 10             	add    $0x10,%esp
    3738:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3739:	8a 53 ff             	mov    -0x1(%ebx),%dl
    373c:	84 d2                	test   %dl,%dl
    373e:	74 74                	je     37b4 <printf+0xbc>
    c = fmt[i] & 0xff;
    3740:	0f be c2             	movsbl %dl,%eax
    3743:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
    3746:	85 ff                	test   %edi,%edi
    3748:	74 d2                	je     371c <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    374a:	83 ff 25             	cmp    $0x25,%edi
    374d:	75 e9                	jne    3738 <printf+0x40>
      if(c == 'd'){
    374f:	83 fa 64             	cmp    $0x64,%edx
    3752:	0f 84 e8 00 00 00    	je     3840 <printf+0x148>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    3758:	25 f7 00 00 00       	and    $0xf7,%eax
    375d:	83 f8 70             	cmp    $0x70,%eax
    3760:	74 66                	je     37c8 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    3762:	83 fa 73             	cmp    $0x73,%edx
    3765:	0f 84 85 00 00 00    	je     37f0 <printf+0xf8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    376b:	83 fa 63             	cmp    $0x63,%edx
    376e:	0f 84 b5 00 00 00    	je     3829 <printf+0x131>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    3774:	83 fa 25             	cmp    $0x25,%edx
    3777:	0f 84 cf 00 00 00    	je     384c <printf+0x154>
    377d:	89 55 d0             	mov    %edx,-0x30(%ebp)
    3780:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3784:	50                   	push   %eax
    3785:	6a 01                	push   $0x1
    3787:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    378a:	50                   	push   %eax
    378b:	56                   	push   %esi
    378c:	e8 66 fe ff ff       	call   35f7 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    3791:	8b 55 d0             	mov    -0x30(%ebp),%edx
    3794:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3797:	83 c4 0c             	add    $0xc,%esp
    379a:	6a 01                	push   $0x1
    379c:	8d 45 e7             	lea    -0x19(%ebp),%eax
    379f:	50                   	push   %eax
    37a0:	56                   	push   %esi
    37a1:	e8 51 fe ff ff       	call   35f7 <write>
    37a6:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    37a9:	31 ff                	xor    %edi,%edi
    37ab:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    37ac:	8a 53 ff             	mov    -0x1(%ebx),%dl
    37af:	84 d2                	test   %dl,%dl
    37b1:	75 8d                	jne    3740 <printf+0x48>
    37b3:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    37b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    37b7:	5b                   	pop    %ebx
    37b8:	5e                   	pop    %esi
    37b9:	5f                   	pop    %edi
    37ba:	5d                   	pop    %ebp
    37bb:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    37bc:	bf 25 00 00 00       	mov    $0x25,%edi
    37c1:	e9 72 ff ff ff       	jmp    3738 <printf+0x40>
    37c6:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    37c8:	83 ec 0c             	sub    $0xc,%esp
    37cb:	6a 00                	push   $0x0
    37cd:	b9 10 00 00 00       	mov    $0x10,%ecx
    37d2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    37d5:	8b 17                	mov    (%edi),%edx
    37d7:	89 f0                	mov    %esi,%eax
    37d9:	e8 a2 fe ff ff       	call   3680 <printint>
        ap++;
    37de:	89 f8                	mov    %edi,%eax
    37e0:	83 c0 04             	add    $0x4,%eax
    37e3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    37e6:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    37e9:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
    37eb:	e9 48 ff ff ff       	jmp    3738 <printf+0x40>
      } else if(c == 's'){
        s = (char*)*ap;
    37f0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    37f3:	8b 38                	mov    (%eax),%edi
        ap++;
    37f5:	83 c0 04             	add    $0x4,%eax
    37f8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    37fb:	85 ff                	test   %edi,%edi
    37fd:	74 5c                	je     385b <printf+0x163>
          s = "(null)";
        while(*s != 0){
    37ff:	8a 07                	mov    (%edi),%al
    3801:	84 c0                	test   %al,%al
    3803:	74 1d                	je     3822 <printf+0x12a>
    3805:	8d 76 00             	lea    0x0(%esi),%esi
    3808:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    380b:	50                   	push   %eax
    380c:	6a 01                	push   $0x1
    380e:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    3811:	50                   	push   %eax
    3812:	56                   	push   %esi
    3813:	e8 df fd ff ff       	call   35f7 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    3818:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    3819:	8a 07                	mov    (%edi),%al
    381b:	83 c4 10             	add    $0x10,%esp
    381e:	84 c0                	test   %al,%al
    3820:	75 e6                	jne    3808 <printf+0x110>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3822:	31 ff                	xor    %edi,%edi
    3824:	e9 0f ff ff ff       	jmp    3738 <printf+0x40>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    3829:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    382c:	8b 07                	mov    (%edi),%eax
    382e:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3831:	51                   	push   %ecx
    3832:	6a 01                	push   $0x1
    3834:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    3837:	50                   	push   %eax
    3838:	56                   	push   %esi
    3839:	e8 b9 fd ff ff       	call   35f7 <write>
    383e:	eb 9e                	jmp    37de <printf+0xe6>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    3840:	83 ec 0c             	sub    $0xc,%esp
    3843:	6a 01                	push   $0x1
    3845:	b9 0a 00 00 00       	mov    $0xa,%ecx
    384a:	eb 86                	jmp    37d2 <printf+0xda>
    384c:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3850:	52                   	push   %edx
    3851:	6a 01                	push   $0x1
    3853:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    3856:	e9 44 ff ff ff       	jmp    379f <printf+0xa7>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
    385b:	bf 70 51 00 00       	mov    $0x5170,%edi
    3860:	eb 9d                	jmp    37ff <printf+0x107>
    3862:	66 90                	xchg   %ax,%ax

00003864 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3864:	55                   	push   %ebp
    3865:	89 e5                	mov    %esp,%ebp
    3867:	57                   	push   %edi
    3868:	56                   	push   %esi
    3869:	53                   	push   %ebx
    386a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    386d:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3870:	a1 00 5b 00 00       	mov    0x5b00,%eax
    3875:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3878:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    387a:	39 c8                	cmp    %ecx,%eax
    387c:	73 2e                	jae    38ac <free+0x48>
    387e:	39 d1                	cmp    %edx,%ecx
    3880:	72 04                	jb     3886 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3882:	39 d0                	cmp    %edx,%eax
    3884:	72 2e                	jb     38b4 <free+0x50>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3886:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3889:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    388c:	39 d7                	cmp    %edx,%edi
    388e:	74 28                	je     38b8 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    3890:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    3893:	8b 50 04             	mov    0x4(%eax),%edx
    3896:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3899:	39 f1                	cmp    %esi,%ecx
    389b:	74 32                	je     38cf <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    389d:	89 08                	mov    %ecx,(%eax)
  freep = p;
    389f:	a3 00 5b 00 00       	mov    %eax,0x5b00
}
    38a4:	5b                   	pop    %ebx
    38a5:	5e                   	pop    %esi
    38a6:	5f                   	pop    %edi
    38a7:	5d                   	pop    %ebp
    38a8:	c3                   	ret    
    38a9:	8d 76 00             	lea    0x0(%esi),%esi
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    38ac:	39 d0                	cmp    %edx,%eax
    38ae:	72 04                	jb     38b4 <free+0x50>
    38b0:	39 d1                	cmp    %edx,%ecx
    38b2:	72 d2                	jb     3886 <free+0x22>
static Header base;
static Header *freep;

void
free(void *ap)
{
    38b4:	89 d0                	mov    %edx,%eax
    38b6:	eb c0                	jmp    3878 <free+0x14>
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    38b8:	03 72 04             	add    0x4(%edx),%esi
    38bb:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    38be:	8b 10                	mov    (%eax),%edx
    38c0:	8b 12                	mov    (%edx),%edx
    38c2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    38c5:	8b 50 04             	mov    0x4(%eax),%edx
    38c8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    38cb:	39 f1                	cmp    %esi,%ecx
    38cd:	75 ce                	jne    389d <free+0x39>
    p->s.size += bp->s.size;
    38cf:	03 53 fc             	add    -0x4(%ebx),%edx
    38d2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    38d5:	8b 53 f8             	mov    -0x8(%ebx),%edx
    38d8:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    38da:	a3 00 5b 00 00       	mov    %eax,0x5b00
}
    38df:	5b                   	pop    %ebx
    38e0:	5e                   	pop    %esi
    38e1:	5f                   	pop    %edi
    38e2:	5d                   	pop    %ebp
    38e3:	c3                   	ret    

000038e4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    38e4:	55                   	push   %ebp
    38e5:	89 e5                	mov    %esp,%ebp
    38e7:	57                   	push   %edi
    38e8:	56                   	push   %esi
    38e9:	53                   	push   %ebx
    38ea:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    38ed:	8b 45 08             	mov    0x8(%ebp),%eax
    38f0:	8d 70 07             	lea    0x7(%eax),%esi
    38f3:	c1 ee 03             	shr    $0x3,%esi
    38f6:	46                   	inc    %esi
  if((prevp = freep) == 0){
    38f7:	8b 15 00 5b 00 00    	mov    0x5b00,%edx
    38fd:	85 d2                	test   %edx,%edx
    38ff:	0f 84 99 00 00 00    	je     399e <malloc+0xba>
    3905:	8b 02                	mov    (%edx),%eax
    3907:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    390a:	39 ce                	cmp    %ecx,%esi
    390c:	76 62                	jbe    3970 <malloc+0x8c>
    390e:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
    3915:	eb 0a                	jmp    3921 <malloc+0x3d>
    3917:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3918:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    391a:	8b 48 04             	mov    0x4(%eax),%ecx
    391d:	39 ce                	cmp    %ecx,%esi
    391f:	76 4f                	jbe    3970 <malloc+0x8c>
    3921:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3923:	3b 05 00 5b 00 00    	cmp    0x5b00,%eax
    3929:	75 ed                	jne    3918 <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    392b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
    3931:	77 5d                	ja     3990 <malloc+0xac>
    3933:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
    3938:	bf 00 10 00 00       	mov    $0x1000,%edi
  p = sbrk(nu * sizeof(Header));
    393d:	83 ec 0c             	sub    $0xc,%esp
    3940:	50                   	push   %eax
    3941:	e8 19 fd ff ff       	call   365f <sbrk>
  if(p == (char*)-1)
    3946:	83 c4 10             	add    $0x10,%esp
    3949:	83 f8 ff             	cmp    $0xffffffff,%eax
    394c:	74 1c                	je     396a <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    394e:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    3951:	83 ec 0c             	sub    $0xc,%esp
    3954:	83 c0 08             	add    $0x8,%eax
    3957:	50                   	push   %eax
    3958:	e8 07 ff ff ff       	call   3864 <free>
  return freep;
    395d:	8b 15 00 5b 00 00    	mov    0x5b00,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    3963:	83 c4 10             	add    $0x10,%esp
    3966:	85 d2                	test   %edx,%edx
    3968:	75 ae                	jne    3918 <malloc+0x34>
        return 0;
    396a:	31 c0                	xor    %eax,%eax
    396c:	eb 1a                	jmp    3988 <malloc+0xa4>
    396e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    3970:	39 ce                	cmp    %ecx,%esi
    3972:	74 24                	je     3998 <malloc+0xb4>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    3974:	29 f1                	sub    %esi,%ecx
    3976:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    3979:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    397c:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
    397f:	89 15 00 5b 00 00    	mov    %edx,0x5b00
      return (void*)(p + 1);
    3985:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    3988:	8d 65 f4             	lea    -0xc(%ebp),%esp
    398b:	5b                   	pop    %ebx
    398c:	5e                   	pop    %esi
    398d:	5f                   	pop    %edi
    398e:	5d                   	pop    %ebp
    398f:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    3990:	89 d8                	mov    %ebx,%eax
    3992:	89 f7                	mov    %esi,%edi
    3994:	eb a7                	jmp    393d <malloc+0x59>
    3996:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    3998:	8b 08                	mov    (%eax),%ecx
    399a:	89 0a                	mov    %ecx,(%edx)
    399c:	eb e1                	jmp    397f <malloc+0x9b>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    399e:	c7 05 00 5b 00 00 04 	movl   $0x5b04,0x5b00
    39a5:	5b 00 00 
    39a8:	c7 05 04 5b 00 00 04 	movl   $0x5b04,0x5b04
    39af:	5b 00 00 
    base.s.size = 0;
    39b2:	c7 05 08 5b 00 00 00 	movl   $0x0,0x5b08
    39b9:	00 00 00 
    39bc:	b8 04 5b 00 00       	mov    $0x5b04,%eax
    39c1:	e9 48 ff ff ff       	jmp    390e <malloc+0x2a>
