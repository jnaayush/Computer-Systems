
_rm:     file format elf32-i386


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
  16:	8b 59 04             	mov    0x4(%ecx),%ebx
  int i;

  if(argc < 2){
  19:	83 fe 01             	cmp    $0x1,%esi
  1c:	7e 3c                	jle    5a <main+0x5a>
  1e:	83 c3 04             	add    $0x4,%ebx
  21:	bf 01 00 00 00       	mov    $0x1,%edi
  26:	66 90                	xchg   %ax,%ax
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
  28:	83 ec 0c             	sub    $0xc,%esp
  2b:	ff 33                	pushl  (%ebx)
  2d:	e8 39 02 00 00       	call   26b <unlink>
  32:	83 c4 10             	add    $0x10,%esp
  35:	85 c0                	test   %eax,%eax
  37:	78 0d                	js     46 <main+0x46>
  if(argc < 2){
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  39:	47                   	inc    %edi
  3a:	83 c3 04             	add    $0x4,%ebx
  3d:	39 f7                	cmp    %esi,%edi
  3f:	75 e7                	jne    28 <main+0x28>
      printf(2, "rm: %s failed to delete\n", argv[i]);
      break;
    }
  }

  exit();
  41:	e8 d5 01 00 00       	call   21b <exit>
    exit();
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
      printf(2, "rm: %s failed to delete\n", argv[i]);
  46:	50                   	push   %eax
  47:	ff 33                	pushl  (%ebx)
  49:	68 20 06 00 00       	push   $0x620
  4e:	6a 02                	push   $0x2
  50:	e8 e7 02 00 00       	call   33c <printf>
      break;
  55:	83 c4 10             	add    $0x10,%esp
  58:	eb e7                	jmp    41 <main+0x41>
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    printf(2, "Usage: rm files...\n");
  5a:	52                   	push   %edx
  5b:	52                   	push   %edx
  5c:	68 0c 06 00 00       	push   $0x60c
  61:	6a 02                	push   $0x2
  63:	e8 d4 02 00 00       	call   33c <printf>
    exit();
  68:	e8 ae 01 00 00       	call   21b <exit>
  6d:	66 90                	xchg   %ax,%ax
  6f:	90                   	nop

00000070 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	53                   	push   %ebx
  74:	8b 45 08             	mov    0x8(%ebp),%eax
  77:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  7a:	89 c2                	mov    %eax,%edx
  7c:	42                   	inc    %edx
  7d:	41                   	inc    %ecx
  7e:	8a 59 ff             	mov    -0x1(%ecx),%bl
  81:	88 5a ff             	mov    %bl,-0x1(%edx)
  84:	84 db                	test   %bl,%bl
  86:	75 f4                	jne    7c <strcpy+0xc>
    ;
  return os;
}
  88:	5b                   	pop    %ebx
  89:	5d                   	pop    %ebp
  8a:	c3                   	ret    
  8b:	90                   	nop

0000008c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8c:	55                   	push   %ebp
  8d:	89 e5                	mov    %esp,%ebp
  8f:	56                   	push   %esi
  90:	53                   	push   %ebx
  91:	8b 55 08             	mov    0x8(%ebp),%edx
  94:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  97:	0f b6 02             	movzbl (%edx),%eax
  9a:	0f b6 0b             	movzbl (%ebx),%ecx
  9d:	84 c0                	test   %al,%al
  9f:	75 14                	jne    b5 <strcmp+0x29>
  a1:	eb 1d                	jmp    c0 <strcmp+0x34>
  a3:	90                   	nop
    p++, q++;
  a4:	42                   	inc    %edx
  a5:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  a8:	0f b6 02             	movzbl (%edx),%eax
  ab:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  af:	84 c0                	test   %al,%al
  b1:	74 0d                	je     c0 <strcmp+0x34>
  b3:	89 f3                	mov    %esi,%ebx
  b5:	38 c8                	cmp    %cl,%al
  b7:	74 eb                	je     a4 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  b9:	29 c8                	sub    %ecx,%eax
}
  bb:	5b                   	pop    %ebx
  bc:	5e                   	pop    %esi
  bd:	5d                   	pop    %ebp
  be:	c3                   	ret    
  bf:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  c0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  c2:	29 c8                	sub    %ecx,%eax
}
  c4:	5b                   	pop    %ebx
  c5:	5e                   	pop    %esi
  c6:	5d                   	pop    %ebp
  c7:	c3                   	ret    

000000c8 <strlen>:

uint
strlen(char *s)
{
  c8:	55                   	push   %ebp
  c9:	89 e5                	mov    %esp,%ebp
  cb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  ce:	80 39 00             	cmpb   $0x0,(%ecx)
  d1:	74 10                	je     e3 <strlen+0x1b>
  d3:	31 d2                	xor    %edx,%edx
  d5:	8d 76 00             	lea    0x0(%esi),%esi
  d8:	42                   	inc    %edx
  d9:	89 d0                	mov    %edx,%eax
  db:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  df:	75 f7                	jne    d8 <strlen+0x10>
    ;
  return n;
}
  e1:	5d                   	pop    %ebp
  e2:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
  e3:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  e5:	5d                   	pop    %ebp
  e6:	c3                   	ret    
  e7:	90                   	nop

000000e8 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e8:	55                   	push   %ebp
  e9:	89 e5                	mov    %esp,%ebp
  eb:	57                   	push   %edi
  ec:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  ef:	89 d7                	mov    %edx,%edi
  f1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  f7:	fc                   	cld    
  f8:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  fa:	89 d0                	mov    %edx,%eax
  fc:	5f                   	pop    %edi
  fd:	5d                   	pop    %ebp
  fe:	c3                   	ret    
  ff:	90                   	nop

00000100 <strchr>:

char*
strchr(const char *s, char c)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	53                   	push   %ebx
 104:	8b 45 08             	mov    0x8(%ebp),%eax
 107:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 10a:	8a 18                	mov    (%eax),%bl
 10c:	84 db                	test   %bl,%bl
 10e:	74 13                	je     123 <strchr+0x23>
 110:	88 d1                	mov    %dl,%cl
    if(*s == c)
 112:	38 d3                	cmp    %dl,%bl
 114:	75 06                	jne    11c <strchr+0x1c>
 116:	eb 0d                	jmp    125 <strchr+0x25>
 118:	38 ca                	cmp    %cl,%dl
 11a:	74 09                	je     125 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 11c:	40                   	inc    %eax
 11d:	8a 10                	mov    (%eax),%dl
 11f:	84 d2                	test   %dl,%dl
 121:	75 f5                	jne    118 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 123:	31 c0                	xor    %eax,%eax
}
 125:	5b                   	pop    %ebx
 126:	5d                   	pop    %ebp
 127:	c3                   	ret    

00000128 <gets>:

char*
gets(char *buf, int max)
{
 128:	55                   	push   %ebp
 129:	89 e5                	mov    %esp,%ebp
 12b:	57                   	push   %edi
 12c:	56                   	push   %esi
 12d:	53                   	push   %ebx
 12e:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 131:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 133:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 136:	eb 26                	jmp    15e <gets+0x36>
    cc = read(0, &c, 1);
 138:	50                   	push   %eax
 139:	6a 01                	push   $0x1
 13b:	57                   	push   %edi
 13c:	6a 00                	push   $0x0
 13e:	e8 f0 00 00 00       	call   233 <read>
    if(cc < 1)
 143:	83 c4 10             	add    $0x10,%esp
 146:	85 c0                	test   %eax,%eax
 148:	7e 1c                	jle    166 <gets+0x3e>
      break;
    buf[i++] = c;
 14a:	8a 45 e7             	mov    -0x19(%ebp),%al
 14d:	8b 55 08             	mov    0x8(%ebp),%edx
 150:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
 154:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 156:	3c 0a                	cmp    $0xa,%al
 158:	74 0c                	je     166 <gets+0x3e>
 15a:	3c 0d                	cmp    $0xd,%al
 15c:	74 08                	je     166 <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 15e:	8d 5e 01             	lea    0x1(%esi),%ebx
 161:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 164:	7c d2                	jl     138 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 166:	8b 45 08             	mov    0x8(%ebp),%eax
 169:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 16d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 170:	5b                   	pop    %ebx
 171:	5e                   	pop    %esi
 172:	5f                   	pop    %edi
 173:	5d                   	pop    %ebp
 174:	c3                   	ret    
 175:	8d 76 00             	lea    0x0(%esi),%esi

00000178 <stat>:

int
stat(char *n, struct stat *st)
{
 178:	55                   	push   %ebp
 179:	89 e5                	mov    %esp,%ebp
 17b:	56                   	push   %esi
 17c:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 17d:	83 ec 08             	sub    $0x8,%esp
 180:	6a 00                	push   $0x0
 182:	ff 75 08             	pushl  0x8(%ebp)
 185:	e8 d1 00 00 00       	call   25b <open>
 18a:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 18c:	83 c4 10             	add    $0x10,%esp
 18f:	85 c0                	test   %eax,%eax
 191:	78 25                	js     1b8 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 193:	83 ec 08             	sub    $0x8,%esp
 196:	ff 75 0c             	pushl  0xc(%ebp)
 199:	50                   	push   %eax
 19a:	e8 d4 00 00 00       	call   273 <fstat>
 19f:	89 c6                	mov    %eax,%esi
  close(fd);
 1a1:	89 1c 24             	mov    %ebx,(%esp)
 1a4:	e8 9a 00 00 00       	call   243 <close>
  return r;
 1a9:	83 c4 10             	add    $0x10,%esp
 1ac:	89 f0                	mov    %esi,%eax
}
 1ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1b1:	5b                   	pop    %ebx
 1b2:	5e                   	pop    %esi
 1b3:	5d                   	pop    %ebp
 1b4:	c3                   	ret    
 1b5:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 1b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1bd:	eb ef                	jmp    1ae <stat+0x36>
 1bf:	90                   	nop

000001c0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	53                   	push   %ebx
 1c4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1c7:	0f be 11             	movsbl (%ecx),%edx
 1ca:	8d 42 d0             	lea    -0x30(%edx),%eax
 1cd:	3c 09                	cmp    $0x9,%al
 1cf:	b8 00 00 00 00       	mov    $0x0,%eax
 1d4:	77 15                	ja     1eb <atoi+0x2b>
 1d6:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 1d8:	41                   	inc    %ecx
 1d9:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1dc:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1e0:	0f be 11             	movsbl (%ecx),%edx
 1e3:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1e6:	80 fb 09             	cmp    $0x9,%bl
 1e9:	76 ed                	jbe    1d8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 1eb:	5b                   	pop    %ebx
 1ec:	5d                   	pop    %ebp
 1ed:	c3                   	ret    
 1ee:	66 90                	xchg   %ax,%ax

000001f0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	56                   	push   %esi
 1f4:	53                   	push   %ebx
 1f5:	8b 45 08             	mov    0x8(%ebp),%eax
 1f8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1fb:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1fe:	31 d2                	xor    %edx,%edx
 200:	85 f6                	test   %esi,%esi
 202:	7e 0b                	jle    20f <memmove+0x1f>
    *dst++ = *src++;
 204:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 207:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 20a:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 20b:	39 f2                	cmp    %esi,%edx
 20d:	75 f5                	jne    204 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 20f:	5b                   	pop    %ebx
 210:	5e                   	pop    %esi
 211:	5d                   	pop    %ebp
 212:	c3                   	ret    

00000213 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 213:	b8 01 00 00 00       	mov    $0x1,%eax
 218:	cd 40                	int    $0x40
 21a:	c3                   	ret    

0000021b <exit>:
SYSCALL(exit)
 21b:	b8 02 00 00 00       	mov    $0x2,%eax
 220:	cd 40                	int    $0x40
 222:	c3                   	ret    

00000223 <wait>:
SYSCALL(wait)
 223:	b8 03 00 00 00       	mov    $0x3,%eax
 228:	cd 40                	int    $0x40
 22a:	c3                   	ret    

0000022b <pipe>:
SYSCALL(pipe)
 22b:	b8 04 00 00 00       	mov    $0x4,%eax
 230:	cd 40                	int    $0x40
 232:	c3                   	ret    

00000233 <read>:
SYSCALL(read)
 233:	b8 05 00 00 00       	mov    $0x5,%eax
 238:	cd 40                	int    $0x40
 23a:	c3                   	ret    

0000023b <write>:
SYSCALL(write)
 23b:	b8 10 00 00 00       	mov    $0x10,%eax
 240:	cd 40                	int    $0x40
 242:	c3                   	ret    

00000243 <close>:
SYSCALL(close)
 243:	b8 15 00 00 00       	mov    $0x15,%eax
 248:	cd 40                	int    $0x40
 24a:	c3                   	ret    

0000024b <kill>:
SYSCALL(kill)
 24b:	b8 06 00 00 00       	mov    $0x6,%eax
 250:	cd 40                	int    $0x40
 252:	c3                   	ret    

00000253 <exec>:
SYSCALL(exec)
 253:	b8 07 00 00 00       	mov    $0x7,%eax
 258:	cd 40                	int    $0x40
 25a:	c3                   	ret    

0000025b <open>:
SYSCALL(open)
 25b:	b8 0f 00 00 00       	mov    $0xf,%eax
 260:	cd 40                	int    $0x40
 262:	c3                   	ret    

00000263 <mknod>:
SYSCALL(mknod)
 263:	b8 11 00 00 00       	mov    $0x11,%eax
 268:	cd 40                	int    $0x40
 26a:	c3                   	ret    

0000026b <unlink>:
SYSCALL(unlink)
 26b:	b8 12 00 00 00       	mov    $0x12,%eax
 270:	cd 40                	int    $0x40
 272:	c3                   	ret    

00000273 <fstat>:
SYSCALL(fstat)
 273:	b8 08 00 00 00       	mov    $0x8,%eax
 278:	cd 40                	int    $0x40
 27a:	c3                   	ret    

0000027b <link>:
SYSCALL(link)
 27b:	b8 13 00 00 00       	mov    $0x13,%eax
 280:	cd 40                	int    $0x40
 282:	c3                   	ret    

00000283 <mkdir>:
SYSCALL(mkdir)
 283:	b8 14 00 00 00       	mov    $0x14,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret    

0000028b <chdir>:
SYSCALL(chdir)
 28b:	b8 09 00 00 00       	mov    $0x9,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret    

00000293 <dup>:
SYSCALL(dup)
 293:	b8 0a 00 00 00       	mov    $0xa,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret    

0000029b <getpid>:
SYSCALL(getpid)
 29b:	b8 0b 00 00 00       	mov    $0xb,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret    

000002a3 <sbrk>:
SYSCALL(sbrk)
 2a3:	b8 0c 00 00 00       	mov    $0xc,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret    

000002ab <sleep>:
SYSCALL(sleep)
 2ab:	b8 0d 00 00 00       	mov    $0xd,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret    

000002b3 <uptime>:
SYSCALL(uptime)
 2b3:	b8 0e 00 00 00       	mov    $0xe,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret    

000002bb <mike>:
SYSCALL(mike)
 2bb:	b8 16 00 00 00       	mov    $0x16,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    
 2c3:	90                   	nop

000002c4 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2c4:	55                   	push   %ebp
 2c5:	89 e5                	mov    %esp,%ebp
 2c7:	57                   	push   %edi
 2c8:	56                   	push   %esi
 2c9:	53                   	push   %ebx
 2ca:	83 ec 3c             	sub    $0x3c,%esp
 2cd:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 2cf:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2d1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 2d4:	85 db                	test   %ebx,%ebx
 2d6:	74 04                	je     2dc <printint+0x18>
 2d8:	85 d2                	test   %edx,%edx
 2da:	78 53                	js     32f <printint+0x6b>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 2dc:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 2e3:	31 db                	xor    %ebx,%ebx
 2e5:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 2e8:	43                   	inc    %ebx
 2e9:	31 d2                	xor    %edx,%edx
 2eb:	f7 f1                	div    %ecx
 2ed:	8a 92 40 06 00 00    	mov    0x640(%edx),%dl
 2f3:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 2f6:	85 c0                	test   %eax,%eax
 2f8:	75 ee                	jne    2e8 <printint+0x24>
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 2fa:	89 d8                	mov    %ebx,%eax
  }while((x /= base) != 0);
  if(neg)
 2fc:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 2ff:	85 d2                	test   %edx,%edx
 301:	74 06                	je     309 <printint+0x45>
    buf[i++] = '-';
 303:	43                   	inc    %ebx
 304:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 309:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 30d:	8d 76 00             	lea    0x0(%esi),%esi
 310:	8a 03                	mov    (%ebx),%al
 312:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 315:	50                   	push   %eax
 316:	6a 01                	push   $0x1
 318:	56                   	push   %esi
 319:	57                   	push   %edi
 31a:	e8 1c ff ff ff       	call   23b <write>
 31f:	4b                   	dec    %ebx
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 320:	83 c4 10             	add    $0x10,%esp
 323:	39 f3                	cmp    %esi,%ebx
 325:	75 e9                	jne    310 <printint+0x4c>
    putc(fd, buf[i]);
}
 327:	8d 65 f4             	lea    -0xc(%ebp),%esp
 32a:	5b                   	pop    %ebx
 32b:	5e                   	pop    %esi
 32c:	5f                   	pop    %edi
 32d:	5d                   	pop    %ebp
 32e:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 32f:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 331:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 338:	eb a9                	jmp    2e3 <printint+0x1f>
 33a:	66 90                	xchg   %ax,%ax

0000033c <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 33c:	55                   	push   %ebp
 33d:	89 e5                	mov    %esp,%ebp
 33f:	57                   	push   %edi
 340:	56                   	push   %esi
 341:	53                   	push   %ebx
 342:	83 ec 2c             	sub    $0x2c,%esp
 345:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 348:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 34b:	8a 13                	mov    (%ebx),%dl
 34d:	84 d2                	test   %dl,%dl
 34f:	0f 84 a3 00 00 00    	je     3f8 <printf+0xbc>
 355:	43                   	inc    %ebx
 356:	8d 45 10             	lea    0x10(%ebp),%eax
 359:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 35c:	31 ff                	xor    %edi,%edi
 35e:	eb 24                	jmp    384 <printf+0x48>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 360:	83 fa 25             	cmp    $0x25,%edx
 363:	0f 84 97 00 00 00    	je     400 <printf+0xc4>
        state = '%';
      } else {
        putc(fd, c);
 369:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 36c:	50                   	push   %eax
 36d:	6a 01                	push   $0x1
 36f:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 372:	50                   	push   %eax
 373:	56                   	push   %esi
 374:	e8 c2 fe ff ff       	call   23b <write>
 379:	83 c4 10             	add    $0x10,%esp
 37c:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 37d:	8a 53 ff             	mov    -0x1(%ebx),%dl
 380:	84 d2                	test   %dl,%dl
 382:	74 74                	je     3f8 <printf+0xbc>
    c = fmt[i] & 0xff;
 384:	0f be c2             	movsbl %dl,%eax
 387:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
 38a:	85 ff                	test   %edi,%edi
 38c:	74 d2                	je     360 <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 38e:	83 ff 25             	cmp    $0x25,%edi
 391:	75 e9                	jne    37c <printf+0x40>
      if(c == 'd'){
 393:	83 fa 64             	cmp    $0x64,%edx
 396:	0f 84 e8 00 00 00    	je     484 <printf+0x148>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 39c:	25 f7 00 00 00       	and    $0xf7,%eax
 3a1:	83 f8 70             	cmp    $0x70,%eax
 3a4:	74 66                	je     40c <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3a6:	83 fa 73             	cmp    $0x73,%edx
 3a9:	0f 84 85 00 00 00    	je     434 <printf+0xf8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3af:	83 fa 63             	cmp    $0x63,%edx
 3b2:	0f 84 b5 00 00 00    	je     46d <printf+0x131>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3b8:	83 fa 25             	cmp    $0x25,%edx
 3bb:	0f 84 cf 00 00 00    	je     490 <printf+0x154>
 3c1:	89 55 d0             	mov    %edx,-0x30(%ebp)
 3c4:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3c8:	50                   	push   %eax
 3c9:	6a 01                	push   $0x1
 3cb:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3ce:	50                   	push   %eax
 3cf:	56                   	push   %esi
 3d0:	e8 66 fe ff ff       	call   23b <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 3d5:	8b 55 d0             	mov    -0x30(%ebp),%edx
 3d8:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3db:	83 c4 0c             	add    $0xc,%esp
 3de:	6a 01                	push   $0x1
 3e0:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3e3:	50                   	push   %eax
 3e4:	56                   	push   %esi
 3e5:	e8 51 fe ff ff       	call   23b <write>
 3ea:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 3ed:	31 ff                	xor    %edi,%edi
 3ef:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3f0:	8a 53 ff             	mov    -0x1(%ebx),%dl
 3f3:	84 d2                	test   %dl,%dl
 3f5:	75 8d                	jne    384 <printf+0x48>
 3f7:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 3f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3fb:	5b                   	pop    %ebx
 3fc:	5e                   	pop    %esi
 3fd:	5f                   	pop    %edi
 3fe:	5d                   	pop    %ebp
 3ff:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 400:	bf 25 00 00 00       	mov    $0x25,%edi
 405:	e9 72 ff ff ff       	jmp    37c <printf+0x40>
 40a:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 40c:	83 ec 0c             	sub    $0xc,%esp
 40f:	6a 00                	push   $0x0
 411:	b9 10 00 00 00       	mov    $0x10,%ecx
 416:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 419:	8b 17                	mov    (%edi),%edx
 41b:	89 f0                	mov    %esi,%eax
 41d:	e8 a2 fe ff ff       	call   2c4 <printint>
        ap++;
 422:	89 f8                	mov    %edi,%eax
 424:	83 c0 04             	add    $0x4,%eax
 427:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 42a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 42d:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 42f:	e9 48 ff ff ff       	jmp    37c <printf+0x40>
      } else if(c == 's'){
        s = (char*)*ap;
 434:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 437:	8b 38                	mov    (%eax),%edi
        ap++;
 439:	83 c0 04             	add    $0x4,%eax
 43c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 43f:	85 ff                	test   %edi,%edi
 441:	74 5c                	je     49f <printf+0x163>
          s = "(null)";
        while(*s != 0){
 443:	8a 07                	mov    (%edi),%al
 445:	84 c0                	test   %al,%al
 447:	74 1d                	je     466 <printf+0x12a>
 449:	8d 76 00             	lea    0x0(%esi),%esi
 44c:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 44f:	50                   	push   %eax
 450:	6a 01                	push   $0x1
 452:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 455:	50                   	push   %eax
 456:	56                   	push   %esi
 457:	e8 df fd ff ff       	call   23b <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 45c:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 45d:	8a 07                	mov    (%edi),%al
 45f:	83 c4 10             	add    $0x10,%esp
 462:	84 c0                	test   %al,%al
 464:	75 e6                	jne    44c <printf+0x110>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 466:	31 ff                	xor    %edi,%edi
 468:	e9 0f ff ff ff       	jmp    37c <printf+0x40>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 46d:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 470:	8b 07                	mov    (%edi),%eax
 472:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 475:	51                   	push   %ecx
 476:	6a 01                	push   $0x1
 478:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 47b:	50                   	push   %eax
 47c:	56                   	push   %esi
 47d:	e8 b9 fd ff ff       	call   23b <write>
 482:	eb 9e                	jmp    422 <printf+0xe6>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 484:	83 ec 0c             	sub    $0xc,%esp
 487:	6a 01                	push   $0x1
 489:	b9 0a 00 00 00       	mov    $0xa,%ecx
 48e:	eb 86                	jmp    416 <printf+0xda>
 490:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 494:	52                   	push   %edx
 495:	6a 01                	push   $0x1
 497:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 49a:	e9 44 ff ff ff       	jmp    3e3 <printf+0xa7>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 49f:	bf 39 06 00 00       	mov    $0x639,%edi
 4a4:	eb 9d                	jmp    443 <printf+0x107>
 4a6:	66 90                	xchg   %ax,%ax

000004a8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 4a8:	55                   	push   %ebp
 4a9:	89 e5                	mov    %esp,%ebp
 4ab:	57                   	push   %edi
 4ac:	56                   	push   %esi
 4ad:	53                   	push   %ebx
 4ae:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 4b1:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4b4:	a1 d4 08 00 00       	mov    0x8d4,%eax
 4b9:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4bc:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4be:	39 c8                	cmp    %ecx,%eax
 4c0:	73 2e                	jae    4f0 <free+0x48>
 4c2:	39 d1                	cmp    %edx,%ecx
 4c4:	72 04                	jb     4ca <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4c6:	39 d0                	cmp    %edx,%eax
 4c8:	72 2e                	jb     4f8 <free+0x50>
      break;
  if(bp + bp->s.size == p->s.ptr){
 4ca:	8b 73 fc             	mov    -0x4(%ebx),%esi
 4cd:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 4d0:	39 d7                	cmp    %edx,%edi
 4d2:	74 28                	je     4fc <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 4d4:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 4d7:	8b 50 04             	mov    0x4(%eax),%edx
 4da:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 4dd:	39 f1                	cmp    %esi,%ecx
 4df:	74 32                	je     513 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 4e1:	89 08                	mov    %ecx,(%eax)
  freep = p;
 4e3:	a3 d4 08 00 00       	mov    %eax,0x8d4
}
 4e8:	5b                   	pop    %ebx
 4e9:	5e                   	pop    %esi
 4ea:	5f                   	pop    %edi
 4eb:	5d                   	pop    %ebp
 4ec:	c3                   	ret    
 4ed:	8d 76 00             	lea    0x0(%esi),%esi
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4f0:	39 d0                	cmp    %edx,%eax
 4f2:	72 04                	jb     4f8 <free+0x50>
 4f4:	39 d1                	cmp    %edx,%ecx
 4f6:	72 d2                	jb     4ca <free+0x22>
static Header base;
static Header *freep;

void
free(void *ap)
{
 4f8:	89 d0                	mov    %edx,%eax
 4fa:	eb c0                	jmp    4bc <free+0x14>
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 4fc:	03 72 04             	add    0x4(%edx),%esi
 4ff:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 502:	8b 10                	mov    (%eax),%edx
 504:	8b 12                	mov    (%edx),%edx
 506:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 509:	8b 50 04             	mov    0x4(%eax),%edx
 50c:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 50f:	39 f1                	cmp    %esi,%ecx
 511:	75 ce                	jne    4e1 <free+0x39>
    p->s.size += bp->s.size;
 513:	03 53 fc             	add    -0x4(%ebx),%edx
 516:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 519:	8b 53 f8             	mov    -0x8(%ebx),%edx
 51c:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 51e:	a3 d4 08 00 00       	mov    %eax,0x8d4
}
 523:	5b                   	pop    %ebx
 524:	5e                   	pop    %esi
 525:	5f                   	pop    %edi
 526:	5d                   	pop    %ebp
 527:	c3                   	ret    

00000528 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 528:	55                   	push   %ebp
 529:	89 e5                	mov    %esp,%ebp
 52b:	57                   	push   %edi
 52c:	56                   	push   %esi
 52d:	53                   	push   %ebx
 52e:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 531:	8b 45 08             	mov    0x8(%ebp),%eax
 534:	8d 70 07             	lea    0x7(%eax),%esi
 537:	c1 ee 03             	shr    $0x3,%esi
 53a:	46                   	inc    %esi
  if((prevp = freep) == 0){
 53b:	8b 15 d4 08 00 00    	mov    0x8d4,%edx
 541:	85 d2                	test   %edx,%edx
 543:	0f 84 99 00 00 00    	je     5e2 <malloc+0xba>
 549:	8b 02                	mov    (%edx),%eax
 54b:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 54e:	39 ce                	cmp    %ecx,%esi
 550:	76 62                	jbe    5b4 <malloc+0x8c>
 552:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 559:	eb 0a                	jmp    565 <malloc+0x3d>
 55b:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 55c:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 55e:	8b 48 04             	mov    0x4(%eax),%ecx
 561:	39 ce                	cmp    %ecx,%esi
 563:	76 4f                	jbe    5b4 <malloc+0x8c>
 565:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 567:	3b 05 d4 08 00 00    	cmp    0x8d4,%eax
 56d:	75 ed                	jne    55c <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 56f:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 575:	77 5d                	ja     5d4 <malloc+0xac>
 577:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 57c:	bf 00 10 00 00       	mov    $0x1000,%edi
  p = sbrk(nu * sizeof(Header));
 581:	83 ec 0c             	sub    $0xc,%esp
 584:	50                   	push   %eax
 585:	e8 19 fd ff ff       	call   2a3 <sbrk>
  if(p == (char*)-1)
 58a:	83 c4 10             	add    $0x10,%esp
 58d:	83 f8 ff             	cmp    $0xffffffff,%eax
 590:	74 1c                	je     5ae <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 592:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 595:	83 ec 0c             	sub    $0xc,%esp
 598:	83 c0 08             	add    $0x8,%eax
 59b:	50                   	push   %eax
 59c:	e8 07 ff ff ff       	call   4a8 <free>
  return freep;
 5a1:	8b 15 d4 08 00 00    	mov    0x8d4,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 5a7:	83 c4 10             	add    $0x10,%esp
 5aa:	85 d2                	test   %edx,%edx
 5ac:	75 ae                	jne    55c <malloc+0x34>
        return 0;
 5ae:	31 c0                	xor    %eax,%eax
 5b0:	eb 1a                	jmp    5cc <malloc+0xa4>
 5b2:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 5b4:	39 ce                	cmp    %ecx,%esi
 5b6:	74 24                	je     5dc <malloc+0xb4>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 5b8:	29 f1                	sub    %esi,%ecx
 5ba:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 5bd:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 5c0:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
 5c3:	89 15 d4 08 00 00    	mov    %edx,0x8d4
      return (void*)(p + 1);
 5c9:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 5cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5cf:	5b                   	pop    %ebx
 5d0:	5e                   	pop    %esi
 5d1:	5f                   	pop    %edi
 5d2:	5d                   	pop    %ebp
 5d3:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 5d4:	89 d8                	mov    %ebx,%eax
 5d6:	89 f7                	mov    %esi,%edi
 5d8:	eb a7                	jmp    581 <malloc+0x59>
 5da:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 5dc:	8b 08                	mov    (%eax),%ecx
 5de:	89 0a                	mov    %ecx,(%edx)
 5e0:	eb e1                	jmp    5c3 <malloc+0x9b>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 5e2:	c7 05 d4 08 00 00 d8 	movl   $0x8d8,0x8d4
 5e9:	08 00 00 
 5ec:	c7 05 d8 08 00 00 d8 	movl   $0x8d8,0x8d8
 5f3:	08 00 00 
    base.s.size = 0;
 5f6:	c7 05 dc 08 00 00 00 	movl   $0x0,0x8dc
 5fd:	00 00 00 
 600:	b8 d8 08 00 00       	mov    $0x8d8,%eax
 605:	e9 48 ff ff ff       	jmp    552 <malloc+0x2a>
