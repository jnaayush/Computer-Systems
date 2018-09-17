
_echo:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

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

  for(i = 1; i < argc; i++)
  19:	83 fe 01             	cmp    $0x1,%esi
  1c:	7e 3f                	jle    5d <main+0x5d>
  1e:	bb 01 00 00 00       	mov    $0x1,%ebx
  23:	eb 1b                	jmp    40 <main+0x40>
  25:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  28:	68 00 06 00 00       	push   $0x600
  2d:	ff 74 9f fc          	pushl  -0x4(%edi,%ebx,4)
  31:	68 02 06 00 00       	push   $0x602
  36:	6a 01                	push   $0x1
  38:	e8 f3 02 00 00       	call   330 <printf>
  3d:	83 c4 10             	add    $0x10,%esp
  40:	43                   	inc    %ebx
  41:	39 f3                	cmp    %esi,%ebx
  43:	75 e3                	jne    28 <main+0x28>
  45:	68 07 06 00 00       	push   $0x607
  4a:	ff 74 9f fc          	pushl  -0x4(%edi,%ebx,4)
  4e:	68 02 06 00 00       	push   $0x602
  53:	6a 01                	push   $0x1
  55:	e8 d6 02 00 00       	call   330 <printf>
  5a:	83 c4 10             	add    $0x10,%esp
  exit();
  5d:	e8 ad 01 00 00       	call   20f <exit>
  62:	66 90                	xchg   %ax,%ax

00000064 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  64:	55                   	push   %ebp
  65:	89 e5                	mov    %esp,%ebp
  67:	53                   	push   %ebx
  68:	8b 45 08             	mov    0x8(%ebp),%eax
  6b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6e:	89 c2                	mov    %eax,%edx
  70:	42                   	inc    %edx
  71:	41                   	inc    %ecx
  72:	8a 59 ff             	mov    -0x1(%ecx),%bl
  75:	88 5a ff             	mov    %bl,-0x1(%edx)
  78:	84 db                	test   %bl,%bl
  7a:	75 f4                	jne    70 <strcpy+0xc>
    ;
  return os;
}
  7c:	5b                   	pop    %ebx
  7d:	5d                   	pop    %ebp
  7e:	c3                   	ret    
  7f:	90                   	nop

00000080 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	56                   	push   %esi
  84:	53                   	push   %ebx
  85:	8b 55 08             	mov    0x8(%ebp),%edx
  88:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  8b:	0f b6 02             	movzbl (%edx),%eax
  8e:	0f b6 0b             	movzbl (%ebx),%ecx
  91:	84 c0                	test   %al,%al
  93:	75 14                	jne    a9 <strcmp+0x29>
  95:	eb 1d                	jmp    b4 <strcmp+0x34>
  97:	90                   	nop
    p++, q++;
  98:	42                   	inc    %edx
  99:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  9c:	0f b6 02             	movzbl (%edx),%eax
  9f:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  a3:	84 c0                	test   %al,%al
  a5:	74 0d                	je     b4 <strcmp+0x34>
  a7:	89 f3                	mov    %esi,%ebx
  a9:	38 c8                	cmp    %cl,%al
  ab:	74 eb                	je     98 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  ad:	29 c8                	sub    %ecx,%eax
}
  af:	5b                   	pop    %ebx
  b0:	5e                   	pop    %esi
  b1:	5d                   	pop    %ebp
  b2:	c3                   	ret    
  b3:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  b4:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  b6:	29 c8                	sub    %ecx,%eax
}
  b8:	5b                   	pop    %ebx
  b9:	5e                   	pop    %esi
  ba:	5d                   	pop    %ebp
  bb:	c3                   	ret    

000000bc <strlen>:

uint
strlen(char *s)
{
  bc:	55                   	push   %ebp
  bd:	89 e5                	mov    %esp,%ebp
  bf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  c2:	80 39 00             	cmpb   $0x0,(%ecx)
  c5:	74 10                	je     d7 <strlen+0x1b>
  c7:	31 d2                	xor    %edx,%edx
  c9:	8d 76 00             	lea    0x0(%esi),%esi
  cc:	42                   	inc    %edx
  cd:	89 d0                	mov    %edx,%eax
  cf:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  d3:	75 f7                	jne    cc <strlen+0x10>
    ;
  return n;
}
  d5:	5d                   	pop    %ebp
  d6:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
  d7:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  d9:	5d                   	pop    %ebp
  da:	c3                   	ret    
  db:	90                   	nop

000000dc <memset>:

void*
memset(void *dst, int c, uint n)
{
  dc:	55                   	push   %ebp
  dd:	89 e5                	mov    %esp,%ebp
  df:	57                   	push   %edi
  e0:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  e3:	89 d7                	mov    %edx,%edi
  e5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  eb:	fc                   	cld    
  ec:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  ee:	89 d0                	mov    %edx,%eax
  f0:	5f                   	pop    %edi
  f1:	5d                   	pop    %ebp
  f2:	c3                   	ret    
  f3:	90                   	nop

000000f4 <strchr>:

char*
strchr(const char *s, char c)
{
  f4:	55                   	push   %ebp
  f5:	89 e5                	mov    %esp,%ebp
  f7:	53                   	push   %ebx
  f8:	8b 45 08             	mov    0x8(%ebp),%eax
  fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
  fe:	8a 18                	mov    (%eax),%bl
 100:	84 db                	test   %bl,%bl
 102:	74 13                	je     117 <strchr+0x23>
 104:	88 d1                	mov    %dl,%cl
    if(*s == c)
 106:	38 d3                	cmp    %dl,%bl
 108:	75 06                	jne    110 <strchr+0x1c>
 10a:	eb 0d                	jmp    119 <strchr+0x25>
 10c:	38 ca                	cmp    %cl,%dl
 10e:	74 09                	je     119 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 110:	40                   	inc    %eax
 111:	8a 10                	mov    (%eax),%dl
 113:	84 d2                	test   %dl,%dl
 115:	75 f5                	jne    10c <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 117:	31 c0                	xor    %eax,%eax
}
 119:	5b                   	pop    %ebx
 11a:	5d                   	pop    %ebp
 11b:	c3                   	ret    

0000011c <gets>:

char*
gets(char *buf, int max)
{
 11c:	55                   	push   %ebp
 11d:	89 e5                	mov    %esp,%ebp
 11f:	57                   	push   %edi
 120:	56                   	push   %esi
 121:	53                   	push   %ebx
 122:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 125:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 127:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 12a:	eb 26                	jmp    152 <gets+0x36>
    cc = read(0, &c, 1);
 12c:	50                   	push   %eax
 12d:	6a 01                	push   $0x1
 12f:	57                   	push   %edi
 130:	6a 00                	push   $0x0
 132:	e8 f0 00 00 00       	call   227 <read>
    if(cc < 1)
 137:	83 c4 10             	add    $0x10,%esp
 13a:	85 c0                	test   %eax,%eax
 13c:	7e 1c                	jle    15a <gets+0x3e>
      break;
    buf[i++] = c;
 13e:	8a 45 e7             	mov    -0x19(%ebp),%al
 141:	8b 55 08             	mov    0x8(%ebp),%edx
 144:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
 148:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 14a:	3c 0a                	cmp    $0xa,%al
 14c:	74 0c                	je     15a <gets+0x3e>
 14e:	3c 0d                	cmp    $0xd,%al
 150:	74 08                	je     15a <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 152:	8d 5e 01             	lea    0x1(%esi),%ebx
 155:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 158:	7c d2                	jl     12c <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 15a:	8b 45 08             	mov    0x8(%ebp),%eax
 15d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 161:	8d 65 f4             	lea    -0xc(%ebp),%esp
 164:	5b                   	pop    %ebx
 165:	5e                   	pop    %esi
 166:	5f                   	pop    %edi
 167:	5d                   	pop    %ebp
 168:	c3                   	ret    
 169:	8d 76 00             	lea    0x0(%esi),%esi

0000016c <stat>:

int
stat(char *n, struct stat *st)
{
 16c:	55                   	push   %ebp
 16d:	89 e5                	mov    %esp,%ebp
 16f:	56                   	push   %esi
 170:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 171:	83 ec 08             	sub    $0x8,%esp
 174:	6a 00                	push   $0x0
 176:	ff 75 08             	pushl  0x8(%ebp)
 179:	e8 d1 00 00 00       	call   24f <open>
 17e:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 180:	83 c4 10             	add    $0x10,%esp
 183:	85 c0                	test   %eax,%eax
 185:	78 25                	js     1ac <stat+0x40>
    return -1;
  r = fstat(fd, st);
 187:	83 ec 08             	sub    $0x8,%esp
 18a:	ff 75 0c             	pushl  0xc(%ebp)
 18d:	50                   	push   %eax
 18e:	e8 d4 00 00 00       	call   267 <fstat>
 193:	89 c6                	mov    %eax,%esi
  close(fd);
 195:	89 1c 24             	mov    %ebx,(%esp)
 198:	e8 9a 00 00 00       	call   237 <close>
  return r;
 19d:	83 c4 10             	add    $0x10,%esp
 1a0:	89 f0                	mov    %esi,%eax
}
 1a2:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1a5:	5b                   	pop    %ebx
 1a6:	5e                   	pop    %esi
 1a7:	5d                   	pop    %ebp
 1a8:	c3                   	ret    
 1a9:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 1ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1b1:	eb ef                	jmp    1a2 <stat+0x36>
 1b3:	90                   	nop

000001b4 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1b4:	55                   	push   %ebp
 1b5:	89 e5                	mov    %esp,%ebp
 1b7:	53                   	push   %ebx
 1b8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1bb:	0f be 11             	movsbl (%ecx),%edx
 1be:	8d 42 d0             	lea    -0x30(%edx),%eax
 1c1:	3c 09                	cmp    $0x9,%al
 1c3:	b8 00 00 00 00       	mov    $0x0,%eax
 1c8:	77 15                	ja     1df <atoi+0x2b>
 1ca:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 1cc:	41                   	inc    %ecx
 1cd:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1d0:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1d4:	0f be 11             	movsbl (%ecx),%edx
 1d7:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1da:	80 fb 09             	cmp    $0x9,%bl
 1dd:	76 ed                	jbe    1cc <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 1df:	5b                   	pop    %ebx
 1e0:	5d                   	pop    %ebp
 1e1:	c3                   	ret    
 1e2:	66 90                	xchg   %ax,%ax

000001e4 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 1e4:	55                   	push   %ebp
 1e5:	89 e5                	mov    %esp,%ebp
 1e7:	56                   	push   %esi
 1e8:	53                   	push   %ebx
 1e9:	8b 45 08             	mov    0x8(%ebp),%eax
 1ec:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1ef:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1f2:	31 d2                	xor    %edx,%edx
 1f4:	85 f6                	test   %esi,%esi
 1f6:	7e 0b                	jle    203 <memmove+0x1f>
    *dst++ = *src++;
 1f8:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 1fb:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 1fe:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1ff:	39 f2                	cmp    %esi,%edx
 201:	75 f5                	jne    1f8 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 203:	5b                   	pop    %ebx
 204:	5e                   	pop    %esi
 205:	5d                   	pop    %ebp
 206:	c3                   	ret    

00000207 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 207:	b8 01 00 00 00       	mov    $0x1,%eax
 20c:	cd 40                	int    $0x40
 20e:	c3                   	ret    

0000020f <exit>:
SYSCALL(exit)
 20f:	b8 02 00 00 00       	mov    $0x2,%eax
 214:	cd 40                	int    $0x40
 216:	c3                   	ret    

00000217 <wait>:
SYSCALL(wait)
 217:	b8 03 00 00 00       	mov    $0x3,%eax
 21c:	cd 40                	int    $0x40
 21e:	c3                   	ret    

0000021f <pipe>:
SYSCALL(pipe)
 21f:	b8 04 00 00 00       	mov    $0x4,%eax
 224:	cd 40                	int    $0x40
 226:	c3                   	ret    

00000227 <read>:
SYSCALL(read)
 227:	b8 05 00 00 00       	mov    $0x5,%eax
 22c:	cd 40                	int    $0x40
 22e:	c3                   	ret    

0000022f <write>:
SYSCALL(write)
 22f:	b8 10 00 00 00       	mov    $0x10,%eax
 234:	cd 40                	int    $0x40
 236:	c3                   	ret    

00000237 <close>:
SYSCALL(close)
 237:	b8 15 00 00 00       	mov    $0x15,%eax
 23c:	cd 40                	int    $0x40
 23e:	c3                   	ret    

0000023f <kill>:
SYSCALL(kill)
 23f:	b8 06 00 00 00       	mov    $0x6,%eax
 244:	cd 40                	int    $0x40
 246:	c3                   	ret    

00000247 <exec>:
SYSCALL(exec)
 247:	b8 07 00 00 00       	mov    $0x7,%eax
 24c:	cd 40                	int    $0x40
 24e:	c3                   	ret    

0000024f <open>:
SYSCALL(open)
 24f:	b8 0f 00 00 00       	mov    $0xf,%eax
 254:	cd 40                	int    $0x40
 256:	c3                   	ret    

00000257 <mknod>:
SYSCALL(mknod)
 257:	b8 11 00 00 00       	mov    $0x11,%eax
 25c:	cd 40                	int    $0x40
 25e:	c3                   	ret    

0000025f <unlink>:
SYSCALL(unlink)
 25f:	b8 12 00 00 00       	mov    $0x12,%eax
 264:	cd 40                	int    $0x40
 266:	c3                   	ret    

00000267 <fstat>:
SYSCALL(fstat)
 267:	b8 08 00 00 00       	mov    $0x8,%eax
 26c:	cd 40                	int    $0x40
 26e:	c3                   	ret    

0000026f <link>:
SYSCALL(link)
 26f:	b8 13 00 00 00       	mov    $0x13,%eax
 274:	cd 40                	int    $0x40
 276:	c3                   	ret    

00000277 <mkdir>:
SYSCALL(mkdir)
 277:	b8 14 00 00 00       	mov    $0x14,%eax
 27c:	cd 40                	int    $0x40
 27e:	c3                   	ret    

0000027f <chdir>:
SYSCALL(chdir)
 27f:	b8 09 00 00 00       	mov    $0x9,%eax
 284:	cd 40                	int    $0x40
 286:	c3                   	ret    

00000287 <dup>:
SYSCALL(dup)
 287:	b8 0a 00 00 00       	mov    $0xa,%eax
 28c:	cd 40                	int    $0x40
 28e:	c3                   	ret    

0000028f <getpid>:
SYSCALL(getpid)
 28f:	b8 0b 00 00 00       	mov    $0xb,%eax
 294:	cd 40                	int    $0x40
 296:	c3                   	ret    

00000297 <sbrk>:
SYSCALL(sbrk)
 297:	b8 0c 00 00 00       	mov    $0xc,%eax
 29c:	cd 40                	int    $0x40
 29e:	c3                   	ret    

0000029f <sleep>:
SYSCALL(sleep)
 29f:	b8 0d 00 00 00       	mov    $0xd,%eax
 2a4:	cd 40                	int    $0x40
 2a6:	c3                   	ret    

000002a7 <uptime>:
SYSCALL(uptime)
 2a7:	b8 0e 00 00 00       	mov    $0xe,%eax
 2ac:	cd 40                	int    $0x40
 2ae:	c3                   	ret    

000002af <mike>:
SYSCALL(mike)
 2af:	b8 16 00 00 00       	mov    $0x16,%eax
 2b4:	cd 40                	int    $0x40
 2b6:	c3                   	ret    
 2b7:	90                   	nop

000002b8 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2b8:	55                   	push   %ebp
 2b9:	89 e5                	mov    %esp,%ebp
 2bb:	57                   	push   %edi
 2bc:	56                   	push   %esi
 2bd:	53                   	push   %ebx
 2be:	83 ec 3c             	sub    $0x3c,%esp
 2c1:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 2c3:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 2c8:	85 db                	test   %ebx,%ebx
 2ca:	74 04                	je     2d0 <printint+0x18>
 2cc:	85 d2                	test   %edx,%edx
 2ce:	78 53                	js     323 <printint+0x6b>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 2d0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 2d7:	31 db                	xor    %ebx,%ebx
 2d9:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 2dc:	43                   	inc    %ebx
 2dd:	31 d2                	xor    %edx,%edx
 2df:	f7 f1                	div    %ecx
 2e1:	8a 92 10 06 00 00    	mov    0x610(%edx),%dl
 2e7:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 2ea:	85 c0                	test   %eax,%eax
 2ec:	75 ee                	jne    2dc <printint+0x24>
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 2ee:	89 d8                	mov    %ebx,%eax
  }while((x /= base) != 0);
  if(neg)
 2f0:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 2f3:	85 d2                	test   %edx,%edx
 2f5:	74 06                	je     2fd <printint+0x45>
    buf[i++] = '-';
 2f7:	43                   	inc    %ebx
 2f8:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 2fd:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 301:	8d 76 00             	lea    0x0(%esi),%esi
 304:	8a 03                	mov    (%ebx),%al
 306:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 309:	50                   	push   %eax
 30a:	6a 01                	push   $0x1
 30c:	56                   	push   %esi
 30d:	57                   	push   %edi
 30e:	e8 1c ff ff ff       	call   22f <write>
 313:	4b                   	dec    %ebx
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 314:	83 c4 10             	add    $0x10,%esp
 317:	39 f3                	cmp    %esi,%ebx
 319:	75 e9                	jne    304 <printint+0x4c>
    putc(fd, buf[i]);
}
 31b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 31e:	5b                   	pop    %ebx
 31f:	5e                   	pop    %esi
 320:	5f                   	pop    %edi
 321:	5d                   	pop    %ebp
 322:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 323:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 325:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 32c:	eb a9                	jmp    2d7 <printint+0x1f>
 32e:	66 90                	xchg   %ax,%ax

00000330 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	56                   	push   %esi
 335:	53                   	push   %ebx
 336:	83 ec 2c             	sub    $0x2c,%esp
 339:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 33c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 33f:	8a 13                	mov    (%ebx),%dl
 341:	84 d2                	test   %dl,%dl
 343:	0f 84 a3 00 00 00    	je     3ec <printf+0xbc>
 349:	43                   	inc    %ebx
 34a:	8d 45 10             	lea    0x10(%ebp),%eax
 34d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 350:	31 ff                	xor    %edi,%edi
 352:	eb 24                	jmp    378 <printf+0x48>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 354:	83 fa 25             	cmp    $0x25,%edx
 357:	0f 84 97 00 00 00    	je     3f4 <printf+0xc4>
        state = '%';
      } else {
        putc(fd, c);
 35d:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 360:	50                   	push   %eax
 361:	6a 01                	push   $0x1
 363:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 366:	50                   	push   %eax
 367:	56                   	push   %esi
 368:	e8 c2 fe ff ff       	call   22f <write>
 36d:	83 c4 10             	add    $0x10,%esp
 370:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 371:	8a 53 ff             	mov    -0x1(%ebx),%dl
 374:	84 d2                	test   %dl,%dl
 376:	74 74                	je     3ec <printf+0xbc>
    c = fmt[i] & 0xff;
 378:	0f be c2             	movsbl %dl,%eax
 37b:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
 37e:	85 ff                	test   %edi,%edi
 380:	74 d2                	je     354 <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 382:	83 ff 25             	cmp    $0x25,%edi
 385:	75 e9                	jne    370 <printf+0x40>
      if(c == 'd'){
 387:	83 fa 64             	cmp    $0x64,%edx
 38a:	0f 84 e8 00 00 00    	je     478 <printf+0x148>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 390:	25 f7 00 00 00       	and    $0xf7,%eax
 395:	83 f8 70             	cmp    $0x70,%eax
 398:	74 66                	je     400 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 39a:	83 fa 73             	cmp    $0x73,%edx
 39d:	0f 84 85 00 00 00    	je     428 <printf+0xf8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3a3:	83 fa 63             	cmp    $0x63,%edx
 3a6:	0f 84 b5 00 00 00    	je     461 <printf+0x131>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3ac:	83 fa 25             	cmp    $0x25,%edx
 3af:	0f 84 cf 00 00 00    	je     484 <printf+0x154>
 3b5:	89 55 d0             	mov    %edx,-0x30(%ebp)
 3b8:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3bc:	50                   	push   %eax
 3bd:	6a 01                	push   $0x1
 3bf:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3c2:	50                   	push   %eax
 3c3:	56                   	push   %esi
 3c4:	e8 66 fe ff ff       	call   22f <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 3c9:	8b 55 d0             	mov    -0x30(%ebp),%edx
 3cc:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3cf:	83 c4 0c             	add    $0xc,%esp
 3d2:	6a 01                	push   $0x1
 3d4:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3d7:	50                   	push   %eax
 3d8:	56                   	push   %esi
 3d9:	e8 51 fe ff ff       	call   22f <write>
 3de:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 3e1:	31 ff                	xor    %edi,%edi
 3e3:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3e4:	8a 53 ff             	mov    -0x1(%ebx),%dl
 3e7:	84 d2                	test   %dl,%dl
 3e9:	75 8d                	jne    378 <printf+0x48>
 3eb:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 3ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3ef:	5b                   	pop    %ebx
 3f0:	5e                   	pop    %esi
 3f1:	5f                   	pop    %edi
 3f2:	5d                   	pop    %ebp
 3f3:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 3f4:	bf 25 00 00 00       	mov    $0x25,%edi
 3f9:	e9 72 ff ff ff       	jmp    370 <printf+0x40>
 3fe:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 400:	83 ec 0c             	sub    $0xc,%esp
 403:	6a 00                	push   $0x0
 405:	b9 10 00 00 00       	mov    $0x10,%ecx
 40a:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 40d:	8b 17                	mov    (%edi),%edx
 40f:	89 f0                	mov    %esi,%eax
 411:	e8 a2 fe ff ff       	call   2b8 <printint>
        ap++;
 416:	89 f8                	mov    %edi,%eax
 418:	83 c0 04             	add    $0x4,%eax
 41b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 41e:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 421:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 423:	e9 48 ff ff ff       	jmp    370 <printf+0x40>
      } else if(c == 's'){
        s = (char*)*ap;
 428:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 42b:	8b 38                	mov    (%eax),%edi
        ap++;
 42d:	83 c0 04             	add    $0x4,%eax
 430:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 433:	85 ff                	test   %edi,%edi
 435:	74 5c                	je     493 <printf+0x163>
          s = "(null)";
        while(*s != 0){
 437:	8a 07                	mov    (%edi),%al
 439:	84 c0                	test   %al,%al
 43b:	74 1d                	je     45a <printf+0x12a>
 43d:	8d 76 00             	lea    0x0(%esi),%esi
 440:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 443:	50                   	push   %eax
 444:	6a 01                	push   $0x1
 446:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 449:	50                   	push   %eax
 44a:	56                   	push   %esi
 44b:	e8 df fd ff ff       	call   22f <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 450:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 451:	8a 07                	mov    (%edi),%al
 453:	83 c4 10             	add    $0x10,%esp
 456:	84 c0                	test   %al,%al
 458:	75 e6                	jne    440 <printf+0x110>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 45a:	31 ff                	xor    %edi,%edi
 45c:	e9 0f ff ff ff       	jmp    370 <printf+0x40>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 461:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 464:	8b 07                	mov    (%edi),%eax
 466:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 469:	51                   	push   %ecx
 46a:	6a 01                	push   $0x1
 46c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 46f:	50                   	push   %eax
 470:	56                   	push   %esi
 471:	e8 b9 fd ff ff       	call   22f <write>
 476:	eb 9e                	jmp    416 <printf+0xe6>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 478:	83 ec 0c             	sub    $0xc,%esp
 47b:	6a 01                	push   $0x1
 47d:	b9 0a 00 00 00       	mov    $0xa,%ecx
 482:	eb 86                	jmp    40a <printf+0xda>
 484:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 488:	52                   	push   %edx
 489:	6a 01                	push   $0x1
 48b:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 48e:	e9 44 ff ff ff       	jmp    3d7 <printf+0xa7>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 493:	bf 09 06 00 00       	mov    $0x609,%edi
 498:	eb 9d                	jmp    437 <printf+0x107>
 49a:	66 90                	xchg   %ax,%ax

0000049c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 49c:	55                   	push   %ebp
 49d:	89 e5                	mov    %esp,%ebp
 49f:	57                   	push   %edi
 4a0:	56                   	push   %esi
 4a1:	53                   	push   %ebx
 4a2:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 4a5:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4a8:	a1 a4 08 00 00       	mov    0x8a4,%eax
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4b0:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4b2:	39 c8                	cmp    %ecx,%eax
 4b4:	73 2e                	jae    4e4 <free+0x48>
 4b6:	39 d1                	cmp    %edx,%ecx
 4b8:	72 04                	jb     4be <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4ba:	39 d0                	cmp    %edx,%eax
 4bc:	72 2e                	jb     4ec <free+0x50>
      break;
  if(bp + bp->s.size == p->s.ptr){
 4be:	8b 73 fc             	mov    -0x4(%ebx),%esi
 4c1:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 4c4:	39 d7                	cmp    %edx,%edi
 4c6:	74 28                	je     4f0 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 4c8:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 4cb:	8b 50 04             	mov    0x4(%eax),%edx
 4ce:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 4d1:	39 f1                	cmp    %esi,%ecx
 4d3:	74 32                	je     507 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 4d5:	89 08                	mov    %ecx,(%eax)
  freep = p;
 4d7:	a3 a4 08 00 00       	mov    %eax,0x8a4
}
 4dc:	5b                   	pop    %ebx
 4dd:	5e                   	pop    %esi
 4de:	5f                   	pop    %edi
 4df:	5d                   	pop    %ebp
 4e0:	c3                   	ret    
 4e1:	8d 76 00             	lea    0x0(%esi),%esi
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4e4:	39 d0                	cmp    %edx,%eax
 4e6:	72 04                	jb     4ec <free+0x50>
 4e8:	39 d1                	cmp    %edx,%ecx
 4ea:	72 d2                	jb     4be <free+0x22>
static Header base;
static Header *freep;

void
free(void *ap)
{
 4ec:	89 d0                	mov    %edx,%eax
 4ee:	eb c0                	jmp    4b0 <free+0x14>
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 4f0:	03 72 04             	add    0x4(%edx),%esi
 4f3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 4f6:	8b 10                	mov    (%eax),%edx
 4f8:	8b 12                	mov    (%edx),%edx
 4fa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 4fd:	8b 50 04             	mov    0x4(%eax),%edx
 500:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 503:	39 f1                	cmp    %esi,%ecx
 505:	75 ce                	jne    4d5 <free+0x39>
    p->s.size += bp->s.size;
 507:	03 53 fc             	add    -0x4(%ebx),%edx
 50a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 50d:	8b 53 f8             	mov    -0x8(%ebx),%edx
 510:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 512:	a3 a4 08 00 00       	mov    %eax,0x8a4
}
 517:	5b                   	pop    %ebx
 518:	5e                   	pop    %esi
 519:	5f                   	pop    %edi
 51a:	5d                   	pop    %ebp
 51b:	c3                   	ret    

0000051c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 51c:	55                   	push   %ebp
 51d:	89 e5                	mov    %esp,%ebp
 51f:	57                   	push   %edi
 520:	56                   	push   %esi
 521:	53                   	push   %ebx
 522:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 525:	8b 45 08             	mov    0x8(%ebp),%eax
 528:	8d 70 07             	lea    0x7(%eax),%esi
 52b:	c1 ee 03             	shr    $0x3,%esi
 52e:	46                   	inc    %esi
  if((prevp = freep) == 0){
 52f:	8b 15 a4 08 00 00    	mov    0x8a4,%edx
 535:	85 d2                	test   %edx,%edx
 537:	0f 84 99 00 00 00    	je     5d6 <malloc+0xba>
 53d:	8b 02                	mov    (%edx),%eax
 53f:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 542:	39 ce                	cmp    %ecx,%esi
 544:	76 62                	jbe    5a8 <malloc+0x8c>
 546:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 54d:	eb 0a                	jmp    559 <malloc+0x3d>
 54f:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 550:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 552:	8b 48 04             	mov    0x4(%eax),%ecx
 555:	39 ce                	cmp    %ecx,%esi
 557:	76 4f                	jbe    5a8 <malloc+0x8c>
 559:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 55b:	3b 05 a4 08 00 00    	cmp    0x8a4,%eax
 561:	75 ed                	jne    550 <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 563:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 569:	77 5d                	ja     5c8 <malloc+0xac>
 56b:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 570:	bf 00 10 00 00       	mov    $0x1000,%edi
  p = sbrk(nu * sizeof(Header));
 575:	83 ec 0c             	sub    $0xc,%esp
 578:	50                   	push   %eax
 579:	e8 19 fd ff ff       	call   297 <sbrk>
  if(p == (char*)-1)
 57e:	83 c4 10             	add    $0x10,%esp
 581:	83 f8 ff             	cmp    $0xffffffff,%eax
 584:	74 1c                	je     5a2 <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 586:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 589:	83 ec 0c             	sub    $0xc,%esp
 58c:	83 c0 08             	add    $0x8,%eax
 58f:	50                   	push   %eax
 590:	e8 07 ff ff ff       	call   49c <free>
  return freep;
 595:	8b 15 a4 08 00 00    	mov    0x8a4,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 59b:	83 c4 10             	add    $0x10,%esp
 59e:	85 d2                	test   %edx,%edx
 5a0:	75 ae                	jne    550 <malloc+0x34>
        return 0;
 5a2:	31 c0                	xor    %eax,%eax
 5a4:	eb 1a                	jmp    5c0 <malloc+0xa4>
 5a6:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 5a8:	39 ce                	cmp    %ecx,%esi
 5aa:	74 24                	je     5d0 <malloc+0xb4>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 5ac:	29 f1                	sub    %esi,%ecx
 5ae:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 5b1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 5b4:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
 5b7:	89 15 a4 08 00 00    	mov    %edx,0x8a4
      return (void*)(p + 1);
 5bd:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 5c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5c3:	5b                   	pop    %ebx
 5c4:	5e                   	pop    %esi
 5c5:	5f                   	pop    %edi
 5c6:	5d                   	pop    %ebp
 5c7:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 5c8:	89 d8                	mov    %ebx,%eax
 5ca:	89 f7                	mov    %esi,%edi
 5cc:	eb a7                	jmp    575 <malloc+0x59>
 5ce:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 5d0:	8b 08                	mov    (%eax),%ecx
 5d2:	89 0a                	mov    %ecx,(%edx)
 5d4:	eb e1                	jmp    5b7 <malloc+0x9b>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 5d6:	c7 05 a4 08 00 00 a8 	movl   $0x8a8,0x8a4
 5dd:	08 00 00 
 5e0:	c7 05 a8 08 00 00 a8 	movl   $0x8a8,0x8a8
 5e7:	08 00 00 
    base.s.size = 0;
 5ea:	c7 05 ac 08 00 00 00 	movl   $0x0,0x8ac
 5f1:	00 00 00 
 5f4:	b8 a8 08 00 00       	mov    $0x8a8,%eax
 5f9:	e9 48 ff ff ff       	jmp    546 <malloc+0x2a>
