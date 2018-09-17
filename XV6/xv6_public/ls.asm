
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  close(fd);
}

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 08             	sub    $0x8,%esp
  14:	8b 31                	mov    (%ecx),%esi
  16:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
  19:	83 fe 01             	cmp    $0x1,%esi
  1c:	7e 1e                	jle    3c <main+0x3c>
  1e:	bb 01 00 00 00       	mov    $0x1,%ebx
  23:	90                   	nop
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
  24:	83 ec 0c             	sub    $0xc,%esp
  27:	ff 34 9f             	pushl  (%edi,%ebx,4)
  2a:	e8 b9 00 00 00       	call   e8 <ls>

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
  2f:	43                   	inc    %ebx
  30:	83 c4 10             	add    $0x10,%esp
  33:	39 f3                	cmp    %esi,%ebx
  35:	75 ed                	jne    24 <main+0x24>
    ls(argv[i]);
  exit();
  37:	e8 77 04 00 00       	call   4b3 <exit>
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    ls(".");
  3c:	83 ec 0c             	sub    $0xc,%esp
  3f:	68 ec 08 00 00       	push   $0x8ec
  44:	e8 9f 00 00 00       	call   e8 <ls>
    exit();
  49:	e8 65 04 00 00       	call   4b3 <exit>
  4e:	66 90                	xchg   %ax,%ax

00000050 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	56                   	push   %esi
  54:	53                   	push   %ebx
  55:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  58:	83 ec 0c             	sub    $0xc,%esp
  5b:	53                   	push   %ebx
  5c:	e8 ff 02 00 00       	call   360 <strlen>
  61:	83 c4 10             	add    $0x10,%esp
  64:	01 d8                	add    %ebx,%eax
  66:	73 09                	jae    71 <fmtname+0x21>
  68:	eb 0c                	jmp    76 <fmtname+0x26>
  6a:	66 90                	xchg   %ax,%ax
  6c:	48                   	dec    %eax
  6d:	39 c3                	cmp    %eax,%ebx
  6f:	77 05                	ja     76 <fmtname+0x26>
  71:	80 38 2f             	cmpb   $0x2f,(%eax)
  74:	75 f6                	jne    6c <fmtname+0x1c>
    ;
  p++;
  76:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  79:	83 ec 0c             	sub    $0xc,%esp
  7c:	53                   	push   %ebx
  7d:	e8 de 02 00 00       	call   360 <strlen>
  82:	83 c4 10             	add    $0x10,%esp
  85:	83 f8 0d             	cmp    $0xd,%eax
  88:	76 0a                	jbe    94 <fmtname+0x44>
    return p;
  8a:	89 d8                	mov    %ebx,%eax
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  8c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8f:	5b                   	pop    %ebx
  90:	5e                   	pop    %esi
  91:	5d                   	pop    %ebp
  92:	c3                   	ret    
  93:	90                   	nop
  p++;

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    return p;
  memmove(buf, p, strlen(p));
  94:	83 ec 0c             	sub    $0xc,%esp
  97:	53                   	push   %ebx
  98:	e8 c3 02 00 00       	call   360 <strlen>
  9d:	83 c4 0c             	add    $0xc,%esp
  a0:	50                   	push   %eax
  a1:	53                   	push   %ebx
  a2:	68 00 0c 00 00       	push   $0xc00
  a7:	e8 dc 03 00 00       	call   488 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  ac:	89 1c 24             	mov    %ebx,(%esp)
  af:	e8 ac 02 00 00       	call   360 <strlen>
  b4:	89 c6                	mov    %eax,%esi
  b6:	89 1c 24             	mov    %ebx,(%esp)
  b9:	e8 a2 02 00 00       	call   360 <strlen>
  be:	89 c2                	mov    %eax,%edx
  c0:	83 c4 0c             	add    $0xc,%esp
  c3:	b8 0e 00 00 00       	mov    $0xe,%eax
  c8:	29 f0                	sub    %esi,%eax
  ca:	50                   	push   %eax
  cb:	6a 20                	push   $0x20
  cd:	8d 82 00 0c 00 00    	lea    0xc00(%edx),%eax
  d3:	50                   	push   %eax
  d4:	e8 a7 02 00 00       	call   380 <memset>
  return buf;
  d9:	83 c4 10             	add    $0x10,%esp
  dc:	b8 00 0c 00 00       	mov    $0xc00,%eax
}
  e1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  e4:	5b                   	pop    %ebx
  e5:	5e                   	pop    %esi
  e6:	5d                   	pop    %ebp
  e7:	c3                   	ret    

000000e8 <ls>:

void
ls(char *path)
{
  e8:	55                   	push   %ebp
  e9:	89 e5                	mov    %esp,%ebp
  eb:	57                   	push   %edi
  ec:	56                   	push   %esi
  ed:	53                   	push   %ebx
  ee:	81 ec 64 02 00 00    	sub    $0x264,%esp
  f4:	8b 7d 08             	mov    0x8(%ebp),%edi
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  f7:	6a 00                	push   $0x0
  f9:	57                   	push   %edi
  fa:	e8 f4 03 00 00       	call   4f3 <open>
  ff:	89 c3                	mov    %eax,%ebx
 101:	83 c4 10             	add    $0x10,%esp
 104:	85 c0                	test   %eax,%eax
 106:	0f 88 8c 01 00 00    	js     298 <ls+0x1b0>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
 10c:	83 ec 08             	sub    $0x8,%esp
 10f:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
 115:	56                   	push   %esi
 116:	50                   	push   %eax
 117:	e8 ef 03 00 00       	call   50b <fstat>
 11c:	83 c4 10             	add    $0x10,%esp
 11f:	85 c0                	test   %eax,%eax
 121:	0f 88 a5 01 00 00    	js     2cc <ls+0x1e4>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
 127:	8b 85 d4 fd ff ff    	mov    -0x22c(%ebp),%eax
 12d:	66 83 f8 01          	cmp    $0x1,%ax
 131:	74 51                	je     184 <ls+0x9c>
 133:	66 83 f8 02          	cmp    $0x2,%ax
 137:	75 37                	jne    170 <ls+0x88>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 139:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 13f:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 145:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
 14b:	83 ec 0c             	sub    $0xc,%esp
 14e:	57                   	push   %edi
 14f:	e8 fc fe ff ff       	call   50 <fmtname>
 154:	59                   	pop    %ecx
 155:	5f                   	pop    %edi
 156:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 15c:	52                   	push   %edx
 15d:	56                   	push   %esi
 15e:	6a 02                	push   $0x2
 160:	50                   	push   %eax
 161:	68 cc 08 00 00       	push   $0x8cc
 166:	6a 01                	push   $0x1
 168:	e8 67 04 00 00       	call   5d4 <printf>
    break;
 16d:	83 c4 20             	add    $0x20,%esp
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 170:	83 ec 0c             	sub    $0xc,%esp
 173:	53                   	push   %ebx
 174:	e8 62 03 00 00       	call   4db <close>
 179:	83 c4 10             	add    $0x10,%esp
}
 17c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 17f:	5b                   	pop    %ebx
 180:	5e                   	pop    %esi
 181:	5f                   	pop    %edi
 182:	5d                   	pop    %ebp
 183:	c3                   	ret    
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    break;

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 184:	83 ec 0c             	sub    $0xc,%esp
 187:	57                   	push   %edi
 188:	e8 d3 01 00 00       	call   360 <strlen>
 18d:	83 c0 10             	add    $0x10,%eax
 190:	83 c4 10             	add    $0x10,%esp
 193:	3d 00 02 00 00       	cmp    $0x200,%eax
 198:	0f 87 16 01 00 00    	ja     2b4 <ls+0x1cc>
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
 19e:	83 ec 08             	sub    $0x8,%esp
 1a1:	57                   	push   %edi
 1a2:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 1a8:	50                   	push   %eax
 1a9:	e8 5a 01 00 00       	call   308 <strcpy>
    p = buf+strlen(buf);
 1ae:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 1b4:	89 04 24             	mov    %eax,(%esp)
 1b7:	e8 a4 01 00 00       	call   360 <strlen>
 1bc:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
 1c2:	01 c8                	add    %ecx,%eax
 1c4:	89 85 a8 fd ff ff    	mov    %eax,-0x258(%ebp)
    *p++ = '/';
 1ca:	8d 48 01             	lea    0x1(%eax),%ecx
 1cd:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 1d3:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1d6:	83 c4 10             	add    $0x10,%esp
 1d9:	8d bd c4 fd ff ff    	lea    -0x23c(%ebp),%edi
 1df:	90                   	nop
 1e0:	50                   	push   %eax
 1e1:	6a 10                	push   $0x10
 1e3:	57                   	push   %edi
 1e4:	53                   	push   %ebx
 1e5:	e8 e1 02 00 00       	call   4cb <read>
 1ea:	83 c4 10             	add    $0x10,%esp
 1ed:	83 f8 10             	cmp    $0x10,%eax
 1f0:	0f 85 7a ff ff ff    	jne    170 <ls+0x88>
      if(de.inum == 0)
 1f6:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
 1fd:	00 
 1fe:	74 e0                	je     1e0 <ls+0xf8>
        continue;
      memmove(p, de.name, DIRSIZ);
 200:	50                   	push   %eax
 201:	6a 0e                	push   $0xe
 203:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
 209:	50                   	push   %eax
 20a:	ff b5 a4 fd ff ff    	pushl  -0x25c(%ebp)
 210:	e8 73 02 00 00       	call   488 <memmove>
      p[DIRSIZ] = 0;
 215:	8b 85 a8 fd ff ff    	mov    -0x258(%ebp),%eax
 21b:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 21f:	58                   	pop    %eax
 220:	5a                   	pop    %edx
 221:	56                   	push   %esi
 222:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 228:	50                   	push   %eax
 229:	e8 e2 01 00 00       	call   410 <stat>
 22e:	83 c4 10             	add    $0x10,%esp
 231:	85 c0                	test   %eax,%eax
 233:	0f 88 b3 00 00 00    	js     2ec <ls+0x204>
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 239:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 23f:	89 8d ac fd ff ff    	mov    %ecx,-0x254(%ebp)
 245:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
 24b:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
 251:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
 258:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 25e:	83 ec 0c             	sub    $0xc,%esp
 261:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
 267:	51                   	push   %ecx
 268:	e8 e3 fd ff ff       	call   50 <fmtname>
 26d:	5a                   	pop    %edx
 26e:	59                   	pop    %ecx
 26f:	8b 8d ac fd ff ff    	mov    -0x254(%ebp),%ecx
 275:	51                   	push   %ecx
 276:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
 27c:	52                   	push   %edx
 27d:	ff b5 b4 fd ff ff    	pushl  -0x24c(%ebp)
 283:	50                   	push   %eax
 284:	68 cc 08 00 00       	push   $0x8cc
 289:	6a 01                	push   $0x1
 28b:	e8 44 03 00 00       	call   5d4 <printf>
 290:	83 c4 20             	add    $0x20,%esp
 293:	e9 48 ff ff ff       	jmp    1e0 <ls+0xf8>
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
    printf(2, "ls: cannot open %s\n", path);
 298:	50                   	push   %eax
 299:	57                   	push   %edi
 29a:	68 a4 08 00 00       	push   $0x8a4
 29f:	6a 02                	push   $0x2
 2a1:	e8 2e 03 00 00       	call   5d4 <printf>
    return;
 2a6:	83 c4 10             	add    $0x10,%esp
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
}
 2a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2ac:	5b                   	pop    %ebx
 2ad:	5e                   	pop    %esi
 2ae:	5f                   	pop    %edi
 2af:	5d                   	pop    %ebp
 2b0:	c3                   	ret    
 2b1:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    break;

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf(1, "ls: path too long\n");
 2b4:	83 ec 08             	sub    $0x8,%esp
 2b7:	68 d9 08 00 00       	push   $0x8d9
 2bc:	6a 01                	push   $0x1
 2be:	e8 11 03 00 00       	call   5d4 <printf>
      break;
 2c3:	83 c4 10             	add    $0x10,%esp
 2c6:	e9 a5 fe ff ff       	jmp    170 <ls+0x88>
 2cb:	90                   	nop
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
    printf(2, "ls: cannot stat %s\n", path);
 2cc:	50                   	push   %eax
 2cd:	57                   	push   %edi
 2ce:	68 b8 08 00 00       	push   $0x8b8
 2d3:	6a 02                	push   $0x2
 2d5:	e8 fa 02 00 00       	call   5d4 <printf>
    close(fd);
 2da:	89 1c 24             	mov    %ebx,(%esp)
 2dd:	e8 f9 01 00 00       	call   4db <close>
    return;
 2e2:	83 c4 10             	add    $0x10,%esp
 2e5:	e9 92 fe ff ff       	jmp    17c <ls+0x94>
 2ea:	66 90                	xchg   %ax,%ax
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
      if(stat(buf, &st) < 0){
        printf(1, "ls: cannot stat %s\n", buf);
 2ec:	50                   	push   %eax
 2ed:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 2f3:	50                   	push   %eax
 2f4:	68 b8 08 00 00       	push   $0x8b8
 2f9:	6a 01                	push   $0x1
 2fb:	e8 d4 02 00 00       	call   5d4 <printf>
        continue;
 300:	83 c4 10             	add    $0x10,%esp
 303:	e9 d8 fe ff ff       	jmp    1e0 <ls+0xf8>

00000308 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 308:	55                   	push   %ebp
 309:	89 e5                	mov    %esp,%ebp
 30b:	53                   	push   %ebx
 30c:	8b 45 08             	mov    0x8(%ebp),%eax
 30f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 312:	89 c2                	mov    %eax,%edx
 314:	42                   	inc    %edx
 315:	41                   	inc    %ecx
 316:	8a 59 ff             	mov    -0x1(%ecx),%bl
 319:	88 5a ff             	mov    %bl,-0x1(%edx)
 31c:	84 db                	test   %bl,%bl
 31e:	75 f4                	jne    314 <strcpy+0xc>
    ;
  return os;
}
 320:	5b                   	pop    %ebx
 321:	5d                   	pop    %ebp
 322:	c3                   	ret    
 323:	90                   	nop

00000324 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 324:	55                   	push   %ebp
 325:	89 e5                	mov    %esp,%ebp
 327:	56                   	push   %esi
 328:	53                   	push   %ebx
 329:	8b 55 08             	mov    0x8(%ebp),%edx
 32c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 32f:	0f b6 02             	movzbl (%edx),%eax
 332:	0f b6 0b             	movzbl (%ebx),%ecx
 335:	84 c0                	test   %al,%al
 337:	75 14                	jne    34d <strcmp+0x29>
 339:	eb 1d                	jmp    358 <strcmp+0x34>
 33b:	90                   	nop
    p++, q++;
 33c:	42                   	inc    %edx
 33d:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 340:	0f b6 02             	movzbl (%edx),%eax
 343:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 347:	84 c0                	test   %al,%al
 349:	74 0d                	je     358 <strcmp+0x34>
 34b:	89 f3                	mov    %esi,%ebx
 34d:	38 c8                	cmp    %cl,%al
 34f:	74 eb                	je     33c <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 351:	29 c8                	sub    %ecx,%eax
}
 353:	5b                   	pop    %ebx
 354:	5e                   	pop    %esi
 355:	5d                   	pop    %ebp
 356:	c3                   	ret    
 357:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 358:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 35a:	29 c8                	sub    %ecx,%eax
}
 35c:	5b                   	pop    %ebx
 35d:	5e                   	pop    %esi
 35e:	5d                   	pop    %ebp
 35f:	c3                   	ret    

00000360 <strlen>:

uint
strlen(char *s)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 366:	80 39 00             	cmpb   $0x0,(%ecx)
 369:	74 10                	je     37b <strlen+0x1b>
 36b:	31 d2                	xor    %edx,%edx
 36d:	8d 76 00             	lea    0x0(%esi),%esi
 370:	42                   	inc    %edx
 371:	89 d0                	mov    %edx,%eax
 373:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 377:	75 f7                	jne    370 <strlen+0x10>
    ;
  return n;
}
 379:	5d                   	pop    %ebp
 37a:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 37b:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 37d:	5d                   	pop    %ebp
 37e:	c3                   	ret    
 37f:	90                   	nop

00000380 <memset>:

void*
memset(void *dst, int c, uint n)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 387:	89 d7                	mov    %edx,%edi
 389:	8b 4d 10             	mov    0x10(%ebp),%ecx
 38c:	8b 45 0c             	mov    0xc(%ebp),%eax
 38f:	fc                   	cld    
 390:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 392:	89 d0                	mov    %edx,%eax
 394:	5f                   	pop    %edi
 395:	5d                   	pop    %ebp
 396:	c3                   	ret    
 397:	90                   	nop

00000398 <strchr>:

char*
strchr(const char *s, char c)
{
 398:	55                   	push   %ebp
 399:	89 e5                	mov    %esp,%ebp
 39b:	53                   	push   %ebx
 39c:	8b 45 08             	mov    0x8(%ebp),%eax
 39f:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 3a2:	8a 18                	mov    (%eax),%bl
 3a4:	84 db                	test   %bl,%bl
 3a6:	74 13                	je     3bb <strchr+0x23>
 3a8:	88 d1                	mov    %dl,%cl
    if(*s == c)
 3aa:	38 d3                	cmp    %dl,%bl
 3ac:	75 06                	jne    3b4 <strchr+0x1c>
 3ae:	eb 0d                	jmp    3bd <strchr+0x25>
 3b0:	38 ca                	cmp    %cl,%dl
 3b2:	74 09                	je     3bd <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 3b4:	40                   	inc    %eax
 3b5:	8a 10                	mov    (%eax),%dl
 3b7:	84 d2                	test   %dl,%dl
 3b9:	75 f5                	jne    3b0 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 3bb:	31 c0                	xor    %eax,%eax
}
 3bd:	5b                   	pop    %ebx
 3be:	5d                   	pop    %ebp
 3bf:	c3                   	ret    

000003c0 <gets>:

char*
gets(char *buf, int max)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	57                   	push   %edi
 3c4:	56                   	push   %esi
 3c5:	53                   	push   %ebx
 3c6:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3c9:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 3cb:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3ce:	eb 26                	jmp    3f6 <gets+0x36>
    cc = read(0, &c, 1);
 3d0:	50                   	push   %eax
 3d1:	6a 01                	push   $0x1
 3d3:	57                   	push   %edi
 3d4:	6a 00                	push   $0x0
 3d6:	e8 f0 00 00 00       	call   4cb <read>
    if(cc < 1)
 3db:	83 c4 10             	add    $0x10,%esp
 3de:	85 c0                	test   %eax,%eax
 3e0:	7e 1c                	jle    3fe <gets+0x3e>
      break;
    buf[i++] = c;
 3e2:	8a 45 e7             	mov    -0x19(%ebp),%al
 3e5:	8b 55 08             	mov    0x8(%ebp),%edx
 3e8:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
 3ec:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 3ee:	3c 0a                	cmp    $0xa,%al
 3f0:	74 0c                	je     3fe <gets+0x3e>
 3f2:	3c 0d                	cmp    $0xd,%al
 3f4:	74 08                	je     3fe <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3f6:	8d 5e 01             	lea    0x1(%esi),%ebx
 3f9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3fc:	7c d2                	jl     3d0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3fe:	8b 45 08             	mov    0x8(%ebp),%eax
 401:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 405:	8d 65 f4             	lea    -0xc(%ebp),%esp
 408:	5b                   	pop    %ebx
 409:	5e                   	pop    %esi
 40a:	5f                   	pop    %edi
 40b:	5d                   	pop    %ebp
 40c:	c3                   	ret    
 40d:	8d 76 00             	lea    0x0(%esi),%esi

00000410 <stat>:

int
stat(char *n, struct stat *st)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	56                   	push   %esi
 414:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 415:	83 ec 08             	sub    $0x8,%esp
 418:	6a 00                	push   $0x0
 41a:	ff 75 08             	pushl  0x8(%ebp)
 41d:	e8 d1 00 00 00       	call   4f3 <open>
 422:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 424:	83 c4 10             	add    $0x10,%esp
 427:	85 c0                	test   %eax,%eax
 429:	78 25                	js     450 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 42b:	83 ec 08             	sub    $0x8,%esp
 42e:	ff 75 0c             	pushl  0xc(%ebp)
 431:	50                   	push   %eax
 432:	e8 d4 00 00 00       	call   50b <fstat>
 437:	89 c6                	mov    %eax,%esi
  close(fd);
 439:	89 1c 24             	mov    %ebx,(%esp)
 43c:	e8 9a 00 00 00       	call   4db <close>
  return r;
 441:	83 c4 10             	add    $0x10,%esp
 444:	89 f0                	mov    %esi,%eax
}
 446:	8d 65 f8             	lea    -0x8(%ebp),%esp
 449:	5b                   	pop    %ebx
 44a:	5e                   	pop    %esi
 44b:	5d                   	pop    %ebp
 44c:	c3                   	ret    
 44d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 450:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 455:	eb ef                	jmp    446 <stat+0x36>
 457:	90                   	nop

00000458 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 458:	55                   	push   %ebp
 459:	89 e5                	mov    %esp,%ebp
 45b:	53                   	push   %ebx
 45c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 45f:	0f be 11             	movsbl (%ecx),%edx
 462:	8d 42 d0             	lea    -0x30(%edx),%eax
 465:	3c 09                	cmp    $0x9,%al
 467:	b8 00 00 00 00       	mov    $0x0,%eax
 46c:	77 15                	ja     483 <atoi+0x2b>
 46e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 470:	41                   	inc    %ecx
 471:	8d 04 80             	lea    (%eax,%eax,4),%eax
 474:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 478:	0f be 11             	movsbl (%ecx),%edx
 47b:	8d 5a d0             	lea    -0x30(%edx),%ebx
 47e:	80 fb 09             	cmp    $0x9,%bl
 481:	76 ed                	jbe    470 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 483:	5b                   	pop    %ebx
 484:	5d                   	pop    %ebp
 485:	c3                   	ret    
 486:	66 90                	xchg   %ax,%ax

00000488 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 488:	55                   	push   %ebp
 489:	89 e5                	mov    %esp,%ebp
 48b:	56                   	push   %esi
 48c:	53                   	push   %ebx
 48d:	8b 45 08             	mov    0x8(%ebp),%eax
 490:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 493:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 496:	31 d2                	xor    %edx,%edx
 498:	85 f6                	test   %esi,%esi
 49a:	7e 0b                	jle    4a7 <memmove+0x1f>
    *dst++ = *src++;
 49c:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 49f:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 4a2:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4a3:	39 f2                	cmp    %esi,%edx
 4a5:	75 f5                	jne    49c <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 4a7:	5b                   	pop    %ebx
 4a8:	5e                   	pop    %esi
 4a9:	5d                   	pop    %ebp
 4aa:	c3                   	ret    

000004ab <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4ab:	b8 01 00 00 00       	mov    $0x1,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <exit>:
SYSCALL(exit)
 4b3:	b8 02 00 00 00       	mov    $0x2,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    

000004bb <wait>:
SYSCALL(wait)
 4bb:	b8 03 00 00 00       	mov    $0x3,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret    

000004c3 <pipe>:
SYSCALL(pipe)
 4c3:	b8 04 00 00 00       	mov    $0x4,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret    

000004cb <read>:
SYSCALL(read)
 4cb:	b8 05 00 00 00       	mov    $0x5,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret    

000004d3 <write>:
SYSCALL(write)
 4d3:	b8 10 00 00 00       	mov    $0x10,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret    

000004db <close>:
SYSCALL(close)
 4db:	b8 15 00 00 00       	mov    $0x15,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret    

000004e3 <kill>:
SYSCALL(kill)
 4e3:	b8 06 00 00 00       	mov    $0x6,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret    

000004eb <exec>:
SYSCALL(exec)
 4eb:	b8 07 00 00 00       	mov    $0x7,%eax
 4f0:	cd 40                	int    $0x40
 4f2:	c3                   	ret    

000004f3 <open>:
SYSCALL(open)
 4f3:	b8 0f 00 00 00       	mov    $0xf,%eax
 4f8:	cd 40                	int    $0x40
 4fa:	c3                   	ret    

000004fb <mknod>:
SYSCALL(mknod)
 4fb:	b8 11 00 00 00       	mov    $0x11,%eax
 500:	cd 40                	int    $0x40
 502:	c3                   	ret    

00000503 <unlink>:
SYSCALL(unlink)
 503:	b8 12 00 00 00       	mov    $0x12,%eax
 508:	cd 40                	int    $0x40
 50a:	c3                   	ret    

0000050b <fstat>:
SYSCALL(fstat)
 50b:	b8 08 00 00 00       	mov    $0x8,%eax
 510:	cd 40                	int    $0x40
 512:	c3                   	ret    

00000513 <link>:
SYSCALL(link)
 513:	b8 13 00 00 00       	mov    $0x13,%eax
 518:	cd 40                	int    $0x40
 51a:	c3                   	ret    

0000051b <mkdir>:
SYSCALL(mkdir)
 51b:	b8 14 00 00 00       	mov    $0x14,%eax
 520:	cd 40                	int    $0x40
 522:	c3                   	ret    

00000523 <chdir>:
SYSCALL(chdir)
 523:	b8 09 00 00 00       	mov    $0x9,%eax
 528:	cd 40                	int    $0x40
 52a:	c3                   	ret    

0000052b <dup>:
SYSCALL(dup)
 52b:	b8 0a 00 00 00       	mov    $0xa,%eax
 530:	cd 40                	int    $0x40
 532:	c3                   	ret    

00000533 <getpid>:
SYSCALL(getpid)
 533:	b8 0b 00 00 00       	mov    $0xb,%eax
 538:	cd 40                	int    $0x40
 53a:	c3                   	ret    

0000053b <sbrk>:
SYSCALL(sbrk)
 53b:	b8 0c 00 00 00       	mov    $0xc,%eax
 540:	cd 40                	int    $0x40
 542:	c3                   	ret    

00000543 <sleep>:
SYSCALL(sleep)
 543:	b8 0d 00 00 00       	mov    $0xd,%eax
 548:	cd 40                	int    $0x40
 54a:	c3                   	ret    

0000054b <uptime>:
SYSCALL(uptime)
 54b:	b8 0e 00 00 00       	mov    $0xe,%eax
 550:	cd 40                	int    $0x40
 552:	c3                   	ret    

00000553 <mike>:
SYSCALL(mike)
 553:	b8 16 00 00 00       	mov    $0x16,%eax
 558:	cd 40                	int    $0x40
 55a:	c3                   	ret    
 55b:	90                   	nop

0000055c <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 55c:	55                   	push   %ebp
 55d:	89 e5                	mov    %esp,%ebp
 55f:	57                   	push   %edi
 560:	56                   	push   %esi
 561:	53                   	push   %ebx
 562:	83 ec 3c             	sub    $0x3c,%esp
 565:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 567:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 569:	8b 5d 08             	mov    0x8(%ebp),%ebx
 56c:	85 db                	test   %ebx,%ebx
 56e:	74 04                	je     574 <printint+0x18>
 570:	85 d2                	test   %edx,%edx
 572:	78 53                	js     5c7 <printint+0x6b>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 574:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 57b:	31 db                	xor    %ebx,%ebx
 57d:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 580:	43                   	inc    %ebx
 581:	31 d2                	xor    %edx,%edx
 583:	f7 f1                	div    %ecx
 585:	8a 92 f8 08 00 00    	mov    0x8f8(%edx),%dl
 58b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 58e:	85 c0                	test   %eax,%eax
 590:	75 ee                	jne    580 <printint+0x24>
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 592:	89 d8                	mov    %ebx,%eax
  }while((x /= base) != 0);
  if(neg)
 594:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 597:	85 d2                	test   %edx,%edx
 599:	74 06                	je     5a1 <printint+0x45>
    buf[i++] = '-';
 59b:	43                   	inc    %ebx
 59c:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 5a1:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 5a5:	8d 76 00             	lea    0x0(%esi),%esi
 5a8:	8a 03                	mov    (%ebx),%al
 5aa:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5ad:	50                   	push   %eax
 5ae:	6a 01                	push   $0x1
 5b0:	56                   	push   %esi
 5b1:	57                   	push   %edi
 5b2:	e8 1c ff ff ff       	call   4d3 <write>
 5b7:	4b                   	dec    %ebx
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5b8:	83 c4 10             	add    $0x10,%esp
 5bb:	39 f3                	cmp    %esi,%ebx
 5bd:	75 e9                	jne    5a8 <printint+0x4c>
    putc(fd, buf[i]);
}
 5bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5c2:	5b                   	pop    %ebx
 5c3:	5e                   	pop    %esi
 5c4:	5f                   	pop    %edi
 5c5:	5d                   	pop    %ebp
 5c6:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 5c7:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 5c9:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 5d0:	eb a9                	jmp    57b <printint+0x1f>
 5d2:	66 90                	xchg   %ax,%ax

000005d4 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5d4:	55                   	push   %ebp
 5d5:	89 e5                	mov    %esp,%ebp
 5d7:	57                   	push   %edi
 5d8:	56                   	push   %esi
 5d9:	53                   	push   %ebx
 5da:	83 ec 2c             	sub    $0x2c,%esp
 5dd:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5e0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 5e3:	8a 13                	mov    (%ebx),%dl
 5e5:	84 d2                	test   %dl,%dl
 5e7:	0f 84 a3 00 00 00    	je     690 <printf+0xbc>
 5ed:	43                   	inc    %ebx
 5ee:	8d 45 10             	lea    0x10(%ebp),%eax
 5f1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 5f4:	31 ff                	xor    %edi,%edi
 5f6:	eb 24                	jmp    61c <printf+0x48>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5f8:	83 fa 25             	cmp    $0x25,%edx
 5fb:	0f 84 97 00 00 00    	je     698 <printf+0xc4>
        state = '%';
      } else {
        putc(fd, c);
 601:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 604:	50                   	push   %eax
 605:	6a 01                	push   $0x1
 607:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 60a:	50                   	push   %eax
 60b:	56                   	push   %esi
 60c:	e8 c2 fe ff ff       	call   4d3 <write>
 611:	83 c4 10             	add    $0x10,%esp
 614:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 615:	8a 53 ff             	mov    -0x1(%ebx),%dl
 618:	84 d2                	test   %dl,%dl
 61a:	74 74                	je     690 <printf+0xbc>
    c = fmt[i] & 0xff;
 61c:	0f be c2             	movsbl %dl,%eax
 61f:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
 622:	85 ff                	test   %edi,%edi
 624:	74 d2                	je     5f8 <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 626:	83 ff 25             	cmp    $0x25,%edi
 629:	75 e9                	jne    614 <printf+0x40>
      if(c == 'd'){
 62b:	83 fa 64             	cmp    $0x64,%edx
 62e:	0f 84 e8 00 00 00    	je     71c <printf+0x148>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 634:	25 f7 00 00 00       	and    $0xf7,%eax
 639:	83 f8 70             	cmp    $0x70,%eax
 63c:	74 66                	je     6a4 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 63e:	83 fa 73             	cmp    $0x73,%edx
 641:	0f 84 85 00 00 00    	je     6cc <printf+0xf8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 647:	83 fa 63             	cmp    $0x63,%edx
 64a:	0f 84 b5 00 00 00    	je     705 <printf+0x131>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 650:	83 fa 25             	cmp    $0x25,%edx
 653:	0f 84 cf 00 00 00    	je     728 <printf+0x154>
 659:	89 55 d0             	mov    %edx,-0x30(%ebp)
 65c:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 660:	50                   	push   %eax
 661:	6a 01                	push   $0x1
 663:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 666:	50                   	push   %eax
 667:	56                   	push   %esi
 668:	e8 66 fe ff ff       	call   4d3 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 66d:	8b 55 d0             	mov    -0x30(%ebp),%edx
 670:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 673:	83 c4 0c             	add    $0xc,%esp
 676:	6a 01                	push   $0x1
 678:	8d 45 e7             	lea    -0x19(%ebp),%eax
 67b:	50                   	push   %eax
 67c:	56                   	push   %esi
 67d:	e8 51 fe ff ff       	call   4d3 <write>
 682:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 685:	31 ff                	xor    %edi,%edi
 687:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 688:	8a 53 ff             	mov    -0x1(%ebx),%dl
 68b:	84 d2                	test   %dl,%dl
 68d:	75 8d                	jne    61c <printf+0x48>
 68f:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 690:	8d 65 f4             	lea    -0xc(%ebp),%esp
 693:	5b                   	pop    %ebx
 694:	5e                   	pop    %esi
 695:	5f                   	pop    %edi
 696:	5d                   	pop    %ebp
 697:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 698:	bf 25 00 00 00       	mov    $0x25,%edi
 69d:	e9 72 ff ff ff       	jmp    614 <printf+0x40>
 6a2:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 6a4:	83 ec 0c             	sub    $0xc,%esp
 6a7:	6a 00                	push   $0x0
 6a9:	b9 10 00 00 00       	mov    $0x10,%ecx
 6ae:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 6b1:	8b 17                	mov    (%edi),%edx
 6b3:	89 f0                	mov    %esi,%eax
 6b5:	e8 a2 fe ff ff       	call   55c <printint>
        ap++;
 6ba:	89 f8                	mov    %edi,%eax
 6bc:	83 c0 04             	add    $0x4,%eax
 6bf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 6c2:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6c5:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 6c7:	e9 48 ff ff ff       	jmp    614 <printf+0x40>
      } else if(c == 's'){
        s = (char*)*ap;
 6cc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 6cf:	8b 38                	mov    (%eax),%edi
        ap++;
 6d1:	83 c0 04             	add    $0x4,%eax
 6d4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 6d7:	85 ff                	test   %edi,%edi
 6d9:	74 5c                	je     737 <printf+0x163>
          s = "(null)";
        while(*s != 0){
 6db:	8a 07                	mov    (%edi),%al
 6dd:	84 c0                	test   %al,%al
 6df:	74 1d                	je     6fe <printf+0x12a>
 6e1:	8d 76 00             	lea    0x0(%esi),%esi
 6e4:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6e7:	50                   	push   %eax
 6e8:	6a 01                	push   $0x1
 6ea:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 6ed:	50                   	push   %eax
 6ee:	56                   	push   %esi
 6ef:	e8 df fd ff ff       	call   4d3 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 6f4:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6f5:	8a 07                	mov    (%edi),%al
 6f7:	83 c4 10             	add    $0x10,%esp
 6fa:	84 c0                	test   %al,%al
 6fc:	75 e6                	jne    6e4 <printf+0x110>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6fe:	31 ff                	xor    %edi,%edi
 700:	e9 0f ff ff ff       	jmp    614 <printf+0x40>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 705:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 708:	8b 07                	mov    (%edi),%eax
 70a:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 70d:	51                   	push   %ecx
 70e:	6a 01                	push   $0x1
 710:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 713:	50                   	push   %eax
 714:	56                   	push   %esi
 715:	e8 b9 fd ff ff       	call   4d3 <write>
 71a:	eb 9e                	jmp    6ba <printf+0xe6>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 71c:	83 ec 0c             	sub    $0xc,%esp
 71f:	6a 01                	push   $0x1
 721:	b9 0a 00 00 00       	mov    $0xa,%ecx
 726:	eb 86                	jmp    6ae <printf+0xda>
 728:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 72c:	52                   	push   %edx
 72d:	6a 01                	push   $0x1
 72f:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 732:	e9 44 ff ff ff       	jmp    67b <printf+0xa7>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 737:	bf ee 08 00 00       	mov    $0x8ee,%edi
 73c:	eb 9d                	jmp    6db <printf+0x107>
 73e:	66 90                	xchg   %ax,%ax

00000740 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	57                   	push   %edi
 744:	56                   	push   %esi
 745:	53                   	push   %ebx
 746:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 749:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 74c:	a1 10 0c 00 00       	mov    0xc10,%eax
 751:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 754:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 756:	39 c8                	cmp    %ecx,%eax
 758:	73 2e                	jae    788 <free+0x48>
 75a:	39 d1                	cmp    %edx,%ecx
 75c:	72 04                	jb     762 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 75e:	39 d0                	cmp    %edx,%eax
 760:	72 2e                	jb     790 <free+0x50>
      break;
  if(bp + bp->s.size == p->s.ptr){
 762:	8b 73 fc             	mov    -0x4(%ebx),%esi
 765:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 768:	39 d7                	cmp    %edx,%edi
 76a:	74 28                	je     794 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 76c:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 76f:	8b 50 04             	mov    0x4(%eax),%edx
 772:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 775:	39 f1                	cmp    %esi,%ecx
 777:	74 32                	je     7ab <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 779:	89 08                	mov    %ecx,(%eax)
  freep = p;
 77b:	a3 10 0c 00 00       	mov    %eax,0xc10
}
 780:	5b                   	pop    %ebx
 781:	5e                   	pop    %esi
 782:	5f                   	pop    %edi
 783:	5d                   	pop    %ebp
 784:	c3                   	ret    
 785:	8d 76 00             	lea    0x0(%esi),%esi
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 788:	39 d0                	cmp    %edx,%eax
 78a:	72 04                	jb     790 <free+0x50>
 78c:	39 d1                	cmp    %edx,%ecx
 78e:	72 d2                	jb     762 <free+0x22>
static Header base;
static Header *freep;

void
free(void *ap)
{
 790:	89 d0                	mov    %edx,%eax
 792:	eb c0                	jmp    754 <free+0x14>
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 794:	03 72 04             	add    0x4(%edx),%esi
 797:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 79a:	8b 10                	mov    (%eax),%edx
 79c:	8b 12                	mov    (%edx),%edx
 79e:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7a1:	8b 50 04             	mov    0x4(%eax),%edx
 7a4:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7a7:	39 f1                	cmp    %esi,%ecx
 7a9:	75 ce                	jne    779 <free+0x39>
    p->s.size += bp->s.size;
 7ab:	03 53 fc             	add    -0x4(%ebx),%edx
 7ae:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7b1:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7b4:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 7b6:	a3 10 0c 00 00       	mov    %eax,0xc10
}
 7bb:	5b                   	pop    %ebx
 7bc:	5e                   	pop    %esi
 7bd:	5f                   	pop    %edi
 7be:	5d                   	pop    %ebp
 7bf:	c3                   	ret    

000007c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7c0:	55                   	push   %ebp
 7c1:	89 e5                	mov    %esp,%ebp
 7c3:	57                   	push   %edi
 7c4:	56                   	push   %esi
 7c5:	53                   	push   %ebx
 7c6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c9:	8b 45 08             	mov    0x8(%ebp),%eax
 7cc:	8d 70 07             	lea    0x7(%eax),%esi
 7cf:	c1 ee 03             	shr    $0x3,%esi
 7d2:	46                   	inc    %esi
  if((prevp = freep) == 0){
 7d3:	8b 15 10 0c 00 00    	mov    0xc10,%edx
 7d9:	85 d2                	test   %edx,%edx
 7db:	0f 84 99 00 00 00    	je     87a <malloc+0xba>
 7e1:	8b 02                	mov    (%edx),%eax
 7e3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7e6:	39 ce                	cmp    %ecx,%esi
 7e8:	76 62                	jbe    84c <malloc+0x8c>
 7ea:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 7f1:	eb 0a                	jmp    7fd <malloc+0x3d>
 7f3:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7f4:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7f6:	8b 48 04             	mov    0x4(%eax),%ecx
 7f9:	39 ce                	cmp    %ecx,%esi
 7fb:	76 4f                	jbe    84c <malloc+0x8c>
 7fd:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7ff:	3b 05 10 0c 00 00    	cmp    0xc10,%eax
 805:	75 ed                	jne    7f4 <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 807:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 80d:	77 5d                	ja     86c <malloc+0xac>
 80f:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 814:	bf 00 10 00 00       	mov    $0x1000,%edi
  p = sbrk(nu * sizeof(Header));
 819:	83 ec 0c             	sub    $0xc,%esp
 81c:	50                   	push   %eax
 81d:	e8 19 fd ff ff       	call   53b <sbrk>
  if(p == (char*)-1)
 822:	83 c4 10             	add    $0x10,%esp
 825:	83 f8 ff             	cmp    $0xffffffff,%eax
 828:	74 1c                	je     846 <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 82a:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 82d:	83 ec 0c             	sub    $0xc,%esp
 830:	83 c0 08             	add    $0x8,%eax
 833:	50                   	push   %eax
 834:	e8 07 ff ff ff       	call   740 <free>
  return freep;
 839:	8b 15 10 0c 00 00    	mov    0xc10,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 83f:	83 c4 10             	add    $0x10,%esp
 842:	85 d2                	test   %edx,%edx
 844:	75 ae                	jne    7f4 <malloc+0x34>
        return 0;
 846:	31 c0                	xor    %eax,%eax
 848:	eb 1a                	jmp    864 <malloc+0xa4>
 84a:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 84c:	39 ce                	cmp    %ecx,%esi
 84e:	74 24                	je     874 <malloc+0xb4>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 850:	29 f1                	sub    %esi,%ecx
 852:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 855:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 858:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
 85b:	89 15 10 0c 00 00    	mov    %edx,0xc10
      return (void*)(p + 1);
 861:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 864:	8d 65 f4             	lea    -0xc(%ebp),%esp
 867:	5b                   	pop    %ebx
 868:	5e                   	pop    %esi
 869:	5f                   	pop    %edi
 86a:	5d                   	pop    %ebp
 86b:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 86c:	89 d8                	mov    %ebx,%eax
 86e:	89 f7                	mov    %esi,%edi
 870:	eb a7                	jmp    819 <malloc+0x59>
 872:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 874:	8b 08                	mov    (%eax),%ecx
 876:	89 0a                	mov    %ecx,(%edx)
 878:	eb e1                	jmp    85b <malloc+0x9b>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 87a:	c7 05 10 0c 00 00 14 	movl   $0xc14,0xc10
 881:	0c 00 00 
 884:	c7 05 14 0c 00 00 14 	movl   $0xc14,0xc14
 88b:	0c 00 00 
    base.s.size = 0;
 88e:	c7 05 18 0c 00 00 00 	movl   $0x0,0xc18
 895:	00 00 00 
 898:	b8 14 0c 00 00       	mov    $0xc14,%eax
 89d:	e9 48 ff ff ff       	jmp    7ea <malloc+0x2a>
