
_ln:     file format elf32-i386


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
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	8b 59 04             	mov    0x4(%ecx),%ebx
  if(argc != 3){
  12:	83 39 03             	cmpl   $0x3,(%ecx)
  15:	74 14                	je     2b <main+0x2b>
    printf(2, "Usage: ln old new\n");
  17:	83 ec 08             	sub    $0x8,%esp
  1a:	68 f8 05 00 00       	push   $0x5f8
  1f:	6a 02                	push   $0x2
  21:	e8 02 03 00 00       	call   328 <printf>
    exit();
  26:	e8 dc 01 00 00       	call   207 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  2b:	50                   	push   %eax
  2c:	50                   	push   %eax
  2d:	ff 73 08             	pushl  0x8(%ebx)
  30:	ff 73 04             	pushl  0x4(%ebx)
  33:	e8 2f 02 00 00       	call   267 <link>
  38:	83 c4 10             	add    $0x10,%esp
  3b:	85 c0                	test   %eax,%eax
  3d:	78 05                	js     44 <main+0x44>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit();
  3f:	e8 c3 01 00 00       	call   207 <exit>
  if(argc != 3){
    printf(2, "Usage: ln old new\n");
    exit();
  }
  if(link(argv[1], argv[2]) < 0)
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  44:	ff 73 08             	pushl  0x8(%ebx)
  47:	ff 73 04             	pushl  0x4(%ebx)
  4a:	68 0b 06 00 00       	push   $0x60b
  4f:	6a 02                	push   $0x2
  51:	e8 d2 02 00 00       	call   328 <printf>
  56:	83 c4 10             	add    $0x10,%esp
  59:	eb e4                	jmp    3f <main+0x3f>
  5b:	90                   	nop

0000005c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  5c:	55                   	push   %ebp
  5d:	89 e5                	mov    %esp,%ebp
  5f:	53                   	push   %ebx
  60:	8b 45 08             	mov    0x8(%ebp),%eax
  63:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  66:	89 c2                	mov    %eax,%edx
  68:	42                   	inc    %edx
  69:	41                   	inc    %ecx
  6a:	8a 59 ff             	mov    -0x1(%ecx),%bl
  6d:	88 5a ff             	mov    %bl,-0x1(%edx)
  70:	84 db                	test   %bl,%bl
  72:	75 f4                	jne    68 <strcpy+0xc>
    ;
  return os;
}
  74:	5b                   	pop    %ebx
  75:	5d                   	pop    %ebp
  76:	c3                   	ret    
  77:	90                   	nop

00000078 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  78:	55                   	push   %ebp
  79:	89 e5                	mov    %esp,%ebp
  7b:	56                   	push   %esi
  7c:	53                   	push   %ebx
  7d:	8b 55 08             	mov    0x8(%ebp),%edx
  80:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  83:	0f b6 02             	movzbl (%edx),%eax
  86:	0f b6 0b             	movzbl (%ebx),%ecx
  89:	84 c0                	test   %al,%al
  8b:	75 14                	jne    a1 <strcmp+0x29>
  8d:	eb 1d                	jmp    ac <strcmp+0x34>
  8f:	90                   	nop
    p++, q++;
  90:	42                   	inc    %edx
  91:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  94:	0f b6 02             	movzbl (%edx),%eax
  97:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  9b:	84 c0                	test   %al,%al
  9d:	74 0d                	je     ac <strcmp+0x34>
  9f:	89 f3                	mov    %esi,%ebx
  a1:	38 c8                	cmp    %cl,%al
  a3:	74 eb                	je     90 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  a5:	29 c8                	sub    %ecx,%eax
}
  a7:	5b                   	pop    %ebx
  a8:	5e                   	pop    %esi
  a9:	5d                   	pop    %ebp
  aa:	c3                   	ret    
  ab:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  ac:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  ae:	29 c8                	sub    %ecx,%eax
}
  b0:	5b                   	pop    %ebx
  b1:	5e                   	pop    %esi
  b2:	5d                   	pop    %ebp
  b3:	c3                   	ret    

000000b4 <strlen>:

uint
strlen(char *s)
{
  b4:	55                   	push   %ebp
  b5:	89 e5                	mov    %esp,%ebp
  b7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  ba:	80 39 00             	cmpb   $0x0,(%ecx)
  bd:	74 10                	je     cf <strlen+0x1b>
  bf:	31 d2                	xor    %edx,%edx
  c1:	8d 76 00             	lea    0x0(%esi),%esi
  c4:	42                   	inc    %edx
  c5:	89 d0                	mov    %edx,%eax
  c7:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  cb:	75 f7                	jne    c4 <strlen+0x10>
    ;
  return n;
}
  cd:	5d                   	pop    %ebp
  ce:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
  cf:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  d1:	5d                   	pop    %ebp
  d2:	c3                   	ret    
  d3:	90                   	nop

000000d4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d4:	55                   	push   %ebp
  d5:	89 e5                	mov    %esp,%ebp
  d7:	57                   	push   %edi
  d8:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  db:	89 d7                	mov    %edx,%edi
  dd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  e3:	fc                   	cld    
  e4:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  e6:	89 d0                	mov    %edx,%eax
  e8:	5f                   	pop    %edi
  e9:	5d                   	pop    %ebp
  ea:	c3                   	ret    
  eb:	90                   	nop

000000ec <strchr>:

char*
strchr(const char *s, char c)
{
  ec:	55                   	push   %ebp
  ed:	89 e5                	mov    %esp,%ebp
  ef:	53                   	push   %ebx
  f0:	8b 45 08             	mov    0x8(%ebp),%eax
  f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
  f6:	8a 18                	mov    (%eax),%bl
  f8:	84 db                	test   %bl,%bl
  fa:	74 13                	je     10f <strchr+0x23>
  fc:	88 d1                	mov    %dl,%cl
    if(*s == c)
  fe:	38 d3                	cmp    %dl,%bl
 100:	75 06                	jne    108 <strchr+0x1c>
 102:	eb 0d                	jmp    111 <strchr+0x25>
 104:	38 ca                	cmp    %cl,%dl
 106:	74 09                	je     111 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 108:	40                   	inc    %eax
 109:	8a 10                	mov    (%eax),%dl
 10b:	84 d2                	test   %dl,%dl
 10d:	75 f5                	jne    104 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 10f:	31 c0                	xor    %eax,%eax
}
 111:	5b                   	pop    %ebx
 112:	5d                   	pop    %ebp
 113:	c3                   	ret    

00000114 <gets>:

char*
gets(char *buf, int max)
{
 114:	55                   	push   %ebp
 115:	89 e5                	mov    %esp,%ebp
 117:	57                   	push   %edi
 118:	56                   	push   %esi
 119:	53                   	push   %ebx
 11a:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 11d:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 11f:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 122:	eb 26                	jmp    14a <gets+0x36>
    cc = read(0, &c, 1);
 124:	50                   	push   %eax
 125:	6a 01                	push   $0x1
 127:	57                   	push   %edi
 128:	6a 00                	push   $0x0
 12a:	e8 f0 00 00 00       	call   21f <read>
    if(cc < 1)
 12f:	83 c4 10             	add    $0x10,%esp
 132:	85 c0                	test   %eax,%eax
 134:	7e 1c                	jle    152 <gets+0x3e>
      break;
    buf[i++] = c;
 136:	8a 45 e7             	mov    -0x19(%ebp),%al
 139:	8b 55 08             	mov    0x8(%ebp),%edx
 13c:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
 140:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 142:	3c 0a                	cmp    $0xa,%al
 144:	74 0c                	je     152 <gets+0x3e>
 146:	3c 0d                	cmp    $0xd,%al
 148:	74 08                	je     152 <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 14a:	8d 5e 01             	lea    0x1(%esi),%ebx
 14d:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 150:	7c d2                	jl     124 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 152:	8b 45 08             	mov    0x8(%ebp),%eax
 155:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 159:	8d 65 f4             	lea    -0xc(%ebp),%esp
 15c:	5b                   	pop    %ebx
 15d:	5e                   	pop    %esi
 15e:	5f                   	pop    %edi
 15f:	5d                   	pop    %ebp
 160:	c3                   	ret    
 161:	8d 76 00             	lea    0x0(%esi),%esi

00000164 <stat>:

int
stat(char *n, struct stat *st)
{
 164:	55                   	push   %ebp
 165:	89 e5                	mov    %esp,%ebp
 167:	56                   	push   %esi
 168:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 169:	83 ec 08             	sub    $0x8,%esp
 16c:	6a 00                	push   $0x0
 16e:	ff 75 08             	pushl  0x8(%ebp)
 171:	e8 d1 00 00 00       	call   247 <open>
 176:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 178:	83 c4 10             	add    $0x10,%esp
 17b:	85 c0                	test   %eax,%eax
 17d:	78 25                	js     1a4 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 17f:	83 ec 08             	sub    $0x8,%esp
 182:	ff 75 0c             	pushl  0xc(%ebp)
 185:	50                   	push   %eax
 186:	e8 d4 00 00 00       	call   25f <fstat>
 18b:	89 c6                	mov    %eax,%esi
  close(fd);
 18d:	89 1c 24             	mov    %ebx,(%esp)
 190:	e8 9a 00 00 00       	call   22f <close>
  return r;
 195:	83 c4 10             	add    $0x10,%esp
 198:	89 f0                	mov    %esi,%eax
}
 19a:	8d 65 f8             	lea    -0x8(%ebp),%esp
 19d:	5b                   	pop    %ebx
 19e:	5e                   	pop    %esi
 19f:	5d                   	pop    %ebp
 1a0:	c3                   	ret    
 1a1:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 1a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1a9:	eb ef                	jmp    19a <stat+0x36>
 1ab:	90                   	nop

000001ac <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1ac:	55                   	push   %ebp
 1ad:	89 e5                	mov    %esp,%ebp
 1af:	53                   	push   %ebx
 1b0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1b3:	0f be 11             	movsbl (%ecx),%edx
 1b6:	8d 42 d0             	lea    -0x30(%edx),%eax
 1b9:	3c 09                	cmp    $0x9,%al
 1bb:	b8 00 00 00 00       	mov    $0x0,%eax
 1c0:	77 15                	ja     1d7 <atoi+0x2b>
 1c2:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 1c4:	41                   	inc    %ecx
 1c5:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1c8:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1cc:	0f be 11             	movsbl (%ecx),%edx
 1cf:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1d2:	80 fb 09             	cmp    $0x9,%bl
 1d5:	76 ed                	jbe    1c4 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 1d7:	5b                   	pop    %ebx
 1d8:	5d                   	pop    %ebp
 1d9:	c3                   	ret    
 1da:	66 90                	xchg   %ax,%ax

000001dc <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 1dc:	55                   	push   %ebp
 1dd:	89 e5                	mov    %esp,%ebp
 1df:	56                   	push   %esi
 1e0:	53                   	push   %ebx
 1e1:	8b 45 08             	mov    0x8(%ebp),%eax
 1e4:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1e7:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1ea:	31 d2                	xor    %edx,%edx
 1ec:	85 f6                	test   %esi,%esi
 1ee:	7e 0b                	jle    1fb <memmove+0x1f>
    *dst++ = *src++;
 1f0:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 1f3:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 1f6:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1f7:	39 f2                	cmp    %esi,%edx
 1f9:	75 f5                	jne    1f0 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 1fb:	5b                   	pop    %ebx
 1fc:	5e                   	pop    %esi
 1fd:	5d                   	pop    %ebp
 1fe:	c3                   	ret    

000001ff <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 1ff:	b8 01 00 00 00       	mov    $0x1,%eax
 204:	cd 40                	int    $0x40
 206:	c3                   	ret    

00000207 <exit>:
SYSCALL(exit)
 207:	b8 02 00 00 00       	mov    $0x2,%eax
 20c:	cd 40                	int    $0x40
 20e:	c3                   	ret    

0000020f <wait>:
SYSCALL(wait)
 20f:	b8 03 00 00 00       	mov    $0x3,%eax
 214:	cd 40                	int    $0x40
 216:	c3                   	ret    

00000217 <pipe>:
SYSCALL(pipe)
 217:	b8 04 00 00 00       	mov    $0x4,%eax
 21c:	cd 40                	int    $0x40
 21e:	c3                   	ret    

0000021f <read>:
SYSCALL(read)
 21f:	b8 05 00 00 00       	mov    $0x5,%eax
 224:	cd 40                	int    $0x40
 226:	c3                   	ret    

00000227 <write>:
SYSCALL(write)
 227:	b8 10 00 00 00       	mov    $0x10,%eax
 22c:	cd 40                	int    $0x40
 22e:	c3                   	ret    

0000022f <close>:
SYSCALL(close)
 22f:	b8 15 00 00 00       	mov    $0x15,%eax
 234:	cd 40                	int    $0x40
 236:	c3                   	ret    

00000237 <kill>:
SYSCALL(kill)
 237:	b8 06 00 00 00       	mov    $0x6,%eax
 23c:	cd 40                	int    $0x40
 23e:	c3                   	ret    

0000023f <exec>:
SYSCALL(exec)
 23f:	b8 07 00 00 00       	mov    $0x7,%eax
 244:	cd 40                	int    $0x40
 246:	c3                   	ret    

00000247 <open>:
SYSCALL(open)
 247:	b8 0f 00 00 00       	mov    $0xf,%eax
 24c:	cd 40                	int    $0x40
 24e:	c3                   	ret    

0000024f <mknod>:
SYSCALL(mknod)
 24f:	b8 11 00 00 00       	mov    $0x11,%eax
 254:	cd 40                	int    $0x40
 256:	c3                   	ret    

00000257 <unlink>:
SYSCALL(unlink)
 257:	b8 12 00 00 00       	mov    $0x12,%eax
 25c:	cd 40                	int    $0x40
 25e:	c3                   	ret    

0000025f <fstat>:
SYSCALL(fstat)
 25f:	b8 08 00 00 00       	mov    $0x8,%eax
 264:	cd 40                	int    $0x40
 266:	c3                   	ret    

00000267 <link>:
SYSCALL(link)
 267:	b8 13 00 00 00       	mov    $0x13,%eax
 26c:	cd 40                	int    $0x40
 26e:	c3                   	ret    

0000026f <mkdir>:
SYSCALL(mkdir)
 26f:	b8 14 00 00 00       	mov    $0x14,%eax
 274:	cd 40                	int    $0x40
 276:	c3                   	ret    

00000277 <chdir>:
SYSCALL(chdir)
 277:	b8 09 00 00 00       	mov    $0x9,%eax
 27c:	cd 40                	int    $0x40
 27e:	c3                   	ret    

0000027f <dup>:
SYSCALL(dup)
 27f:	b8 0a 00 00 00       	mov    $0xa,%eax
 284:	cd 40                	int    $0x40
 286:	c3                   	ret    

00000287 <getpid>:
SYSCALL(getpid)
 287:	b8 0b 00 00 00       	mov    $0xb,%eax
 28c:	cd 40                	int    $0x40
 28e:	c3                   	ret    

0000028f <sbrk>:
SYSCALL(sbrk)
 28f:	b8 0c 00 00 00       	mov    $0xc,%eax
 294:	cd 40                	int    $0x40
 296:	c3                   	ret    

00000297 <sleep>:
SYSCALL(sleep)
 297:	b8 0d 00 00 00       	mov    $0xd,%eax
 29c:	cd 40                	int    $0x40
 29e:	c3                   	ret    

0000029f <uptime>:
SYSCALL(uptime)
 29f:	b8 0e 00 00 00       	mov    $0xe,%eax
 2a4:	cd 40                	int    $0x40
 2a6:	c3                   	ret    

000002a7 <mike>:
SYSCALL(mike)
 2a7:	b8 16 00 00 00       	mov    $0x16,%eax
 2ac:	cd 40                	int    $0x40
 2ae:	c3                   	ret    
 2af:	90                   	nop

000002b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	57                   	push   %edi
 2b4:	56                   	push   %esi
 2b5:	53                   	push   %ebx
 2b6:	83 ec 3c             	sub    $0x3c,%esp
 2b9:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 2bb:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2bd:	8b 5d 08             	mov    0x8(%ebp),%ebx
 2c0:	85 db                	test   %ebx,%ebx
 2c2:	74 04                	je     2c8 <printint+0x18>
 2c4:	85 d2                	test   %edx,%edx
 2c6:	78 53                	js     31b <printint+0x6b>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 2c8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 2cf:	31 db                	xor    %ebx,%ebx
 2d1:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 2d4:	43                   	inc    %ebx
 2d5:	31 d2                	xor    %edx,%edx
 2d7:	f7 f1                	div    %ecx
 2d9:	8a 92 28 06 00 00    	mov    0x628(%edx),%dl
 2df:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 2e2:	85 c0                	test   %eax,%eax
 2e4:	75 ee                	jne    2d4 <printint+0x24>
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 2e6:	89 d8                	mov    %ebx,%eax
  }while((x /= base) != 0);
  if(neg)
 2e8:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 2eb:	85 d2                	test   %edx,%edx
 2ed:	74 06                	je     2f5 <printint+0x45>
    buf[i++] = '-';
 2ef:	43                   	inc    %ebx
 2f0:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 2f5:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 2f9:	8d 76 00             	lea    0x0(%esi),%esi
 2fc:	8a 03                	mov    (%ebx),%al
 2fe:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 301:	50                   	push   %eax
 302:	6a 01                	push   $0x1
 304:	56                   	push   %esi
 305:	57                   	push   %edi
 306:	e8 1c ff ff ff       	call   227 <write>
 30b:	4b                   	dec    %ebx
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 30c:	83 c4 10             	add    $0x10,%esp
 30f:	39 f3                	cmp    %esi,%ebx
 311:	75 e9                	jne    2fc <printint+0x4c>
    putc(fd, buf[i]);
}
 313:	8d 65 f4             	lea    -0xc(%ebp),%esp
 316:	5b                   	pop    %ebx
 317:	5e                   	pop    %esi
 318:	5f                   	pop    %edi
 319:	5d                   	pop    %ebp
 31a:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 31b:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 31d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 324:	eb a9                	jmp    2cf <printint+0x1f>
 326:	66 90                	xchg   %ax,%ax

00000328 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 328:	55                   	push   %ebp
 329:	89 e5                	mov    %esp,%ebp
 32b:	57                   	push   %edi
 32c:	56                   	push   %esi
 32d:	53                   	push   %ebx
 32e:	83 ec 2c             	sub    $0x2c,%esp
 331:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 334:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 337:	8a 13                	mov    (%ebx),%dl
 339:	84 d2                	test   %dl,%dl
 33b:	0f 84 a3 00 00 00    	je     3e4 <printf+0xbc>
 341:	43                   	inc    %ebx
 342:	8d 45 10             	lea    0x10(%ebp),%eax
 345:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 348:	31 ff                	xor    %edi,%edi
 34a:	eb 24                	jmp    370 <printf+0x48>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 34c:	83 fa 25             	cmp    $0x25,%edx
 34f:	0f 84 97 00 00 00    	je     3ec <printf+0xc4>
        state = '%';
      } else {
        putc(fd, c);
 355:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 358:	50                   	push   %eax
 359:	6a 01                	push   $0x1
 35b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 35e:	50                   	push   %eax
 35f:	56                   	push   %esi
 360:	e8 c2 fe ff ff       	call   227 <write>
 365:	83 c4 10             	add    $0x10,%esp
 368:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 369:	8a 53 ff             	mov    -0x1(%ebx),%dl
 36c:	84 d2                	test   %dl,%dl
 36e:	74 74                	je     3e4 <printf+0xbc>
    c = fmt[i] & 0xff;
 370:	0f be c2             	movsbl %dl,%eax
 373:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
 376:	85 ff                	test   %edi,%edi
 378:	74 d2                	je     34c <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 37a:	83 ff 25             	cmp    $0x25,%edi
 37d:	75 e9                	jne    368 <printf+0x40>
      if(c == 'd'){
 37f:	83 fa 64             	cmp    $0x64,%edx
 382:	0f 84 e8 00 00 00    	je     470 <printf+0x148>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 388:	25 f7 00 00 00       	and    $0xf7,%eax
 38d:	83 f8 70             	cmp    $0x70,%eax
 390:	74 66                	je     3f8 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 392:	83 fa 73             	cmp    $0x73,%edx
 395:	0f 84 85 00 00 00    	je     420 <printf+0xf8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 39b:	83 fa 63             	cmp    $0x63,%edx
 39e:	0f 84 b5 00 00 00    	je     459 <printf+0x131>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3a4:	83 fa 25             	cmp    $0x25,%edx
 3a7:	0f 84 cf 00 00 00    	je     47c <printf+0x154>
 3ad:	89 55 d0             	mov    %edx,-0x30(%ebp)
 3b0:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3b4:	50                   	push   %eax
 3b5:	6a 01                	push   $0x1
 3b7:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3ba:	50                   	push   %eax
 3bb:	56                   	push   %esi
 3bc:	e8 66 fe ff ff       	call   227 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 3c1:	8b 55 d0             	mov    -0x30(%ebp),%edx
 3c4:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3c7:	83 c4 0c             	add    $0xc,%esp
 3ca:	6a 01                	push   $0x1
 3cc:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3cf:	50                   	push   %eax
 3d0:	56                   	push   %esi
 3d1:	e8 51 fe ff ff       	call   227 <write>
 3d6:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 3d9:	31 ff                	xor    %edi,%edi
 3db:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3dc:	8a 53 ff             	mov    -0x1(%ebx),%dl
 3df:	84 d2                	test   %dl,%dl
 3e1:	75 8d                	jne    370 <printf+0x48>
 3e3:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 3e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3e7:	5b                   	pop    %ebx
 3e8:	5e                   	pop    %esi
 3e9:	5f                   	pop    %edi
 3ea:	5d                   	pop    %ebp
 3eb:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 3ec:	bf 25 00 00 00       	mov    $0x25,%edi
 3f1:	e9 72 ff ff ff       	jmp    368 <printf+0x40>
 3f6:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 3f8:	83 ec 0c             	sub    $0xc,%esp
 3fb:	6a 00                	push   $0x0
 3fd:	b9 10 00 00 00       	mov    $0x10,%ecx
 402:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 405:	8b 17                	mov    (%edi),%edx
 407:	89 f0                	mov    %esi,%eax
 409:	e8 a2 fe ff ff       	call   2b0 <printint>
        ap++;
 40e:	89 f8                	mov    %edi,%eax
 410:	83 c0 04             	add    $0x4,%eax
 413:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 416:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 419:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 41b:	e9 48 ff ff ff       	jmp    368 <printf+0x40>
      } else if(c == 's'){
        s = (char*)*ap;
 420:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 423:	8b 38                	mov    (%eax),%edi
        ap++;
 425:	83 c0 04             	add    $0x4,%eax
 428:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 42b:	85 ff                	test   %edi,%edi
 42d:	74 5c                	je     48b <printf+0x163>
          s = "(null)";
        while(*s != 0){
 42f:	8a 07                	mov    (%edi),%al
 431:	84 c0                	test   %al,%al
 433:	74 1d                	je     452 <printf+0x12a>
 435:	8d 76 00             	lea    0x0(%esi),%esi
 438:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 43b:	50                   	push   %eax
 43c:	6a 01                	push   $0x1
 43e:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 441:	50                   	push   %eax
 442:	56                   	push   %esi
 443:	e8 df fd ff ff       	call   227 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 448:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 449:	8a 07                	mov    (%edi),%al
 44b:	83 c4 10             	add    $0x10,%esp
 44e:	84 c0                	test   %al,%al
 450:	75 e6                	jne    438 <printf+0x110>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 452:	31 ff                	xor    %edi,%edi
 454:	e9 0f ff ff ff       	jmp    368 <printf+0x40>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 459:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 45c:	8b 07                	mov    (%edi),%eax
 45e:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 461:	51                   	push   %ecx
 462:	6a 01                	push   $0x1
 464:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 467:	50                   	push   %eax
 468:	56                   	push   %esi
 469:	e8 b9 fd ff ff       	call   227 <write>
 46e:	eb 9e                	jmp    40e <printf+0xe6>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 470:	83 ec 0c             	sub    $0xc,%esp
 473:	6a 01                	push   $0x1
 475:	b9 0a 00 00 00       	mov    $0xa,%ecx
 47a:	eb 86                	jmp    402 <printf+0xda>
 47c:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 480:	52                   	push   %edx
 481:	6a 01                	push   $0x1
 483:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 486:	e9 44 ff ff ff       	jmp    3cf <printf+0xa7>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 48b:	bf 1f 06 00 00       	mov    $0x61f,%edi
 490:	eb 9d                	jmp    42f <printf+0x107>
 492:	66 90                	xchg   %ax,%ax

00000494 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 494:	55                   	push   %ebp
 495:	89 e5                	mov    %esp,%ebp
 497:	57                   	push   %edi
 498:	56                   	push   %esi
 499:	53                   	push   %ebx
 49a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 49d:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4a0:	a1 b4 08 00 00       	mov    0x8b4,%eax
 4a5:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4a8:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4aa:	39 c8                	cmp    %ecx,%eax
 4ac:	73 2e                	jae    4dc <free+0x48>
 4ae:	39 d1                	cmp    %edx,%ecx
 4b0:	72 04                	jb     4b6 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4b2:	39 d0                	cmp    %edx,%eax
 4b4:	72 2e                	jb     4e4 <free+0x50>
      break;
  if(bp + bp->s.size == p->s.ptr){
 4b6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 4b9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 4bc:	39 d7                	cmp    %edx,%edi
 4be:	74 28                	je     4e8 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 4c0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 4c3:	8b 50 04             	mov    0x4(%eax),%edx
 4c6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 4c9:	39 f1                	cmp    %esi,%ecx
 4cb:	74 32                	je     4ff <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 4cd:	89 08                	mov    %ecx,(%eax)
  freep = p;
 4cf:	a3 b4 08 00 00       	mov    %eax,0x8b4
}
 4d4:	5b                   	pop    %ebx
 4d5:	5e                   	pop    %esi
 4d6:	5f                   	pop    %edi
 4d7:	5d                   	pop    %ebp
 4d8:	c3                   	ret    
 4d9:	8d 76 00             	lea    0x0(%esi),%esi
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4dc:	39 d0                	cmp    %edx,%eax
 4de:	72 04                	jb     4e4 <free+0x50>
 4e0:	39 d1                	cmp    %edx,%ecx
 4e2:	72 d2                	jb     4b6 <free+0x22>
static Header base;
static Header *freep;

void
free(void *ap)
{
 4e4:	89 d0                	mov    %edx,%eax
 4e6:	eb c0                	jmp    4a8 <free+0x14>
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 4e8:	03 72 04             	add    0x4(%edx),%esi
 4eb:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 4ee:	8b 10                	mov    (%eax),%edx
 4f0:	8b 12                	mov    (%edx),%edx
 4f2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 4f5:	8b 50 04             	mov    0x4(%eax),%edx
 4f8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 4fb:	39 f1                	cmp    %esi,%ecx
 4fd:	75 ce                	jne    4cd <free+0x39>
    p->s.size += bp->s.size;
 4ff:	03 53 fc             	add    -0x4(%ebx),%edx
 502:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 505:	8b 53 f8             	mov    -0x8(%ebx),%edx
 508:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 50a:	a3 b4 08 00 00       	mov    %eax,0x8b4
}
 50f:	5b                   	pop    %ebx
 510:	5e                   	pop    %esi
 511:	5f                   	pop    %edi
 512:	5d                   	pop    %ebp
 513:	c3                   	ret    

00000514 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 514:	55                   	push   %ebp
 515:	89 e5                	mov    %esp,%ebp
 517:	57                   	push   %edi
 518:	56                   	push   %esi
 519:	53                   	push   %ebx
 51a:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 51d:	8b 45 08             	mov    0x8(%ebp),%eax
 520:	8d 70 07             	lea    0x7(%eax),%esi
 523:	c1 ee 03             	shr    $0x3,%esi
 526:	46                   	inc    %esi
  if((prevp = freep) == 0){
 527:	8b 15 b4 08 00 00    	mov    0x8b4,%edx
 52d:	85 d2                	test   %edx,%edx
 52f:	0f 84 99 00 00 00    	je     5ce <malloc+0xba>
 535:	8b 02                	mov    (%edx),%eax
 537:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 53a:	39 ce                	cmp    %ecx,%esi
 53c:	76 62                	jbe    5a0 <malloc+0x8c>
 53e:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 545:	eb 0a                	jmp    551 <malloc+0x3d>
 547:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 548:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 54a:	8b 48 04             	mov    0x4(%eax),%ecx
 54d:	39 ce                	cmp    %ecx,%esi
 54f:	76 4f                	jbe    5a0 <malloc+0x8c>
 551:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 553:	3b 05 b4 08 00 00    	cmp    0x8b4,%eax
 559:	75 ed                	jne    548 <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 55b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 561:	77 5d                	ja     5c0 <malloc+0xac>
 563:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 568:	bf 00 10 00 00       	mov    $0x1000,%edi
  p = sbrk(nu * sizeof(Header));
 56d:	83 ec 0c             	sub    $0xc,%esp
 570:	50                   	push   %eax
 571:	e8 19 fd ff ff       	call   28f <sbrk>
  if(p == (char*)-1)
 576:	83 c4 10             	add    $0x10,%esp
 579:	83 f8 ff             	cmp    $0xffffffff,%eax
 57c:	74 1c                	je     59a <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 57e:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 581:	83 ec 0c             	sub    $0xc,%esp
 584:	83 c0 08             	add    $0x8,%eax
 587:	50                   	push   %eax
 588:	e8 07 ff ff ff       	call   494 <free>
  return freep;
 58d:	8b 15 b4 08 00 00    	mov    0x8b4,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 593:	83 c4 10             	add    $0x10,%esp
 596:	85 d2                	test   %edx,%edx
 598:	75 ae                	jne    548 <malloc+0x34>
        return 0;
 59a:	31 c0                	xor    %eax,%eax
 59c:	eb 1a                	jmp    5b8 <malloc+0xa4>
 59e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 5a0:	39 ce                	cmp    %ecx,%esi
 5a2:	74 24                	je     5c8 <malloc+0xb4>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 5a4:	29 f1                	sub    %esi,%ecx
 5a6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 5a9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 5ac:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
 5af:	89 15 b4 08 00 00    	mov    %edx,0x8b4
      return (void*)(p + 1);
 5b5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 5b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5bb:	5b                   	pop    %ebx
 5bc:	5e                   	pop    %esi
 5bd:	5f                   	pop    %edi
 5be:	5d                   	pop    %ebp
 5bf:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 5c0:	89 d8                	mov    %ebx,%eax
 5c2:	89 f7                	mov    %esi,%edi
 5c4:	eb a7                	jmp    56d <malloc+0x59>
 5c6:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 5c8:	8b 08                	mov    (%eax),%ecx
 5ca:	89 0a                	mov    %ecx,(%edx)
 5cc:	eb e1                	jmp    5af <malloc+0x9b>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 5ce:	c7 05 b4 08 00 00 b8 	movl   $0x8b8,0x8b4
 5d5:	08 00 00 
 5d8:	c7 05 b8 08 00 00 b8 	movl   $0x8b8,0x8b8
 5df:	08 00 00 
    base.s.size = 0;
 5e2:	c7 05 bc 08 00 00 00 	movl   $0x0,0x8bc
 5e9:	00 00 00 
 5ec:	b8 b8 08 00 00       	mov    $0x8b8,%eax
 5f1:	e9 48 ff ff ff       	jmp    53e <malloc+0x2a>
