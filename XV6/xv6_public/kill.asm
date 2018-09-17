
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
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
  1c:	7e 26                	jle    44 <main+0x44>
  1e:	bb 01 00 00 00       	mov    $0x1,%ebx
  23:	90                   	nop
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  24:	83 ec 0c             	sub    $0xc,%esp
  27:	ff 34 9f             	pushl  (%edi,%ebx,4)
  2a:	e8 79 01 00 00       	call   1a8 <atoi>
  2f:	89 04 24             	mov    %eax,(%esp)
  32:	e8 fc 01 00 00       	call   233 <kill>

  if(argc < 2){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  37:	43                   	inc    %ebx
  38:	83 c4 10             	add    $0x10,%esp
  3b:	39 f3                	cmp    %esi,%ebx
  3d:	75 e5                	jne    24 <main+0x24>
    kill(atoi(argv[i]));
  exit();
  3f:	e8 bf 01 00 00       	call   203 <exit>
main(int argc, char **argv)
{
  int i;

  if(argc < 2){
    printf(2, "usage: kill pid...\n");
  44:	50                   	push   %eax
  45:	50                   	push   %eax
  46:	68 f4 05 00 00       	push   $0x5f4
  4b:	6a 02                	push   $0x2
  4d:	e8 d2 02 00 00       	call   324 <printf>
    exit();
  52:	e8 ac 01 00 00       	call   203 <exit>
  57:	90                   	nop

00000058 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  58:	55                   	push   %ebp
  59:	89 e5                	mov    %esp,%ebp
  5b:	53                   	push   %ebx
  5c:	8b 45 08             	mov    0x8(%ebp),%eax
  5f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  62:	89 c2                	mov    %eax,%edx
  64:	42                   	inc    %edx
  65:	41                   	inc    %ecx
  66:	8a 59 ff             	mov    -0x1(%ecx),%bl
  69:	88 5a ff             	mov    %bl,-0x1(%edx)
  6c:	84 db                	test   %bl,%bl
  6e:	75 f4                	jne    64 <strcpy+0xc>
    ;
  return os;
}
  70:	5b                   	pop    %ebx
  71:	5d                   	pop    %ebp
  72:	c3                   	ret    
  73:	90                   	nop

00000074 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  74:	55                   	push   %ebp
  75:	89 e5                	mov    %esp,%ebp
  77:	56                   	push   %esi
  78:	53                   	push   %ebx
  79:	8b 55 08             	mov    0x8(%ebp),%edx
  7c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  7f:	0f b6 02             	movzbl (%edx),%eax
  82:	0f b6 0b             	movzbl (%ebx),%ecx
  85:	84 c0                	test   %al,%al
  87:	75 14                	jne    9d <strcmp+0x29>
  89:	eb 1d                	jmp    a8 <strcmp+0x34>
  8b:	90                   	nop
    p++, q++;
  8c:	42                   	inc    %edx
  8d:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  90:	0f b6 02             	movzbl (%edx),%eax
  93:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  97:	84 c0                	test   %al,%al
  99:	74 0d                	je     a8 <strcmp+0x34>
  9b:	89 f3                	mov    %esi,%ebx
  9d:	38 c8                	cmp    %cl,%al
  9f:	74 eb                	je     8c <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  a1:	29 c8                	sub    %ecx,%eax
}
  a3:	5b                   	pop    %ebx
  a4:	5e                   	pop    %esi
  a5:	5d                   	pop    %ebp
  a6:	c3                   	ret    
  a7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  a8:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  aa:	29 c8                	sub    %ecx,%eax
}
  ac:	5b                   	pop    %ebx
  ad:	5e                   	pop    %esi
  ae:	5d                   	pop    %ebp
  af:	c3                   	ret    

000000b0 <strlen>:

uint
strlen(char *s)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  b6:	80 39 00             	cmpb   $0x0,(%ecx)
  b9:	74 10                	je     cb <strlen+0x1b>
  bb:	31 d2                	xor    %edx,%edx
  bd:	8d 76 00             	lea    0x0(%esi),%esi
  c0:	42                   	inc    %edx
  c1:	89 d0                	mov    %edx,%eax
  c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  c7:	75 f7                	jne    c0 <strlen+0x10>
    ;
  return n;
}
  c9:	5d                   	pop    %ebp
  ca:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
  cb:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  cd:	5d                   	pop    %ebp
  ce:	c3                   	ret    
  cf:	90                   	nop

000000d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	57                   	push   %edi
  d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  d7:	89 d7                	mov    %edx,%edi
  d9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  df:	fc                   	cld    
  e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  e2:	89 d0                	mov    %edx,%eax
  e4:	5f                   	pop    %edi
  e5:	5d                   	pop    %ebp
  e6:	c3                   	ret    
  e7:	90                   	nop

000000e8 <strchr>:

char*
strchr(const char *s, char c)
{
  e8:	55                   	push   %ebp
  e9:	89 e5                	mov    %esp,%ebp
  eb:	53                   	push   %ebx
  ec:	8b 45 08             	mov    0x8(%ebp),%eax
  ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
  f2:	8a 18                	mov    (%eax),%bl
  f4:	84 db                	test   %bl,%bl
  f6:	74 13                	je     10b <strchr+0x23>
  f8:	88 d1                	mov    %dl,%cl
    if(*s == c)
  fa:	38 d3                	cmp    %dl,%bl
  fc:	75 06                	jne    104 <strchr+0x1c>
  fe:	eb 0d                	jmp    10d <strchr+0x25>
 100:	38 ca                	cmp    %cl,%dl
 102:	74 09                	je     10d <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 104:	40                   	inc    %eax
 105:	8a 10                	mov    (%eax),%dl
 107:	84 d2                	test   %dl,%dl
 109:	75 f5                	jne    100 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 10b:	31 c0                	xor    %eax,%eax
}
 10d:	5b                   	pop    %ebx
 10e:	5d                   	pop    %ebp
 10f:	c3                   	ret    

00000110 <gets>:

char*
gets(char *buf, int max)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	56                   	push   %esi
 115:	53                   	push   %ebx
 116:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 119:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 11b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 11e:	eb 26                	jmp    146 <gets+0x36>
    cc = read(0, &c, 1);
 120:	50                   	push   %eax
 121:	6a 01                	push   $0x1
 123:	57                   	push   %edi
 124:	6a 00                	push   $0x0
 126:	e8 f0 00 00 00       	call   21b <read>
    if(cc < 1)
 12b:	83 c4 10             	add    $0x10,%esp
 12e:	85 c0                	test   %eax,%eax
 130:	7e 1c                	jle    14e <gets+0x3e>
      break;
    buf[i++] = c;
 132:	8a 45 e7             	mov    -0x19(%ebp),%al
 135:	8b 55 08             	mov    0x8(%ebp),%edx
 138:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
 13c:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 13e:	3c 0a                	cmp    $0xa,%al
 140:	74 0c                	je     14e <gets+0x3e>
 142:	3c 0d                	cmp    $0xd,%al
 144:	74 08                	je     14e <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 146:	8d 5e 01             	lea    0x1(%esi),%ebx
 149:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 14c:	7c d2                	jl     120 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 14e:	8b 45 08             	mov    0x8(%ebp),%eax
 151:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 155:	8d 65 f4             	lea    -0xc(%ebp),%esp
 158:	5b                   	pop    %ebx
 159:	5e                   	pop    %esi
 15a:	5f                   	pop    %edi
 15b:	5d                   	pop    %ebp
 15c:	c3                   	ret    
 15d:	8d 76 00             	lea    0x0(%esi),%esi

00000160 <stat>:

int
stat(char *n, struct stat *st)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	56                   	push   %esi
 164:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 165:	83 ec 08             	sub    $0x8,%esp
 168:	6a 00                	push   $0x0
 16a:	ff 75 08             	pushl  0x8(%ebp)
 16d:	e8 d1 00 00 00       	call   243 <open>
 172:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 174:	83 c4 10             	add    $0x10,%esp
 177:	85 c0                	test   %eax,%eax
 179:	78 25                	js     1a0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 17b:	83 ec 08             	sub    $0x8,%esp
 17e:	ff 75 0c             	pushl  0xc(%ebp)
 181:	50                   	push   %eax
 182:	e8 d4 00 00 00       	call   25b <fstat>
 187:	89 c6                	mov    %eax,%esi
  close(fd);
 189:	89 1c 24             	mov    %ebx,(%esp)
 18c:	e8 9a 00 00 00       	call   22b <close>
  return r;
 191:	83 c4 10             	add    $0x10,%esp
 194:	89 f0                	mov    %esi,%eax
}
 196:	8d 65 f8             	lea    -0x8(%ebp),%esp
 199:	5b                   	pop    %ebx
 19a:	5e                   	pop    %esi
 19b:	5d                   	pop    %ebp
 19c:	c3                   	ret    
 19d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 1a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1a5:	eb ef                	jmp    196 <stat+0x36>
 1a7:	90                   	nop

000001a8 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1a8:	55                   	push   %ebp
 1a9:	89 e5                	mov    %esp,%ebp
 1ab:	53                   	push   %ebx
 1ac:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1af:	0f be 11             	movsbl (%ecx),%edx
 1b2:	8d 42 d0             	lea    -0x30(%edx),%eax
 1b5:	3c 09                	cmp    $0x9,%al
 1b7:	b8 00 00 00 00       	mov    $0x0,%eax
 1bc:	77 15                	ja     1d3 <atoi+0x2b>
 1be:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 1c0:	41                   	inc    %ecx
 1c1:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1c4:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1c8:	0f be 11             	movsbl (%ecx),%edx
 1cb:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1ce:	80 fb 09             	cmp    $0x9,%bl
 1d1:	76 ed                	jbe    1c0 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 1d3:	5b                   	pop    %ebx
 1d4:	5d                   	pop    %ebp
 1d5:	c3                   	ret    
 1d6:	66 90                	xchg   %ax,%ax

000001d8 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 1d8:	55                   	push   %ebp
 1d9:	89 e5                	mov    %esp,%ebp
 1db:	56                   	push   %esi
 1dc:	53                   	push   %ebx
 1dd:	8b 45 08             	mov    0x8(%ebp),%eax
 1e0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1e3:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1e6:	31 d2                	xor    %edx,%edx
 1e8:	85 f6                	test   %esi,%esi
 1ea:	7e 0b                	jle    1f7 <memmove+0x1f>
    *dst++ = *src++;
 1ec:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 1ef:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 1f2:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1f3:	39 f2                	cmp    %esi,%edx
 1f5:	75 f5                	jne    1ec <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 1f7:	5b                   	pop    %ebx
 1f8:	5e                   	pop    %esi
 1f9:	5d                   	pop    %ebp
 1fa:	c3                   	ret    

000001fb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 1fb:	b8 01 00 00 00       	mov    $0x1,%eax
 200:	cd 40                	int    $0x40
 202:	c3                   	ret    

00000203 <exit>:
SYSCALL(exit)
 203:	b8 02 00 00 00       	mov    $0x2,%eax
 208:	cd 40                	int    $0x40
 20a:	c3                   	ret    

0000020b <wait>:
SYSCALL(wait)
 20b:	b8 03 00 00 00       	mov    $0x3,%eax
 210:	cd 40                	int    $0x40
 212:	c3                   	ret    

00000213 <pipe>:
SYSCALL(pipe)
 213:	b8 04 00 00 00       	mov    $0x4,%eax
 218:	cd 40                	int    $0x40
 21a:	c3                   	ret    

0000021b <read>:
SYSCALL(read)
 21b:	b8 05 00 00 00       	mov    $0x5,%eax
 220:	cd 40                	int    $0x40
 222:	c3                   	ret    

00000223 <write>:
SYSCALL(write)
 223:	b8 10 00 00 00       	mov    $0x10,%eax
 228:	cd 40                	int    $0x40
 22a:	c3                   	ret    

0000022b <close>:
SYSCALL(close)
 22b:	b8 15 00 00 00       	mov    $0x15,%eax
 230:	cd 40                	int    $0x40
 232:	c3                   	ret    

00000233 <kill>:
SYSCALL(kill)
 233:	b8 06 00 00 00       	mov    $0x6,%eax
 238:	cd 40                	int    $0x40
 23a:	c3                   	ret    

0000023b <exec>:
SYSCALL(exec)
 23b:	b8 07 00 00 00       	mov    $0x7,%eax
 240:	cd 40                	int    $0x40
 242:	c3                   	ret    

00000243 <open>:
SYSCALL(open)
 243:	b8 0f 00 00 00       	mov    $0xf,%eax
 248:	cd 40                	int    $0x40
 24a:	c3                   	ret    

0000024b <mknod>:
SYSCALL(mknod)
 24b:	b8 11 00 00 00       	mov    $0x11,%eax
 250:	cd 40                	int    $0x40
 252:	c3                   	ret    

00000253 <unlink>:
SYSCALL(unlink)
 253:	b8 12 00 00 00       	mov    $0x12,%eax
 258:	cd 40                	int    $0x40
 25a:	c3                   	ret    

0000025b <fstat>:
SYSCALL(fstat)
 25b:	b8 08 00 00 00       	mov    $0x8,%eax
 260:	cd 40                	int    $0x40
 262:	c3                   	ret    

00000263 <link>:
SYSCALL(link)
 263:	b8 13 00 00 00       	mov    $0x13,%eax
 268:	cd 40                	int    $0x40
 26a:	c3                   	ret    

0000026b <mkdir>:
SYSCALL(mkdir)
 26b:	b8 14 00 00 00       	mov    $0x14,%eax
 270:	cd 40                	int    $0x40
 272:	c3                   	ret    

00000273 <chdir>:
SYSCALL(chdir)
 273:	b8 09 00 00 00       	mov    $0x9,%eax
 278:	cd 40                	int    $0x40
 27a:	c3                   	ret    

0000027b <dup>:
SYSCALL(dup)
 27b:	b8 0a 00 00 00       	mov    $0xa,%eax
 280:	cd 40                	int    $0x40
 282:	c3                   	ret    

00000283 <getpid>:
SYSCALL(getpid)
 283:	b8 0b 00 00 00       	mov    $0xb,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret    

0000028b <sbrk>:
SYSCALL(sbrk)
 28b:	b8 0c 00 00 00       	mov    $0xc,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret    

00000293 <sleep>:
SYSCALL(sleep)
 293:	b8 0d 00 00 00       	mov    $0xd,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret    

0000029b <uptime>:
SYSCALL(uptime)
 29b:	b8 0e 00 00 00       	mov    $0xe,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret    

000002a3 <mike>:
SYSCALL(mike)
 2a3:	b8 16 00 00 00       	mov    $0x16,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret    
 2ab:	90                   	nop

000002ac <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2ac:	55                   	push   %ebp
 2ad:	89 e5                	mov    %esp,%ebp
 2af:	57                   	push   %edi
 2b0:	56                   	push   %esi
 2b1:	53                   	push   %ebx
 2b2:	83 ec 3c             	sub    $0x3c,%esp
 2b5:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 2b7:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
 2bc:	85 db                	test   %ebx,%ebx
 2be:	74 04                	je     2c4 <printint+0x18>
 2c0:	85 d2                	test   %edx,%edx
 2c2:	78 53                	js     317 <printint+0x6b>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 2c4:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 2cb:	31 db                	xor    %ebx,%ebx
 2cd:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 2d0:	43                   	inc    %ebx
 2d1:	31 d2                	xor    %edx,%edx
 2d3:	f7 f1                	div    %ecx
 2d5:	8a 92 10 06 00 00    	mov    0x610(%edx),%dl
 2db:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 2de:	85 c0                	test   %eax,%eax
 2e0:	75 ee                	jne    2d0 <printint+0x24>
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 2e2:	89 d8                	mov    %ebx,%eax
  }while((x /= base) != 0);
  if(neg)
 2e4:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 2e7:	85 d2                	test   %edx,%edx
 2e9:	74 06                	je     2f1 <printint+0x45>
    buf[i++] = '-';
 2eb:	43                   	inc    %ebx
 2ec:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 2f1:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 2f5:	8d 76 00             	lea    0x0(%esi),%esi
 2f8:	8a 03                	mov    (%ebx),%al
 2fa:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 2fd:	50                   	push   %eax
 2fe:	6a 01                	push   $0x1
 300:	56                   	push   %esi
 301:	57                   	push   %edi
 302:	e8 1c ff ff ff       	call   223 <write>
 307:	4b                   	dec    %ebx
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 308:	83 c4 10             	add    $0x10,%esp
 30b:	39 f3                	cmp    %esi,%ebx
 30d:	75 e9                	jne    2f8 <printint+0x4c>
    putc(fd, buf[i]);
}
 30f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 312:	5b                   	pop    %ebx
 313:	5e                   	pop    %esi
 314:	5f                   	pop    %edi
 315:	5d                   	pop    %ebp
 316:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 317:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 319:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 320:	eb a9                	jmp    2cb <printint+0x1f>
 322:	66 90                	xchg   %ax,%ax

00000324 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 324:	55                   	push   %ebp
 325:	89 e5                	mov    %esp,%ebp
 327:	57                   	push   %edi
 328:	56                   	push   %esi
 329:	53                   	push   %ebx
 32a:	83 ec 2c             	sub    $0x2c,%esp
 32d:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 330:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 333:	8a 13                	mov    (%ebx),%dl
 335:	84 d2                	test   %dl,%dl
 337:	0f 84 a3 00 00 00    	je     3e0 <printf+0xbc>
 33d:	43                   	inc    %ebx
 33e:	8d 45 10             	lea    0x10(%ebp),%eax
 341:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 344:	31 ff                	xor    %edi,%edi
 346:	eb 24                	jmp    36c <printf+0x48>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 348:	83 fa 25             	cmp    $0x25,%edx
 34b:	0f 84 97 00 00 00    	je     3e8 <printf+0xc4>
        state = '%';
      } else {
        putc(fd, c);
 351:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 354:	50                   	push   %eax
 355:	6a 01                	push   $0x1
 357:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 35a:	50                   	push   %eax
 35b:	56                   	push   %esi
 35c:	e8 c2 fe ff ff       	call   223 <write>
 361:	83 c4 10             	add    $0x10,%esp
 364:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 365:	8a 53 ff             	mov    -0x1(%ebx),%dl
 368:	84 d2                	test   %dl,%dl
 36a:	74 74                	je     3e0 <printf+0xbc>
    c = fmt[i] & 0xff;
 36c:	0f be c2             	movsbl %dl,%eax
 36f:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
 372:	85 ff                	test   %edi,%edi
 374:	74 d2                	je     348 <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 376:	83 ff 25             	cmp    $0x25,%edi
 379:	75 e9                	jne    364 <printf+0x40>
      if(c == 'd'){
 37b:	83 fa 64             	cmp    $0x64,%edx
 37e:	0f 84 e8 00 00 00    	je     46c <printf+0x148>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 384:	25 f7 00 00 00       	and    $0xf7,%eax
 389:	83 f8 70             	cmp    $0x70,%eax
 38c:	74 66                	je     3f4 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 38e:	83 fa 73             	cmp    $0x73,%edx
 391:	0f 84 85 00 00 00    	je     41c <printf+0xf8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 397:	83 fa 63             	cmp    $0x63,%edx
 39a:	0f 84 b5 00 00 00    	je     455 <printf+0x131>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3a0:	83 fa 25             	cmp    $0x25,%edx
 3a3:	0f 84 cf 00 00 00    	je     478 <printf+0x154>
 3a9:	89 55 d0             	mov    %edx,-0x30(%ebp)
 3ac:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3b0:	50                   	push   %eax
 3b1:	6a 01                	push   $0x1
 3b3:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3b6:	50                   	push   %eax
 3b7:	56                   	push   %esi
 3b8:	e8 66 fe ff ff       	call   223 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 3bd:	8b 55 d0             	mov    -0x30(%ebp),%edx
 3c0:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3c3:	83 c4 0c             	add    $0xc,%esp
 3c6:	6a 01                	push   $0x1
 3c8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3cb:	50                   	push   %eax
 3cc:	56                   	push   %esi
 3cd:	e8 51 fe ff ff       	call   223 <write>
 3d2:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 3d5:	31 ff                	xor    %edi,%edi
 3d7:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3d8:	8a 53 ff             	mov    -0x1(%ebx),%dl
 3db:	84 d2                	test   %dl,%dl
 3dd:	75 8d                	jne    36c <printf+0x48>
 3df:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 3e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3e3:	5b                   	pop    %ebx
 3e4:	5e                   	pop    %esi
 3e5:	5f                   	pop    %edi
 3e6:	5d                   	pop    %ebp
 3e7:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 3e8:	bf 25 00 00 00       	mov    $0x25,%edi
 3ed:	e9 72 ff ff ff       	jmp    364 <printf+0x40>
 3f2:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 3f4:	83 ec 0c             	sub    $0xc,%esp
 3f7:	6a 00                	push   $0x0
 3f9:	b9 10 00 00 00       	mov    $0x10,%ecx
 3fe:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 401:	8b 17                	mov    (%edi),%edx
 403:	89 f0                	mov    %esi,%eax
 405:	e8 a2 fe ff ff       	call   2ac <printint>
        ap++;
 40a:	89 f8                	mov    %edi,%eax
 40c:	83 c0 04             	add    $0x4,%eax
 40f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 412:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 415:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 417:	e9 48 ff ff ff       	jmp    364 <printf+0x40>
      } else if(c == 's'){
        s = (char*)*ap;
 41c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 41f:	8b 38                	mov    (%eax),%edi
        ap++;
 421:	83 c0 04             	add    $0x4,%eax
 424:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 427:	85 ff                	test   %edi,%edi
 429:	74 5c                	je     487 <printf+0x163>
          s = "(null)";
        while(*s != 0){
 42b:	8a 07                	mov    (%edi),%al
 42d:	84 c0                	test   %al,%al
 42f:	74 1d                	je     44e <printf+0x12a>
 431:	8d 76 00             	lea    0x0(%esi),%esi
 434:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 437:	50                   	push   %eax
 438:	6a 01                	push   $0x1
 43a:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 43d:	50                   	push   %eax
 43e:	56                   	push   %esi
 43f:	e8 df fd ff ff       	call   223 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 444:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 445:	8a 07                	mov    (%edi),%al
 447:	83 c4 10             	add    $0x10,%esp
 44a:	84 c0                	test   %al,%al
 44c:	75 e6                	jne    434 <printf+0x110>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 44e:	31 ff                	xor    %edi,%edi
 450:	e9 0f ff ff ff       	jmp    364 <printf+0x40>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 455:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 458:	8b 07                	mov    (%edi),%eax
 45a:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 45d:	51                   	push   %ecx
 45e:	6a 01                	push   $0x1
 460:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 463:	50                   	push   %eax
 464:	56                   	push   %esi
 465:	e8 b9 fd ff ff       	call   223 <write>
 46a:	eb 9e                	jmp    40a <printf+0xe6>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 46c:	83 ec 0c             	sub    $0xc,%esp
 46f:	6a 01                	push   $0x1
 471:	b9 0a 00 00 00       	mov    $0xa,%ecx
 476:	eb 86                	jmp    3fe <printf+0xda>
 478:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 47c:	52                   	push   %edx
 47d:	6a 01                	push   $0x1
 47f:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 482:	e9 44 ff ff ff       	jmp    3cb <printf+0xa7>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 487:	bf 08 06 00 00       	mov    $0x608,%edi
 48c:	eb 9d                	jmp    42b <printf+0x107>
 48e:	66 90                	xchg   %ax,%ax

00000490 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
 495:	53                   	push   %ebx
 496:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 499:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 49c:	a1 a4 08 00 00       	mov    0x8a4,%eax
 4a1:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4a4:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4a6:	39 c8                	cmp    %ecx,%eax
 4a8:	73 2e                	jae    4d8 <free+0x48>
 4aa:	39 d1                	cmp    %edx,%ecx
 4ac:	72 04                	jb     4b2 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4ae:	39 d0                	cmp    %edx,%eax
 4b0:	72 2e                	jb     4e0 <free+0x50>
      break;
  if(bp + bp->s.size == p->s.ptr){
 4b2:	8b 73 fc             	mov    -0x4(%ebx),%esi
 4b5:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 4b8:	39 d7                	cmp    %edx,%edi
 4ba:	74 28                	je     4e4 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 4bc:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 4bf:	8b 50 04             	mov    0x4(%eax),%edx
 4c2:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 4c5:	39 f1                	cmp    %esi,%ecx
 4c7:	74 32                	je     4fb <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 4c9:	89 08                	mov    %ecx,(%eax)
  freep = p;
 4cb:	a3 a4 08 00 00       	mov    %eax,0x8a4
}
 4d0:	5b                   	pop    %ebx
 4d1:	5e                   	pop    %esi
 4d2:	5f                   	pop    %edi
 4d3:	5d                   	pop    %ebp
 4d4:	c3                   	ret    
 4d5:	8d 76 00             	lea    0x0(%esi),%esi
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4d8:	39 d0                	cmp    %edx,%eax
 4da:	72 04                	jb     4e0 <free+0x50>
 4dc:	39 d1                	cmp    %edx,%ecx
 4de:	72 d2                	jb     4b2 <free+0x22>
static Header base;
static Header *freep;

void
free(void *ap)
{
 4e0:	89 d0                	mov    %edx,%eax
 4e2:	eb c0                	jmp    4a4 <free+0x14>
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 4e4:	03 72 04             	add    0x4(%edx),%esi
 4e7:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 4ea:	8b 10                	mov    (%eax),%edx
 4ec:	8b 12                	mov    (%edx),%edx
 4ee:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 4f1:	8b 50 04             	mov    0x4(%eax),%edx
 4f4:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 4f7:	39 f1                	cmp    %esi,%ecx
 4f9:	75 ce                	jne    4c9 <free+0x39>
    p->s.size += bp->s.size;
 4fb:	03 53 fc             	add    -0x4(%ebx),%edx
 4fe:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 501:	8b 53 f8             	mov    -0x8(%ebx),%edx
 504:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 506:	a3 a4 08 00 00       	mov    %eax,0x8a4
}
 50b:	5b                   	pop    %ebx
 50c:	5e                   	pop    %esi
 50d:	5f                   	pop    %edi
 50e:	5d                   	pop    %ebp
 50f:	c3                   	ret    

00000510 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	57                   	push   %edi
 514:	56                   	push   %esi
 515:	53                   	push   %ebx
 516:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 519:	8b 45 08             	mov    0x8(%ebp),%eax
 51c:	8d 70 07             	lea    0x7(%eax),%esi
 51f:	c1 ee 03             	shr    $0x3,%esi
 522:	46                   	inc    %esi
  if((prevp = freep) == 0){
 523:	8b 15 a4 08 00 00    	mov    0x8a4,%edx
 529:	85 d2                	test   %edx,%edx
 52b:	0f 84 99 00 00 00    	je     5ca <malloc+0xba>
 531:	8b 02                	mov    (%edx),%eax
 533:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 536:	39 ce                	cmp    %ecx,%esi
 538:	76 62                	jbe    59c <malloc+0x8c>
 53a:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 541:	eb 0a                	jmp    54d <malloc+0x3d>
 543:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 544:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 546:	8b 48 04             	mov    0x4(%eax),%ecx
 549:	39 ce                	cmp    %ecx,%esi
 54b:	76 4f                	jbe    59c <malloc+0x8c>
 54d:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 54f:	3b 05 a4 08 00 00    	cmp    0x8a4,%eax
 555:	75 ed                	jne    544 <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 557:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 55d:	77 5d                	ja     5bc <malloc+0xac>
 55f:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 564:	bf 00 10 00 00       	mov    $0x1000,%edi
  p = sbrk(nu * sizeof(Header));
 569:	83 ec 0c             	sub    $0xc,%esp
 56c:	50                   	push   %eax
 56d:	e8 19 fd ff ff       	call   28b <sbrk>
  if(p == (char*)-1)
 572:	83 c4 10             	add    $0x10,%esp
 575:	83 f8 ff             	cmp    $0xffffffff,%eax
 578:	74 1c                	je     596 <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 57a:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 57d:	83 ec 0c             	sub    $0xc,%esp
 580:	83 c0 08             	add    $0x8,%eax
 583:	50                   	push   %eax
 584:	e8 07 ff ff ff       	call   490 <free>
  return freep;
 589:	8b 15 a4 08 00 00    	mov    0x8a4,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 58f:	83 c4 10             	add    $0x10,%esp
 592:	85 d2                	test   %edx,%edx
 594:	75 ae                	jne    544 <malloc+0x34>
        return 0;
 596:	31 c0                	xor    %eax,%eax
 598:	eb 1a                	jmp    5b4 <malloc+0xa4>
 59a:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 59c:	39 ce                	cmp    %ecx,%esi
 59e:	74 24                	je     5c4 <malloc+0xb4>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 5a0:	29 f1                	sub    %esi,%ecx
 5a2:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 5a5:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 5a8:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
 5ab:	89 15 a4 08 00 00    	mov    %edx,0x8a4
      return (void*)(p + 1);
 5b1:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 5b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5b7:	5b                   	pop    %ebx
 5b8:	5e                   	pop    %esi
 5b9:	5f                   	pop    %edi
 5ba:	5d                   	pop    %ebp
 5bb:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 5bc:	89 d8                	mov    %ebx,%eax
 5be:	89 f7                	mov    %esi,%edi
 5c0:	eb a7                	jmp    569 <malloc+0x59>
 5c2:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 5c4:	8b 08                	mov    (%eax),%ecx
 5c6:	89 0a                	mov    %ecx,(%edx)
 5c8:	eb e1                	jmp    5ab <malloc+0x9b>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 5ca:	c7 05 a4 08 00 00 a8 	movl   $0x8a8,0x8a4
 5d1:	08 00 00 
 5d4:	c7 05 a8 08 00 00 a8 	movl   $0x8a8,0x8a8
 5db:	08 00 00 
    base.s.size = 0;
 5de:	c7 05 ac 08 00 00 00 	movl   $0x0,0x8ac
 5e5:	00 00 00 
 5e8:	b8 a8 08 00 00       	mov    $0x8a8,%eax
 5ed:	e9 48 ff ff ff       	jmp    53a <malloc+0x2a>
