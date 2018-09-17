
_mike:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"
#include "fcntl.h"
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
  11:	81 ec 18 02 00 00    	sub    $0x218,%esp
  17:	8b 01                	mov    (%ecx),%eax
  19:	89 c2                	mov    %eax,%edx
  1b:	89 85 e0 fd ff ff    	mov    %eax,-0x220(%ebp)
  21:	8b 41 04             	mov    0x4(%ecx),%eax
  24:	89 85 e4 fd ff ff    	mov    %eax,-0x21c(%ebp)
  int i;
    int fp;
    char buf[512] = "Hey this buf for mike.txt\n";
  2a:	8d 9d e8 fd ff ff    	lea    -0x218(%ebp),%ebx
  30:	be 92 06 00 00       	mov    $0x692,%esi
  35:	b9 1b 00 00 00       	mov    $0x1b,%ecx
  3a:	89 df                	mov    %ebx,%edi
  3c:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  3e:	8d bd 03 fe ff ff    	lea    -0x1fd(%ebp),%edi
  44:	66 b9 e5 01          	mov    $0x1e5,%cx
  48:	31 c0                	xor    %eax,%eax
  4a:	f3 aa                	rep stos %al,%es:(%edi)
  for(i = 1; i < argc; i++)
  4c:	89 d0                	mov    %edx,%eax
  4e:	48                   	dec    %eax
  4f:	7e 4c                	jle    9d <main+0x9d>
  51:	be 01 00 00 00       	mov    $0x1,%esi
  56:	eb 1e                	jmp    76 <main+0x76>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  58:	68 89 06 00 00       	push   $0x689
  5d:	8b 85 e4 fd ff ff    	mov    -0x21c(%ebp),%eax
  63:	ff 74 b0 fc          	pushl  -0x4(%eax,%esi,4)
  67:	68 8b 06 00 00       	push   $0x68b
  6c:	6a 01                	push   $0x1
  6e:	e8 3d 03 00 00       	call   3b0 <printf>
  73:	83 c4 10             	add    $0x10,%esp
  76:	46                   	inc    %esi
  77:	3b b5 e0 fd ff ff    	cmp    -0x220(%ebp),%esi
  7d:	75 d9                	jne    58 <main+0x58>
  7f:	68 90 06 00 00       	push   $0x690
  84:	8b 85 e4 fd ff ff    	mov    -0x21c(%ebp),%eax
  8a:	ff 74 b0 fc          	pushl  -0x4(%eax,%esi,4)
  8e:	68 8b 06 00 00       	push   $0x68b
  93:	6a 01                	push   $0x1
  95:	e8 16 03 00 00       	call   3b0 <printf>
  9a:	83 c4 10             	add    $0x10,%esp

  mike();
  9d:	e8 8d 02 00 00       	call   32f <mike>
    fp = open("mike.txt",O_CREATE | O_RDWR);
  a2:	83 ec 08             	sub    $0x8,%esp
  a5:	68 02 02 00 00       	push   $0x202
  aa:	68 80 06 00 00       	push   $0x680
  af:	e8 1b 02 00 00       	call   2cf <open>
  b4:	89 c7                	mov    %eax,%edi
  b6:	83 c4 10             	add    $0x10,%esp
  b9:	be 64 00 00 00       	mov    $0x64,%esi
  be:	66 90                	xchg   %ax,%ax
    for(i = 0 ;i < 100; i++){
       write(fp,buf,512);
  c0:	50                   	push   %eax
  c1:	68 00 02 00 00       	push   $0x200
  c6:	53                   	push   %ebx
  c7:	57                   	push   %edi
  c8:	e8 e2 01 00 00       	call   2af <write>
  for(i = 1; i < argc; i++)
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");

  mike();
    fp = open("mike.txt",O_CREATE | O_RDWR);
    for(i = 0 ;i < 100; i++){
  cd:	83 c4 10             	add    $0x10,%esp
  d0:	4e                   	dec    %esi
  d1:	75 ed                	jne    c0 <main+0xc0>
       write(fp,buf,512);
    }
    close(fp);
  d3:	83 ec 0c             	sub    $0xc,%esp
  d6:	57                   	push   %edi
  d7:	e8 db 01 00 00       	call   2b7 <close>
  exit();
  dc:	e8 ae 01 00 00       	call   28f <exit>
  e1:	66 90                	xchg   %ax,%ax
  e3:	90                   	nop

000000e4 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  e4:	55                   	push   %ebp
  e5:	89 e5                	mov    %esp,%ebp
  e7:	53                   	push   %ebx
  e8:	8b 45 08             	mov    0x8(%ebp),%eax
  eb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  ee:	89 c2                	mov    %eax,%edx
  f0:	42                   	inc    %edx
  f1:	41                   	inc    %ecx
  f2:	8a 59 ff             	mov    -0x1(%ecx),%bl
  f5:	88 5a ff             	mov    %bl,-0x1(%edx)
  f8:	84 db                	test   %bl,%bl
  fa:	75 f4                	jne    f0 <strcpy+0xc>
    ;
  return os;
}
  fc:	5b                   	pop    %ebx
  fd:	5d                   	pop    %ebp
  fe:	c3                   	ret    
  ff:	90                   	nop

00000100 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	56                   	push   %esi
 104:	53                   	push   %ebx
 105:	8b 55 08             	mov    0x8(%ebp),%edx
 108:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 10b:	0f b6 02             	movzbl (%edx),%eax
 10e:	0f b6 0b             	movzbl (%ebx),%ecx
 111:	84 c0                	test   %al,%al
 113:	75 14                	jne    129 <strcmp+0x29>
 115:	eb 1d                	jmp    134 <strcmp+0x34>
 117:	90                   	nop
    p++, q++;
 118:	42                   	inc    %edx
 119:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 11c:	0f b6 02             	movzbl (%edx),%eax
 11f:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 123:	84 c0                	test   %al,%al
 125:	74 0d                	je     134 <strcmp+0x34>
 127:	89 f3                	mov    %esi,%ebx
 129:	38 c8                	cmp    %cl,%al
 12b:	74 eb                	je     118 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 12d:	29 c8                	sub    %ecx,%eax
}
 12f:	5b                   	pop    %ebx
 130:	5e                   	pop    %esi
 131:	5d                   	pop    %ebp
 132:	c3                   	ret    
 133:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 134:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 136:	29 c8                	sub    %ecx,%eax
}
 138:	5b                   	pop    %ebx
 139:	5e                   	pop    %esi
 13a:	5d                   	pop    %ebp
 13b:	c3                   	ret    

0000013c <strlen>:

uint
strlen(char *s)
{
 13c:	55                   	push   %ebp
 13d:	89 e5                	mov    %esp,%ebp
 13f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 142:	80 39 00             	cmpb   $0x0,(%ecx)
 145:	74 10                	je     157 <strlen+0x1b>
 147:	31 d2                	xor    %edx,%edx
 149:	8d 76 00             	lea    0x0(%esi),%esi
 14c:	42                   	inc    %edx
 14d:	89 d0                	mov    %edx,%eax
 14f:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 153:	75 f7                	jne    14c <strlen+0x10>
    ;
  return n;
}
 155:	5d                   	pop    %ebp
 156:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 157:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 159:	5d                   	pop    %ebp
 15a:	c3                   	ret    
 15b:	90                   	nop

0000015c <memset>:

void*
memset(void *dst, int c, uint n)
{
 15c:	55                   	push   %ebp
 15d:	89 e5                	mov    %esp,%ebp
 15f:	57                   	push   %edi
 160:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 163:	89 d7                	mov    %edx,%edi
 165:	8b 4d 10             	mov    0x10(%ebp),%ecx
 168:	8b 45 0c             	mov    0xc(%ebp),%eax
 16b:	fc                   	cld    
 16c:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 16e:	89 d0                	mov    %edx,%eax
 170:	5f                   	pop    %edi
 171:	5d                   	pop    %ebp
 172:	c3                   	ret    
 173:	90                   	nop

00000174 <strchr>:

char*
strchr(const char *s, char c)
{
 174:	55                   	push   %ebp
 175:	89 e5                	mov    %esp,%ebp
 177:	53                   	push   %ebx
 178:	8b 45 08             	mov    0x8(%ebp),%eax
 17b:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 17e:	8a 18                	mov    (%eax),%bl
 180:	84 db                	test   %bl,%bl
 182:	74 13                	je     197 <strchr+0x23>
 184:	88 d1                	mov    %dl,%cl
    if(*s == c)
 186:	38 d3                	cmp    %dl,%bl
 188:	75 06                	jne    190 <strchr+0x1c>
 18a:	eb 0d                	jmp    199 <strchr+0x25>
 18c:	38 ca                	cmp    %cl,%dl
 18e:	74 09                	je     199 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 190:	40                   	inc    %eax
 191:	8a 10                	mov    (%eax),%dl
 193:	84 d2                	test   %dl,%dl
 195:	75 f5                	jne    18c <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 197:	31 c0                	xor    %eax,%eax
}
 199:	5b                   	pop    %ebx
 19a:	5d                   	pop    %ebp
 19b:	c3                   	ret    

0000019c <gets>:

char*
gets(char *buf, int max)
{
 19c:	55                   	push   %ebp
 19d:	89 e5                	mov    %esp,%ebp
 19f:	57                   	push   %edi
 1a0:	56                   	push   %esi
 1a1:	53                   	push   %ebx
 1a2:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a5:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 1a7:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1aa:	eb 26                	jmp    1d2 <gets+0x36>
    cc = read(0, &c, 1);
 1ac:	50                   	push   %eax
 1ad:	6a 01                	push   $0x1
 1af:	57                   	push   %edi
 1b0:	6a 00                	push   $0x0
 1b2:	e8 f0 00 00 00       	call   2a7 <read>
    if(cc < 1)
 1b7:	83 c4 10             	add    $0x10,%esp
 1ba:	85 c0                	test   %eax,%eax
 1bc:	7e 1c                	jle    1da <gets+0x3e>
      break;
    buf[i++] = c;
 1be:	8a 45 e7             	mov    -0x19(%ebp),%al
 1c1:	8b 55 08             	mov    0x8(%ebp),%edx
 1c4:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
 1c8:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 1ca:	3c 0a                	cmp    $0xa,%al
 1cc:	74 0c                	je     1da <gets+0x3e>
 1ce:	3c 0d                	cmp    $0xd,%al
 1d0:	74 08                	je     1da <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d2:	8d 5e 01             	lea    0x1(%esi),%ebx
 1d5:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1d8:	7c d2                	jl     1ac <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1da:	8b 45 08             	mov    0x8(%ebp),%eax
 1dd:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1e4:	5b                   	pop    %ebx
 1e5:	5e                   	pop    %esi
 1e6:	5f                   	pop    %edi
 1e7:	5d                   	pop    %ebp
 1e8:	c3                   	ret    
 1e9:	8d 76 00             	lea    0x0(%esi),%esi

000001ec <stat>:

int
stat(char *n, struct stat *st)
{
 1ec:	55                   	push   %ebp
 1ed:	89 e5                	mov    %esp,%ebp
 1ef:	56                   	push   %esi
 1f0:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f1:	83 ec 08             	sub    $0x8,%esp
 1f4:	6a 00                	push   $0x0
 1f6:	ff 75 08             	pushl  0x8(%ebp)
 1f9:	e8 d1 00 00 00       	call   2cf <open>
 1fe:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 200:	83 c4 10             	add    $0x10,%esp
 203:	85 c0                	test   %eax,%eax
 205:	78 25                	js     22c <stat+0x40>
    return -1;
  r = fstat(fd, st);
 207:	83 ec 08             	sub    $0x8,%esp
 20a:	ff 75 0c             	pushl  0xc(%ebp)
 20d:	50                   	push   %eax
 20e:	e8 d4 00 00 00       	call   2e7 <fstat>
 213:	89 c6                	mov    %eax,%esi
  close(fd);
 215:	89 1c 24             	mov    %ebx,(%esp)
 218:	e8 9a 00 00 00       	call   2b7 <close>
  return r;
 21d:	83 c4 10             	add    $0x10,%esp
 220:	89 f0                	mov    %esi,%eax
}
 222:	8d 65 f8             	lea    -0x8(%ebp),%esp
 225:	5b                   	pop    %ebx
 226:	5e                   	pop    %esi
 227:	5d                   	pop    %ebp
 228:	c3                   	ret    
 229:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 22c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 231:	eb ef                	jmp    222 <stat+0x36>
 233:	90                   	nop

00000234 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 234:	55                   	push   %ebp
 235:	89 e5                	mov    %esp,%ebp
 237:	53                   	push   %ebx
 238:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 23b:	0f be 11             	movsbl (%ecx),%edx
 23e:	8d 42 d0             	lea    -0x30(%edx),%eax
 241:	3c 09                	cmp    $0x9,%al
 243:	b8 00 00 00 00       	mov    $0x0,%eax
 248:	77 15                	ja     25f <atoi+0x2b>
 24a:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 24c:	41                   	inc    %ecx
 24d:	8d 04 80             	lea    (%eax,%eax,4),%eax
 250:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 254:	0f be 11             	movsbl (%ecx),%edx
 257:	8d 5a d0             	lea    -0x30(%edx),%ebx
 25a:	80 fb 09             	cmp    $0x9,%bl
 25d:	76 ed                	jbe    24c <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 25f:	5b                   	pop    %ebx
 260:	5d                   	pop    %ebp
 261:	c3                   	ret    
 262:	66 90                	xchg   %ax,%ax

00000264 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 264:	55                   	push   %ebp
 265:	89 e5                	mov    %esp,%ebp
 267:	56                   	push   %esi
 268:	53                   	push   %ebx
 269:	8b 45 08             	mov    0x8(%ebp),%eax
 26c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 26f:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 272:	31 d2                	xor    %edx,%edx
 274:	85 f6                	test   %esi,%esi
 276:	7e 0b                	jle    283 <memmove+0x1f>
    *dst++ = *src++;
 278:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 27b:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 27e:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 27f:	39 f2                	cmp    %esi,%edx
 281:	75 f5                	jne    278 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 283:	5b                   	pop    %ebx
 284:	5e                   	pop    %esi
 285:	5d                   	pop    %ebp
 286:	c3                   	ret    

00000287 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 287:	b8 01 00 00 00       	mov    $0x1,%eax
 28c:	cd 40                	int    $0x40
 28e:	c3                   	ret    

0000028f <exit>:
SYSCALL(exit)
 28f:	b8 02 00 00 00       	mov    $0x2,%eax
 294:	cd 40                	int    $0x40
 296:	c3                   	ret    

00000297 <wait>:
SYSCALL(wait)
 297:	b8 03 00 00 00       	mov    $0x3,%eax
 29c:	cd 40                	int    $0x40
 29e:	c3                   	ret    

0000029f <pipe>:
SYSCALL(pipe)
 29f:	b8 04 00 00 00       	mov    $0x4,%eax
 2a4:	cd 40                	int    $0x40
 2a6:	c3                   	ret    

000002a7 <read>:
SYSCALL(read)
 2a7:	b8 05 00 00 00       	mov    $0x5,%eax
 2ac:	cd 40                	int    $0x40
 2ae:	c3                   	ret    

000002af <write>:
SYSCALL(write)
 2af:	b8 10 00 00 00       	mov    $0x10,%eax
 2b4:	cd 40                	int    $0x40
 2b6:	c3                   	ret    

000002b7 <close>:
SYSCALL(close)
 2b7:	b8 15 00 00 00       	mov    $0x15,%eax
 2bc:	cd 40                	int    $0x40
 2be:	c3                   	ret    

000002bf <kill>:
SYSCALL(kill)
 2bf:	b8 06 00 00 00       	mov    $0x6,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret    

000002c7 <exec>:
SYSCALL(exec)
 2c7:	b8 07 00 00 00       	mov    $0x7,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <open>:
SYSCALL(open)
 2cf:	b8 0f 00 00 00       	mov    $0xf,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    

000002d7 <mknod>:
SYSCALL(mknod)
 2d7:	b8 11 00 00 00       	mov    $0x11,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret    

000002df <unlink>:
SYSCALL(unlink)
 2df:	b8 12 00 00 00       	mov    $0x12,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <fstat>:
SYSCALL(fstat)
 2e7:	b8 08 00 00 00       	mov    $0x8,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    

000002ef <link>:
SYSCALL(link)
 2ef:	b8 13 00 00 00       	mov    $0x13,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <mkdir>:
SYSCALL(mkdir)
 2f7:	b8 14 00 00 00       	mov    $0x14,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <chdir>:
SYSCALL(chdir)
 2ff:	b8 09 00 00 00       	mov    $0x9,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <dup>:
SYSCALL(dup)
 307:	b8 0a 00 00 00       	mov    $0xa,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <getpid>:
SYSCALL(getpid)
 30f:	b8 0b 00 00 00       	mov    $0xb,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <sbrk>:
SYSCALL(sbrk)
 317:	b8 0c 00 00 00       	mov    $0xc,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <sleep>:
SYSCALL(sleep)
 31f:	b8 0d 00 00 00       	mov    $0xd,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <uptime>:
SYSCALL(uptime)
 327:	b8 0e 00 00 00       	mov    $0xe,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <mike>:
SYSCALL(mike)
 32f:	b8 16 00 00 00       	mov    $0x16,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    
 337:	90                   	nop

00000338 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 338:	55                   	push   %ebp
 339:	89 e5                	mov    %esp,%ebp
 33b:	57                   	push   %edi
 33c:	56                   	push   %esi
 33d:	53                   	push   %ebx
 33e:	83 ec 3c             	sub    $0x3c,%esp
 341:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 343:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 345:	8b 5d 08             	mov    0x8(%ebp),%ebx
 348:	85 db                	test   %ebx,%ebx
 34a:	74 04                	je     350 <printint+0x18>
 34c:	85 d2                	test   %edx,%edx
 34e:	78 53                	js     3a3 <printint+0x6b>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 350:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 357:	31 db                	xor    %ebx,%ebx
 359:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 35c:	43                   	inc    %ebx
 35d:	31 d2                	xor    %edx,%edx
 35f:	f7 f1                	div    %ecx
 361:	8a 92 9c 08 00 00    	mov    0x89c(%edx),%dl
 367:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 36a:	85 c0                	test   %eax,%eax
 36c:	75 ee                	jne    35c <printint+0x24>
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 36e:	89 d8                	mov    %ebx,%eax
  }while((x /= base) != 0);
  if(neg)
 370:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 373:	85 d2                	test   %edx,%edx
 375:	74 06                	je     37d <printint+0x45>
    buf[i++] = '-';
 377:	43                   	inc    %ebx
 378:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 37d:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 381:	8d 76 00             	lea    0x0(%esi),%esi
 384:	8a 03                	mov    (%ebx),%al
 386:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 389:	50                   	push   %eax
 38a:	6a 01                	push   $0x1
 38c:	56                   	push   %esi
 38d:	57                   	push   %edi
 38e:	e8 1c ff ff ff       	call   2af <write>
 393:	4b                   	dec    %ebx
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 394:	83 c4 10             	add    $0x10,%esp
 397:	39 f3                	cmp    %esi,%ebx
 399:	75 e9                	jne    384 <printint+0x4c>
    putc(fd, buf[i]);
}
 39b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 39e:	5b                   	pop    %ebx
 39f:	5e                   	pop    %esi
 3a0:	5f                   	pop    %edi
 3a1:	5d                   	pop    %ebp
 3a2:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3a3:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 3a5:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 3ac:	eb a9                	jmp    357 <printint+0x1f>
 3ae:	66 90                	xchg   %ax,%ax

000003b0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	57                   	push   %edi
 3b4:	56                   	push   %esi
 3b5:	53                   	push   %ebx
 3b6:	83 ec 2c             	sub    $0x2c,%esp
 3b9:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3bc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 3bf:	8a 13                	mov    (%ebx),%dl
 3c1:	84 d2                	test   %dl,%dl
 3c3:	0f 84 a3 00 00 00    	je     46c <printf+0xbc>
 3c9:	43                   	inc    %ebx
 3ca:	8d 45 10             	lea    0x10(%ebp),%eax
 3cd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 3d0:	31 ff                	xor    %edi,%edi
 3d2:	eb 24                	jmp    3f8 <printf+0x48>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3d4:	83 fa 25             	cmp    $0x25,%edx
 3d7:	0f 84 97 00 00 00    	je     474 <printf+0xc4>
        state = '%';
      } else {
        putc(fd, c);
 3dd:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3e0:	50                   	push   %eax
 3e1:	6a 01                	push   $0x1
 3e3:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 3e6:	50                   	push   %eax
 3e7:	56                   	push   %esi
 3e8:	e8 c2 fe ff ff       	call   2af <write>
 3ed:	83 c4 10             	add    $0x10,%esp
 3f0:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3f1:	8a 53 ff             	mov    -0x1(%ebx),%dl
 3f4:	84 d2                	test   %dl,%dl
 3f6:	74 74                	je     46c <printf+0xbc>
    c = fmt[i] & 0xff;
 3f8:	0f be c2             	movsbl %dl,%eax
 3fb:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
 3fe:	85 ff                	test   %edi,%edi
 400:	74 d2                	je     3d4 <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 402:	83 ff 25             	cmp    $0x25,%edi
 405:	75 e9                	jne    3f0 <printf+0x40>
      if(c == 'd'){
 407:	83 fa 64             	cmp    $0x64,%edx
 40a:	0f 84 e8 00 00 00    	je     4f8 <printf+0x148>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 410:	25 f7 00 00 00       	and    $0xf7,%eax
 415:	83 f8 70             	cmp    $0x70,%eax
 418:	74 66                	je     480 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 41a:	83 fa 73             	cmp    $0x73,%edx
 41d:	0f 84 85 00 00 00    	je     4a8 <printf+0xf8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 423:	83 fa 63             	cmp    $0x63,%edx
 426:	0f 84 b5 00 00 00    	je     4e1 <printf+0x131>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 42c:	83 fa 25             	cmp    $0x25,%edx
 42f:	0f 84 cf 00 00 00    	je     504 <printf+0x154>
 435:	89 55 d0             	mov    %edx,-0x30(%ebp)
 438:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 43c:	50                   	push   %eax
 43d:	6a 01                	push   $0x1
 43f:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 442:	50                   	push   %eax
 443:	56                   	push   %esi
 444:	e8 66 fe ff ff       	call   2af <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 449:	8b 55 d0             	mov    -0x30(%ebp),%edx
 44c:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 44f:	83 c4 0c             	add    $0xc,%esp
 452:	6a 01                	push   $0x1
 454:	8d 45 e7             	lea    -0x19(%ebp),%eax
 457:	50                   	push   %eax
 458:	56                   	push   %esi
 459:	e8 51 fe ff ff       	call   2af <write>
 45e:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 461:	31 ff                	xor    %edi,%edi
 463:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 464:	8a 53 ff             	mov    -0x1(%ebx),%dl
 467:	84 d2                	test   %dl,%dl
 469:	75 8d                	jne    3f8 <printf+0x48>
 46b:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 46c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 46f:	5b                   	pop    %ebx
 470:	5e                   	pop    %esi
 471:	5f                   	pop    %edi
 472:	5d                   	pop    %ebp
 473:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 474:	bf 25 00 00 00       	mov    $0x25,%edi
 479:	e9 72 ff ff ff       	jmp    3f0 <printf+0x40>
 47e:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 480:	83 ec 0c             	sub    $0xc,%esp
 483:	6a 00                	push   $0x0
 485:	b9 10 00 00 00       	mov    $0x10,%ecx
 48a:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 48d:	8b 17                	mov    (%edi),%edx
 48f:	89 f0                	mov    %esi,%eax
 491:	e8 a2 fe ff ff       	call   338 <printint>
        ap++;
 496:	89 f8                	mov    %edi,%eax
 498:	83 c0 04             	add    $0x4,%eax
 49b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 49e:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4a1:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 4a3:	e9 48 ff ff ff       	jmp    3f0 <printf+0x40>
      } else if(c == 's'){
        s = (char*)*ap;
 4a8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4ab:	8b 38                	mov    (%eax),%edi
        ap++;
 4ad:	83 c0 04             	add    $0x4,%eax
 4b0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 4b3:	85 ff                	test   %edi,%edi
 4b5:	74 5c                	je     513 <printf+0x163>
          s = "(null)";
        while(*s != 0){
 4b7:	8a 07                	mov    (%edi),%al
 4b9:	84 c0                	test   %al,%al
 4bb:	74 1d                	je     4da <printf+0x12a>
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
 4c0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4c3:	50                   	push   %eax
 4c4:	6a 01                	push   $0x1
 4c6:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 4c9:	50                   	push   %eax
 4ca:	56                   	push   %esi
 4cb:	e8 df fd ff ff       	call   2af <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 4d0:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4d1:	8a 07                	mov    (%edi),%al
 4d3:	83 c4 10             	add    $0x10,%esp
 4d6:	84 c0                	test   %al,%al
 4d8:	75 e6                	jne    4c0 <printf+0x110>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4da:	31 ff                	xor    %edi,%edi
 4dc:	e9 0f ff ff ff       	jmp    3f0 <printf+0x40>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 4e1:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4e4:	8b 07                	mov    (%edi),%eax
 4e6:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4e9:	51                   	push   %ecx
 4ea:	6a 01                	push   $0x1
 4ec:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 4ef:	50                   	push   %eax
 4f0:	56                   	push   %esi
 4f1:	e8 b9 fd ff ff       	call   2af <write>
 4f6:	eb 9e                	jmp    496 <printf+0xe6>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 4f8:	83 ec 0c             	sub    $0xc,%esp
 4fb:	6a 01                	push   $0x1
 4fd:	b9 0a 00 00 00       	mov    $0xa,%ecx
 502:	eb 86                	jmp    48a <printf+0xda>
 504:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 508:	52                   	push   %edx
 509:	6a 01                	push   $0x1
 50b:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 50e:	e9 44 ff ff ff       	jmp    457 <printf+0xa7>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 513:	bf 92 08 00 00       	mov    $0x892,%edi
 518:	eb 9d                	jmp    4b7 <printf+0x107>
 51a:	66 90                	xchg   %ax,%ax

0000051c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 51c:	55                   	push   %ebp
 51d:	89 e5                	mov    %esp,%ebp
 51f:	57                   	push   %edi
 520:	56                   	push   %esi
 521:	53                   	push   %ebx
 522:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 525:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 528:	a1 30 0b 00 00       	mov    0xb30,%eax
 52d:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 530:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 532:	39 c8                	cmp    %ecx,%eax
 534:	73 2e                	jae    564 <free+0x48>
 536:	39 d1                	cmp    %edx,%ecx
 538:	72 04                	jb     53e <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 53a:	39 d0                	cmp    %edx,%eax
 53c:	72 2e                	jb     56c <free+0x50>
      break;
  if(bp + bp->s.size == p->s.ptr){
 53e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 541:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 544:	39 d7                	cmp    %edx,%edi
 546:	74 28                	je     570 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 548:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 54b:	8b 50 04             	mov    0x4(%eax),%edx
 54e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 551:	39 f1                	cmp    %esi,%ecx
 553:	74 32                	je     587 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 555:	89 08                	mov    %ecx,(%eax)
  freep = p;
 557:	a3 30 0b 00 00       	mov    %eax,0xb30
}
 55c:	5b                   	pop    %ebx
 55d:	5e                   	pop    %esi
 55e:	5f                   	pop    %edi
 55f:	5d                   	pop    %ebp
 560:	c3                   	ret    
 561:	8d 76 00             	lea    0x0(%esi),%esi
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 564:	39 d0                	cmp    %edx,%eax
 566:	72 04                	jb     56c <free+0x50>
 568:	39 d1                	cmp    %edx,%ecx
 56a:	72 d2                	jb     53e <free+0x22>
static Header base;
static Header *freep;

void
free(void *ap)
{
 56c:	89 d0                	mov    %edx,%eax
 56e:	eb c0                	jmp    530 <free+0x14>
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 570:	03 72 04             	add    0x4(%edx),%esi
 573:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 576:	8b 10                	mov    (%eax),%edx
 578:	8b 12                	mov    (%edx),%edx
 57a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 57d:	8b 50 04             	mov    0x4(%eax),%edx
 580:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 583:	39 f1                	cmp    %esi,%ecx
 585:	75 ce                	jne    555 <free+0x39>
    p->s.size += bp->s.size;
 587:	03 53 fc             	add    -0x4(%ebx),%edx
 58a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 58d:	8b 53 f8             	mov    -0x8(%ebx),%edx
 590:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 592:	a3 30 0b 00 00       	mov    %eax,0xb30
}
 597:	5b                   	pop    %ebx
 598:	5e                   	pop    %esi
 599:	5f                   	pop    %edi
 59a:	5d                   	pop    %ebp
 59b:	c3                   	ret    

0000059c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 59c:	55                   	push   %ebp
 59d:	89 e5                	mov    %esp,%ebp
 59f:	57                   	push   %edi
 5a0:	56                   	push   %esi
 5a1:	53                   	push   %ebx
 5a2:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5a5:	8b 45 08             	mov    0x8(%ebp),%eax
 5a8:	8d 70 07             	lea    0x7(%eax),%esi
 5ab:	c1 ee 03             	shr    $0x3,%esi
 5ae:	46                   	inc    %esi
  if((prevp = freep) == 0){
 5af:	8b 15 30 0b 00 00    	mov    0xb30,%edx
 5b5:	85 d2                	test   %edx,%edx
 5b7:	0f 84 99 00 00 00    	je     656 <malloc+0xba>
 5bd:	8b 02                	mov    (%edx),%eax
 5bf:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 5c2:	39 ce                	cmp    %ecx,%esi
 5c4:	76 62                	jbe    628 <malloc+0x8c>
 5c6:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 5cd:	eb 0a                	jmp    5d9 <malloc+0x3d>
 5cf:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5d0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 5d2:	8b 48 04             	mov    0x4(%eax),%ecx
 5d5:	39 ce                	cmp    %ecx,%esi
 5d7:	76 4f                	jbe    628 <malloc+0x8c>
 5d9:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 5db:	3b 05 30 0b 00 00    	cmp    0xb30,%eax
 5e1:	75 ed                	jne    5d0 <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 5e3:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 5e9:	77 5d                	ja     648 <malloc+0xac>
 5eb:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 5f0:	bf 00 10 00 00       	mov    $0x1000,%edi
  p = sbrk(nu * sizeof(Header));
 5f5:	83 ec 0c             	sub    $0xc,%esp
 5f8:	50                   	push   %eax
 5f9:	e8 19 fd ff ff       	call   317 <sbrk>
  if(p == (char*)-1)
 5fe:	83 c4 10             	add    $0x10,%esp
 601:	83 f8 ff             	cmp    $0xffffffff,%eax
 604:	74 1c                	je     622 <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 606:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 609:	83 ec 0c             	sub    $0xc,%esp
 60c:	83 c0 08             	add    $0x8,%eax
 60f:	50                   	push   %eax
 610:	e8 07 ff ff ff       	call   51c <free>
  return freep;
 615:	8b 15 30 0b 00 00    	mov    0xb30,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 61b:	83 c4 10             	add    $0x10,%esp
 61e:	85 d2                	test   %edx,%edx
 620:	75 ae                	jne    5d0 <malloc+0x34>
        return 0;
 622:	31 c0                	xor    %eax,%eax
 624:	eb 1a                	jmp    640 <malloc+0xa4>
 626:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 628:	39 ce                	cmp    %ecx,%esi
 62a:	74 24                	je     650 <malloc+0xb4>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 62c:	29 f1                	sub    %esi,%ecx
 62e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 631:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 634:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
 637:	89 15 30 0b 00 00    	mov    %edx,0xb30
      return (void*)(p + 1);
 63d:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 640:	8d 65 f4             	lea    -0xc(%ebp),%esp
 643:	5b                   	pop    %ebx
 644:	5e                   	pop    %esi
 645:	5f                   	pop    %edi
 646:	5d                   	pop    %ebp
 647:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 648:	89 d8                	mov    %ebx,%eax
 64a:	89 f7                	mov    %esi,%edi
 64c:	eb a7                	jmp    5f5 <malloc+0x59>
 64e:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 650:	8b 08                	mov    (%eax),%ecx
 652:	89 0a                	mov    %ecx,(%edx)
 654:	eb e1                	jmp    637 <malloc+0x9b>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 656:	c7 05 30 0b 00 00 34 	movl   $0xb34,0xb30
 65d:	0b 00 00 
 660:	c7 05 34 0b 00 00 34 	movl   $0xb34,0xb34
 667:	0b 00 00 
    base.s.size = 0;
 66a:	c7 05 38 0b 00 00 00 	movl   $0x0,0xb38
 671:	00 00 00 
 674:	b8 34 0b 00 00       	mov    $0xb34,%eax
 679:	e9 48 ff ff ff       	jmp    5c6 <malloc+0x2a>
