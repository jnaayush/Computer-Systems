
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	50                   	push   %eax
  if(fork() > 0)
   f:	e8 bb 01 00 00       	call   1cf <fork>
  14:	85 c0                	test   %eax,%eax
  16:	7e 0d                	jle    25 <main+0x25>
    sleep(5);  // Let child exit before parent.
  18:	83 ec 0c             	sub    $0xc,%esp
  1b:	6a 05                	push   $0x5
  1d:	e8 45 02 00 00       	call   267 <sleep>
  22:	83 c4 10             	add    $0x10,%esp
  exit();
  25:	e8 ad 01 00 00       	call   1d7 <exit>
  2a:	66 90                	xchg   %ax,%ax

0000002c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  2c:	55                   	push   %ebp
  2d:	89 e5                	mov    %esp,%ebp
  2f:	53                   	push   %ebx
  30:	8b 45 08             	mov    0x8(%ebp),%eax
  33:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  36:	89 c2                	mov    %eax,%edx
  38:	42                   	inc    %edx
  39:	41                   	inc    %ecx
  3a:	8a 59 ff             	mov    -0x1(%ecx),%bl
  3d:	88 5a ff             	mov    %bl,-0x1(%edx)
  40:	84 db                	test   %bl,%bl
  42:	75 f4                	jne    38 <strcpy+0xc>
    ;
  return os;
}
  44:	5b                   	pop    %ebx
  45:	5d                   	pop    %ebp
  46:	c3                   	ret    
  47:	90                   	nop

00000048 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  48:	55                   	push   %ebp
  49:	89 e5                	mov    %esp,%ebp
  4b:	56                   	push   %esi
  4c:	53                   	push   %ebx
  4d:	8b 55 08             	mov    0x8(%ebp),%edx
  50:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  53:	0f b6 02             	movzbl (%edx),%eax
  56:	0f b6 0b             	movzbl (%ebx),%ecx
  59:	84 c0                	test   %al,%al
  5b:	75 14                	jne    71 <strcmp+0x29>
  5d:	eb 1d                	jmp    7c <strcmp+0x34>
  5f:	90                   	nop
    p++, q++;
  60:	42                   	inc    %edx
  61:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  64:	0f b6 02             	movzbl (%edx),%eax
  67:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  6b:	84 c0                	test   %al,%al
  6d:	74 0d                	je     7c <strcmp+0x34>
  6f:	89 f3                	mov    %esi,%ebx
  71:	38 c8                	cmp    %cl,%al
  73:	74 eb                	je     60 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  75:	29 c8                	sub    %ecx,%eax
}
  77:	5b                   	pop    %ebx
  78:	5e                   	pop    %esi
  79:	5d                   	pop    %ebp
  7a:	c3                   	ret    
  7b:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  7c:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  7e:	29 c8                	sub    %ecx,%eax
}
  80:	5b                   	pop    %ebx
  81:	5e                   	pop    %esi
  82:	5d                   	pop    %ebp
  83:	c3                   	ret    

00000084 <strlen>:

uint
strlen(char *s)
{
  84:	55                   	push   %ebp
  85:	89 e5                	mov    %esp,%ebp
  87:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  8a:	80 39 00             	cmpb   $0x0,(%ecx)
  8d:	74 10                	je     9f <strlen+0x1b>
  8f:	31 d2                	xor    %edx,%edx
  91:	8d 76 00             	lea    0x0(%esi),%esi
  94:	42                   	inc    %edx
  95:	89 d0                	mov    %edx,%eax
  97:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  9b:	75 f7                	jne    94 <strlen+0x10>
    ;
  return n;
}
  9d:	5d                   	pop    %ebp
  9e:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
  9f:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  a1:	5d                   	pop    %ebp
  a2:	c3                   	ret    
  a3:	90                   	nop

000000a4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  a4:	55                   	push   %ebp
  a5:	89 e5                	mov    %esp,%ebp
  a7:	57                   	push   %edi
  a8:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  ab:	89 d7                	mov    %edx,%edi
  ad:	8b 4d 10             	mov    0x10(%ebp),%ecx
  b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  b3:	fc                   	cld    
  b4:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  b6:	89 d0                	mov    %edx,%eax
  b8:	5f                   	pop    %edi
  b9:	5d                   	pop    %ebp
  ba:	c3                   	ret    
  bb:	90                   	nop

000000bc <strchr>:

char*
strchr(const char *s, char c)
{
  bc:	55                   	push   %ebp
  bd:	89 e5                	mov    %esp,%ebp
  bf:	53                   	push   %ebx
  c0:	8b 45 08             	mov    0x8(%ebp),%eax
  c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
  c6:	8a 18                	mov    (%eax),%bl
  c8:	84 db                	test   %bl,%bl
  ca:	74 13                	je     df <strchr+0x23>
  cc:	88 d1                	mov    %dl,%cl
    if(*s == c)
  ce:	38 d3                	cmp    %dl,%bl
  d0:	75 06                	jne    d8 <strchr+0x1c>
  d2:	eb 0d                	jmp    e1 <strchr+0x25>
  d4:	38 ca                	cmp    %cl,%dl
  d6:	74 09                	je     e1 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
  d8:	40                   	inc    %eax
  d9:	8a 10                	mov    (%eax),%dl
  db:	84 d2                	test   %dl,%dl
  dd:	75 f5                	jne    d4 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
  df:	31 c0                	xor    %eax,%eax
}
  e1:	5b                   	pop    %ebx
  e2:	5d                   	pop    %ebp
  e3:	c3                   	ret    

000000e4 <gets>:

char*
gets(char *buf, int max)
{
  e4:	55                   	push   %ebp
  e5:	89 e5                	mov    %esp,%ebp
  e7:	57                   	push   %edi
  e8:	56                   	push   %esi
  e9:	53                   	push   %ebx
  ea:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
  ed:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
  ef:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
  f2:	eb 26                	jmp    11a <gets+0x36>
    cc = read(0, &c, 1);
  f4:	50                   	push   %eax
  f5:	6a 01                	push   $0x1
  f7:	57                   	push   %edi
  f8:	6a 00                	push   $0x0
  fa:	e8 f0 00 00 00       	call   1ef <read>
    if(cc < 1)
  ff:	83 c4 10             	add    $0x10,%esp
 102:	85 c0                	test   %eax,%eax
 104:	7e 1c                	jle    122 <gets+0x3e>
      break;
    buf[i++] = c;
 106:	8a 45 e7             	mov    -0x19(%ebp),%al
 109:	8b 55 08             	mov    0x8(%ebp),%edx
 10c:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
 110:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 112:	3c 0a                	cmp    $0xa,%al
 114:	74 0c                	je     122 <gets+0x3e>
 116:	3c 0d                	cmp    $0xd,%al
 118:	74 08                	je     122 <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 11a:	8d 5e 01             	lea    0x1(%esi),%ebx
 11d:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 120:	7c d2                	jl     f4 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 122:	8b 45 08             	mov    0x8(%ebp),%eax
 125:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 129:	8d 65 f4             	lea    -0xc(%ebp),%esp
 12c:	5b                   	pop    %ebx
 12d:	5e                   	pop    %esi
 12e:	5f                   	pop    %edi
 12f:	5d                   	pop    %ebp
 130:	c3                   	ret    
 131:	8d 76 00             	lea    0x0(%esi),%esi

00000134 <stat>:

int
stat(char *n, struct stat *st)
{
 134:	55                   	push   %ebp
 135:	89 e5                	mov    %esp,%ebp
 137:	56                   	push   %esi
 138:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 139:	83 ec 08             	sub    $0x8,%esp
 13c:	6a 00                	push   $0x0
 13e:	ff 75 08             	pushl  0x8(%ebp)
 141:	e8 d1 00 00 00       	call   217 <open>
 146:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 148:	83 c4 10             	add    $0x10,%esp
 14b:	85 c0                	test   %eax,%eax
 14d:	78 25                	js     174 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 14f:	83 ec 08             	sub    $0x8,%esp
 152:	ff 75 0c             	pushl  0xc(%ebp)
 155:	50                   	push   %eax
 156:	e8 d4 00 00 00       	call   22f <fstat>
 15b:	89 c6                	mov    %eax,%esi
  close(fd);
 15d:	89 1c 24             	mov    %ebx,(%esp)
 160:	e8 9a 00 00 00       	call   1ff <close>
  return r;
 165:	83 c4 10             	add    $0x10,%esp
 168:	89 f0                	mov    %esi,%eax
}
 16a:	8d 65 f8             	lea    -0x8(%ebp),%esp
 16d:	5b                   	pop    %ebx
 16e:	5e                   	pop    %esi
 16f:	5d                   	pop    %ebp
 170:	c3                   	ret    
 171:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 174:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 179:	eb ef                	jmp    16a <stat+0x36>
 17b:	90                   	nop

0000017c <atoi>:
  return r;
}

int
atoi(const char *s)
{
 17c:	55                   	push   %ebp
 17d:	89 e5                	mov    %esp,%ebp
 17f:	53                   	push   %ebx
 180:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 183:	0f be 11             	movsbl (%ecx),%edx
 186:	8d 42 d0             	lea    -0x30(%edx),%eax
 189:	3c 09                	cmp    $0x9,%al
 18b:	b8 00 00 00 00       	mov    $0x0,%eax
 190:	77 15                	ja     1a7 <atoi+0x2b>
 192:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 194:	41                   	inc    %ecx
 195:	8d 04 80             	lea    (%eax,%eax,4),%eax
 198:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 19c:	0f be 11             	movsbl (%ecx),%edx
 19f:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1a2:	80 fb 09             	cmp    $0x9,%bl
 1a5:	76 ed                	jbe    194 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 1a7:	5b                   	pop    %ebx
 1a8:	5d                   	pop    %ebp
 1a9:	c3                   	ret    
 1aa:	66 90                	xchg   %ax,%ax

000001ac <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 1ac:	55                   	push   %ebp
 1ad:	89 e5                	mov    %esp,%ebp
 1af:	56                   	push   %esi
 1b0:	53                   	push   %ebx
 1b1:	8b 45 08             	mov    0x8(%ebp),%eax
 1b4:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1b7:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1ba:	31 d2                	xor    %edx,%edx
 1bc:	85 f6                	test   %esi,%esi
 1be:	7e 0b                	jle    1cb <memmove+0x1f>
    *dst++ = *src++;
 1c0:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 1c3:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 1c6:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1c7:	39 f2                	cmp    %esi,%edx
 1c9:	75 f5                	jne    1c0 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 1cb:	5b                   	pop    %ebx
 1cc:	5e                   	pop    %esi
 1cd:	5d                   	pop    %ebp
 1ce:	c3                   	ret    

000001cf <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 1cf:	b8 01 00 00 00       	mov    $0x1,%eax
 1d4:	cd 40                	int    $0x40
 1d6:	c3                   	ret    

000001d7 <exit>:
SYSCALL(exit)
 1d7:	b8 02 00 00 00       	mov    $0x2,%eax
 1dc:	cd 40                	int    $0x40
 1de:	c3                   	ret    

000001df <wait>:
SYSCALL(wait)
 1df:	b8 03 00 00 00       	mov    $0x3,%eax
 1e4:	cd 40                	int    $0x40
 1e6:	c3                   	ret    

000001e7 <pipe>:
SYSCALL(pipe)
 1e7:	b8 04 00 00 00       	mov    $0x4,%eax
 1ec:	cd 40                	int    $0x40
 1ee:	c3                   	ret    

000001ef <read>:
SYSCALL(read)
 1ef:	b8 05 00 00 00       	mov    $0x5,%eax
 1f4:	cd 40                	int    $0x40
 1f6:	c3                   	ret    

000001f7 <write>:
SYSCALL(write)
 1f7:	b8 10 00 00 00       	mov    $0x10,%eax
 1fc:	cd 40                	int    $0x40
 1fe:	c3                   	ret    

000001ff <close>:
SYSCALL(close)
 1ff:	b8 15 00 00 00       	mov    $0x15,%eax
 204:	cd 40                	int    $0x40
 206:	c3                   	ret    

00000207 <kill>:
SYSCALL(kill)
 207:	b8 06 00 00 00       	mov    $0x6,%eax
 20c:	cd 40                	int    $0x40
 20e:	c3                   	ret    

0000020f <exec>:
SYSCALL(exec)
 20f:	b8 07 00 00 00       	mov    $0x7,%eax
 214:	cd 40                	int    $0x40
 216:	c3                   	ret    

00000217 <open>:
SYSCALL(open)
 217:	b8 0f 00 00 00       	mov    $0xf,%eax
 21c:	cd 40                	int    $0x40
 21e:	c3                   	ret    

0000021f <mknod>:
SYSCALL(mknod)
 21f:	b8 11 00 00 00       	mov    $0x11,%eax
 224:	cd 40                	int    $0x40
 226:	c3                   	ret    

00000227 <unlink>:
SYSCALL(unlink)
 227:	b8 12 00 00 00       	mov    $0x12,%eax
 22c:	cd 40                	int    $0x40
 22e:	c3                   	ret    

0000022f <fstat>:
SYSCALL(fstat)
 22f:	b8 08 00 00 00       	mov    $0x8,%eax
 234:	cd 40                	int    $0x40
 236:	c3                   	ret    

00000237 <link>:
SYSCALL(link)
 237:	b8 13 00 00 00       	mov    $0x13,%eax
 23c:	cd 40                	int    $0x40
 23e:	c3                   	ret    

0000023f <mkdir>:
SYSCALL(mkdir)
 23f:	b8 14 00 00 00       	mov    $0x14,%eax
 244:	cd 40                	int    $0x40
 246:	c3                   	ret    

00000247 <chdir>:
SYSCALL(chdir)
 247:	b8 09 00 00 00       	mov    $0x9,%eax
 24c:	cd 40                	int    $0x40
 24e:	c3                   	ret    

0000024f <dup>:
SYSCALL(dup)
 24f:	b8 0a 00 00 00       	mov    $0xa,%eax
 254:	cd 40                	int    $0x40
 256:	c3                   	ret    

00000257 <getpid>:
SYSCALL(getpid)
 257:	b8 0b 00 00 00       	mov    $0xb,%eax
 25c:	cd 40                	int    $0x40
 25e:	c3                   	ret    

0000025f <sbrk>:
SYSCALL(sbrk)
 25f:	b8 0c 00 00 00       	mov    $0xc,%eax
 264:	cd 40                	int    $0x40
 266:	c3                   	ret    

00000267 <sleep>:
SYSCALL(sleep)
 267:	b8 0d 00 00 00       	mov    $0xd,%eax
 26c:	cd 40                	int    $0x40
 26e:	c3                   	ret    

0000026f <uptime>:
SYSCALL(uptime)
 26f:	b8 0e 00 00 00       	mov    $0xe,%eax
 274:	cd 40                	int    $0x40
 276:	c3                   	ret    

00000277 <mike>:
SYSCALL(mike)
 277:	b8 16 00 00 00       	mov    $0x16,%eax
 27c:	cd 40                	int    $0x40
 27e:	c3                   	ret    
 27f:	90                   	nop

00000280 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	57                   	push   %edi
 284:	56                   	push   %esi
 285:	53                   	push   %ebx
 286:	83 ec 3c             	sub    $0x3c,%esp
 289:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 28b:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 28d:	8b 5d 08             	mov    0x8(%ebp),%ebx
 290:	85 db                	test   %ebx,%ebx
 292:	74 04                	je     298 <printint+0x18>
 294:	85 d2                	test   %edx,%edx
 296:	78 53                	js     2eb <printint+0x6b>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 298:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 29f:	31 db                	xor    %ebx,%ebx
 2a1:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 2a4:	43                   	inc    %ebx
 2a5:	31 d2                	xor    %edx,%edx
 2a7:	f7 f1                	div    %ecx
 2a9:	8a 92 d0 05 00 00    	mov    0x5d0(%edx),%dl
 2af:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 2b2:	85 c0                	test   %eax,%eax
 2b4:	75 ee                	jne    2a4 <printint+0x24>
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 2b6:	89 d8                	mov    %ebx,%eax
  }while((x /= base) != 0);
  if(neg)
 2b8:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 2bb:	85 d2                	test   %edx,%edx
 2bd:	74 06                	je     2c5 <printint+0x45>
    buf[i++] = '-';
 2bf:	43                   	inc    %ebx
 2c0:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 2c5:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 2c9:	8d 76 00             	lea    0x0(%esi),%esi
 2cc:	8a 03                	mov    (%ebx),%al
 2ce:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 2d1:	50                   	push   %eax
 2d2:	6a 01                	push   $0x1
 2d4:	56                   	push   %esi
 2d5:	57                   	push   %edi
 2d6:	e8 1c ff ff ff       	call   1f7 <write>
 2db:	4b                   	dec    %ebx
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 2dc:	83 c4 10             	add    $0x10,%esp
 2df:	39 f3                	cmp    %esi,%ebx
 2e1:	75 e9                	jne    2cc <printint+0x4c>
    putc(fd, buf[i]);
}
 2e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2e6:	5b                   	pop    %ebx
 2e7:	5e                   	pop    %esi
 2e8:	5f                   	pop    %edi
 2e9:	5d                   	pop    %ebp
 2ea:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 2eb:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 2ed:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 2f4:	eb a9                	jmp    29f <printint+0x1f>
 2f6:	66 90                	xchg   %ax,%ax

000002f8 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 2f8:	55                   	push   %ebp
 2f9:	89 e5                	mov    %esp,%ebp
 2fb:	57                   	push   %edi
 2fc:	56                   	push   %esi
 2fd:	53                   	push   %ebx
 2fe:	83 ec 2c             	sub    $0x2c,%esp
 301:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 304:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 307:	8a 13                	mov    (%ebx),%dl
 309:	84 d2                	test   %dl,%dl
 30b:	0f 84 a3 00 00 00    	je     3b4 <printf+0xbc>
 311:	43                   	inc    %ebx
 312:	8d 45 10             	lea    0x10(%ebp),%eax
 315:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 318:	31 ff                	xor    %edi,%edi
 31a:	eb 24                	jmp    340 <printf+0x48>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 31c:	83 fa 25             	cmp    $0x25,%edx
 31f:	0f 84 97 00 00 00    	je     3bc <printf+0xc4>
        state = '%';
      } else {
        putc(fd, c);
 325:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 328:	50                   	push   %eax
 329:	6a 01                	push   $0x1
 32b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 32e:	50                   	push   %eax
 32f:	56                   	push   %esi
 330:	e8 c2 fe ff ff       	call   1f7 <write>
 335:	83 c4 10             	add    $0x10,%esp
 338:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 339:	8a 53 ff             	mov    -0x1(%ebx),%dl
 33c:	84 d2                	test   %dl,%dl
 33e:	74 74                	je     3b4 <printf+0xbc>
    c = fmt[i] & 0xff;
 340:	0f be c2             	movsbl %dl,%eax
 343:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
 346:	85 ff                	test   %edi,%edi
 348:	74 d2                	je     31c <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 34a:	83 ff 25             	cmp    $0x25,%edi
 34d:	75 e9                	jne    338 <printf+0x40>
      if(c == 'd'){
 34f:	83 fa 64             	cmp    $0x64,%edx
 352:	0f 84 e8 00 00 00    	je     440 <printf+0x148>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 358:	25 f7 00 00 00       	and    $0xf7,%eax
 35d:	83 f8 70             	cmp    $0x70,%eax
 360:	74 66                	je     3c8 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 362:	83 fa 73             	cmp    $0x73,%edx
 365:	0f 84 85 00 00 00    	je     3f0 <printf+0xf8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 36b:	83 fa 63             	cmp    $0x63,%edx
 36e:	0f 84 b5 00 00 00    	je     429 <printf+0x131>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 374:	83 fa 25             	cmp    $0x25,%edx
 377:	0f 84 cf 00 00 00    	je     44c <printf+0x154>
 37d:	89 55 d0             	mov    %edx,-0x30(%ebp)
 380:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 384:	50                   	push   %eax
 385:	6a 01                	push   $0x1
 387:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 38a:	50                   	push   %eax
 38b:	56                   	push   %esi
 38c:	e8 66 fe ff ff       	call   1f7 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 391:	8b 55 d0             	mov    -0x30(%ebp),%edx
 394:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 397:	83 c4 0c             	add    $0xc,%esp
 39a:	6a 01                	push   $0x1
 39c:	8d 45 e7             	lea    -0x19(%ebp),%eax
 39f:	50                   	push   %eax
 3a0:	56                   	push   %esi
 3a1:	e8 51 fe ff ff       	call   1f7 <write>
 3a6:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 3a9:	31 ff                	xor    %edi,%edi
 3ab:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3ac:	8a 53 ff             	mov    -0x1(%ebx),%dl
 3af:	84 d2                	test   %dl,%dl
 3b1:	75 8d                	jne    340 <printf+0x48>
 3b3:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 3b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3b7:	5b                   	pop    %ebx
 3b8:	5e                   	pop    %esi
 3b9:	5f                   	pop    %edi
 3ba:	5d                   	pop    %ebp
 3bb:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 3bc:	bf 25 00 00 00       	mov    $0x25,%edi
 3c1:	e9 72 ff ff ff       	jmp    338 <printf+0x40>
 3c6:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 3c8:	83 ec 0c             	sub    $0xc,%esp
 3cb:	6a 00                	push   $0x0
 3cd:	b9 10 00 00 00       	mov    $0x10,%ecx
 3d2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 3d5:	8b 17                	mov    (%edi),%edx
 3d7:	89 f0                	mov    %esi,%eax
 3d9:	e8 a2 fe ff ff       	call   280 <printint>
        ap++;
 3de:	89 f8                	mov    %edi,%eax
 3e0:	83 c0 04             	add    $0x4,%eax
 3e3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 3e6:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 3e9:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 3eb:	e9 48 ff ff ff       	jmp    338 <printf+0x40>
      } else if(c == 's'){
        s = (char*)*ap;
 3f0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 3f3:	8b 38                	mov    (%eax),%edi
        ap++;
 3f5:	83 c0 04             	add    $0x4,%eax
 3f8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 3fb:	85 ff                	test   %edi,%edi
 3fd:	74 5c                	je     45b <printf+0x163>
          s = "(null)";
        while(*s != 0){
 3ff:	8a 07                	mov    (%edi),%al
 401:	84 c0                	test   %al,%al
 403:	74 1d                	je     422 <printf+0x12a>
 405:	8d 76 00             	lea    0x0(%esi),%esi
 408:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 40b:	50                   	push   %eax
 40c:	6a 01                	push   $0x1
 40e:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 411:	50                   	push   %eax
 412:	56                   	push   %esi
 413:	e8 df fd ff ff       	call   1f7 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 418:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 419:	8a 07                	mov    (%edi),%al
 41b:	83 c4 10             	add    $0x10,%esp
 41e:	84 c0                	test   %al,%al
 420:	75 e6                	jne    408 <printf+0x110>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 422:	31 ff                	xor    %edi,%edi
 424:	e9 0f ff ff ff       	jmp    338 <printf+0x40>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 429:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 42c:	8b 07                	mov    (%edi),%eax
 42e:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 431:	51                   	push   %ecx
 432:	6a 01                	push   $0x1
 434:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 437:	50                   	push   %eax
 438:	56                   	push   %esi
 439:	e8 b9 fd ff ff       	call   1f7 <write>
 43e:	eb 9e                	jmp    3de <printf+0xe6>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 440:	83 ec 0c             	sub    $0xc,%esp
 443:	6a 01                	push   $0x1
 445:	b9 0a 00 00 00       	mov    $0xa,%ecx
 44a:	eb 86                	jmp    3d2 <printf+0xda>
 44c:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 450:	52                   	push   %edx
 451:	6a 01                	push   $0x1
 453:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 456:	e9 44 ff ff ff       	jmp    39f <printf+0xa7>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 45b:	bf c8 05 00 00       	mov    $0x5c8,%edi
 460:	eb 9d                	jmp    3ff <printf+0x107>
 462:	66 90                	xchg   %ax,%ax

00000464 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 464:	55                   	push   %ebp
 465:	89 e5                	mov    %esp,%ebp
 467:	57                   	push   %edi
 468:	56                   	push   %esi
 469:	53                   	push   %ebx
 46a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 46d:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 470:	a1 58 08 00 00       	mov    0x858,%eax
 475:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 478:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 47a:	39 c8                	cmp    %ecx,%eax
 47c:	73 2e                	jae    4ac <free+0x48>
 47e:	39 d1                	cmp    %edx,%ecx
 480:	72 04                	jb     486 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 482:	39 d0                	cmp    %edx,%eax
 484:	72 2e                	jb     4b4 <free+0x50>
      break;
  if(bp + bp->s.size == p->s.ptr){
 486:	8b 73 fc             	mov    -0x4(%ebx),%esi
 489:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 48c:	39 d7                	cmp    %edx,%edi
 48e:	74 28                	je     4b8 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 490:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 493:	8b 50 04             	mov    0x4(%eax),%edx
 496:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 499:	39 f1                	cmp    %esi,%ecx
 49b:	74 32                	je     4cf <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 49d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 49f:	a3 58 08 00 00       	mov    %eax,0x858
}
 4a4:	5b                   	pop    %ebx
 4a5:	5e                   	pop    %esi
 4a6:	5f                   	pop    %edi
 4a7:	5d                   	pop    %ebp
 4a8:	c3                   	ret    
 4a9:	8d 76 00             	lea    0x0(%esi),%esi
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4ac:	39 d0                	cmp    %edx,%eax
 4ae:	72 04                	jb     4b4 <free+0x50>
 4b0:	39 d1                	cmp    %edx,%ecx
 4b2:	72 d2                	jb     486 <free+0x22>
static Header base;
static Header *freep;

void
free(void *ap)
{
 4b4:	89 d0                	mov    %edx,%eax
 4b6:	eb c0                	jmp    478 <free+0x14>
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 4b8:	03 72 04             	add    0x4(%edx),%esi
 4bb:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 4be:	8b 10                	mov    (%eax),%edx
 4c0:	8b 12                	mov    (%edx),%edx
 4c2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 4c5:	8b 50 04             	mov    0x4(%eax),%edx
 4c8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 4cb:	39 f1                	cmp    %esi,%ecx
 4cd:	75 ce                	jne    49d <free+0x39>
    p->s.size += bp->s.size;
 4cf:	03 53 fc             	add    -0x4(%ebx),%edx
 4d2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 4d5:	8b 53 f8             	mov    -0x8(%ebx),%edx
 4d8:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 4da:	a3 58 08 00 00       	mov    %eax,0x858
}
 4df:	5b                   	pop    %ebx
 4e0:	5e                   	pop    %esi
 4e1:	5f                   	pop    %edi
 4e2:	5d                   	pop    %ebp
 4e3:	c3                   	ret    

000004e4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 4e4:	55                   	push   %ebp
 4e5:	89 e5                	mov    %esp,%ebp
 4e7:	57                   	push   %edi
 4e8:	56                   	push   %esi
 4e9:	53                   	push   %ebx
 4ea:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 4ed:	8b 45 08             	mov    0x8(%ebp),%eax
 4f0:	8d 70 07             	lea    0x7(%eax),%esi
 4f3:	c1 ee 03             	shr    $0x3,%esi
 4f6:	46                   	inc    %esi
  if((prevp = freep) == 0){
 4f7:	8b 15 58 08 00 00    	mov    0x858,%edx
 4fd:	85 d2                	test   %edx,%edx
 4ff:	0f 84 99 00 00 00    	je     59e <malloc+0xba>
 505:	8b 02                	mov    (%edx),%eax
 507:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 50a:	39 ce                	cmp    %ecx,%esi
 50c:	76 62                	jbe    570 <malloc+0x8c>
 50e:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 515:	eb 0a                	jmp    521 <malloc+0x3d>
 517:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 518:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 51a:	8b 48 04             	mov    0x4(%eax),%ecx
 51d:	39 ce                	cmp    %ecx,%esi
 51f:	76 4f                	jbe    570 <malloc+0x8c>
 521:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 523:	3b 05 58 08 00 00    	cmp    0x858,%eax
 529:	75 ed                	jne    518 <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 52b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 531:	77 5d                	ja     590 <malloc+0xac>
 533:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 538:	bf 00 10 00 00       	mov    $0x1000,%edi
  p = sbrk(nu * sizeof(Header));
 53d:	83 ec 0c             	sub    $0xc,%esp
 540:	50                   	push   %eax
 541:	e8 19 fd ff ff       	call   25f <sbrk>
  if(p == (char*)-1)
 546:	83 c4 10             	add    $0x10,%esp
 549:	83 f8 ff             	cmp    $0xffffffff,%eax
 54c:	74 1c                	je     56a <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 54e:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 551:	83 ec 0c             	sub    $0xc,%esp
 554:	83 c0 08             	add    $0x8,%eax
 557:	50                   	push   %eax
 558:	e8 07 ff ff ff       	call   464 <free>
  return freep;
 55d:	8b 15 58 08 00 00    	mov    0x858,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 563:	83 c4 10             	add    $0x10,%esp
 566:	85 d2                	test   %edx,%edx
 568:	75 ae                	jne    518 <malloc+0x34>
        return 0;
 56a:	31 c0                	xor    %eax,%eax
 56c:	eb 1a                	jmp    588 <malloc+0xa4>
 56e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 570:	39 ce                	cmp    %ecx,%esi
 572:	74 24                	je     598 <malloc+0xb4>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 574:	29 f1                	sub    %esi,%ecx
 576:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 579:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 57c:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
 57f:	89 15 58 08 00 00    	mov    %edx,0x858
      return (void*)(p + 1);
 585:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 588:	8d 65 f4             	lea    -0xc(%ebp),%esp
 58b:	5b                   	pop    %ebx
 58c:	5e                   	pop    %esi
 58d:	5f                   	pop    %edi
 58e:	5d                   	pop    %ebp
 58f:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 590:	89 d8                	mov    %ebx,%eax
 592:	89 f7                	mov    %esi,%edi
 594:	eb a7                	jmp    53d <malloc+0x59>
 596:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 598:	8b 08                	mov    (%eax),%ecx
 59a:	89 0a                	mov    %ecx,(%edx)
 59c:	eb e1                	jmp    57f <malloc+0x9b>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 59e:	c7 05 58 08 00 00 5c 	movl   $0x85c,0x858
 5a5:	08 00 00 
 5a8:	c7 05 5c 08 00 00 5c 	movl   $0x85c,0x85c
 5af:	08 00 00 
    base.s.size = 0;
 5b2:	c7 05 60 08 00 00 00 	movl   $0x0,0x860
 5b9:	00 00 00 
 5bc:	b8 5c 08 00 00       	mov    $0x85c,%eax
 5c1:	e9 48 ff ff ff       	jmp    50e <malloc+0x2a>
