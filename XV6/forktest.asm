
_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "fork test OK\n");
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
   e:	50                   	push   %eax
  forktest();
   f:	e8 30 00 00 00       	call   44 <forktest>
  exit();
  14:	e8 82 02 00 00       	call   29b <exit>
  19:	66 90                	xchg   %ax,%ax
  1b:	90                   	nop

0000001c <printf>:

#define N  1000

void
printf(int fd, char *s, ...)
{
  1c:	55                   	push   %ebp
  1d:	89 e5                	mov    %esp,%ebp
  1f:	53                   	push   %ebx
  20:	83 ec 10             	sub    $0x10,%esp
  23:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  write(fd, s, strlen(s));
  26:	53                   	push   %ebx
  27:	e8 1c 01 00 00       	call   148 <strlen>
  2c:	83 c4 0c             	add    $0xc,%esp
  2f:	50                   	push   %eax
  30:	53                   	push   %ebx
  31:	ff 75 08             	pushl  0x8(%ebp)
  34:	e8 82 02 00 00       	call   2bb <write>
  39:	83 c4 10             	add    $0x10,%esp
}
  3c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  3f:	c9                   	leave  
  40:	c3                   	ret    
  41:	8d 76 00             	lea    0x0(%esi),%esi

00000044 <forktest>:

void
forktest(void)
{
  44:	55                   	push   %ebp
  45:	89 e5                	mov    %esp,%ebp
  47:	53                   	push   %ebx
  48:	83 ec 0c             	sub    $0xc,%esp
  int n, pid;

  printf(1, "fork test\n");
  4b:	68 44 03 00 00       	push   $0x344
  50:	6a 01                	push   $0x1
  52:	e8 c5 ff ff ff       	call   1c <printf>
  57:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<N; n++){
  5a:	31 db                	xor    %ebx,%ebx
  5c:	eb 0d                	jmp    6b <forktest+0x27>
  5e:	66 90                	xchg   %ax,%ax
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
  60:	74 60                	je     c2 <forktest+0x7e>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<N; n++){
  62:	43                   	inc    %ebx
  63:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  69:	74 35                	je     a0 <forktest+0x5c>
    pid = fork();
  6b:	e8 23 02 00 00       	call   293 <fork>
    if(pid < 0)
  70:	85 c0                	test   %eax,%eax
  72:	79 ec                	jns    60 <forktest+0x1c>
  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit();
  }

  for(; n > 0; n--){
  74:	85 db                	test   %ebx,%ebx
  76:	74 0c                	je     84 <forktest+0x40>
    if(wait() < 0){
  78:	e8 26 02 00 00       	call   2a3 <wait>
  7d:	85 c0                	test   %eax,%eax
  7f:	78 46                	js     c7 <forktest+0x83>
  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit();
  }

  for(; n > 0; n--){
  81:	4b                   	dec    %ebx
  82:	75 f4                	jne    78 <forktest+0x34>
      printf(1, "wait stopped early\n");
      exit();
    }
  }

  if(wait() != -1){
  84:	e8 1a 02 00 00       	call   2a3 <wait>
  89:	40                   	inc    %eax
  8a:	75 4f                	jne    db <forktest+0x97>
    printf(1, "wait got too many\n");
    exit();
  }

  printf(1, "fork test OK\n");
  8c:	83 ec 08             	sub    $0x8,%esp
  8f:	68 76 03 00 00       	push   $0x376
  94:	6a 01                	push   $0x1
  96:	e8 81 ff ff ff       	call   1c <printf>
}
  9b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  9e:	c9                   	leave  
  9f:	c3                   	ret    
#define N  1000

void
printf(int fd, char *s, ...)
{
  write(fd, s, strlen(s));
  a0:	83 ec 0c             	sub    $0xc,%esp
  a3:	68 84 03 00 00       	push   $0x384
  a8:	e8 9b 00 00 00       	call   148 <strlen>
  ad:	83 c4 0c             	add    $0xc,%esp
  b0:	50                   	push   %eax
  b1:	68 84 03 00 00       	push   $0x384
  b6:	6a 01                	push   $0x1
  b8:	e8 fe 01 00 00       	call   2bb <write>
      exit();
  }

  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit();
  bd:	e8 d9 01 00 00       	call   29b <exit>
  for(n=0; n<N; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
      exit();
  c2:	e8 d4 01 00 00       	call   29b <exit>
    exit();
  }

  for(; n > 0; n--){
    if(wait() < 0){
      printf(1, "wait stopped early\n");
  c7:	83 ec 08             	sub    $0x8,%esp
  ca:	68 4f 03 00 00       	push   $0x34f
  cf:	6a 01                	push   $0x1
  d1:	e8 46 ff ff ff       	call   1c <printf>
      exit();
  d6:	e8 c0 01 00 00       	call   29b <exit>
    }
  }

  if(wait() != -1){
    printf(1, "wait got too many\n");
  db:	83 ec 08             	sub    $0x8,%esp
  de:	68 63 03 00 00       	push   $0x363
  e3:	6a 01                	push   $0x1
  e5:	e8 32 ff ff ff       	call   1c <printf>
    exit();
  ea:	e8 ac 01 00 00       	call   29b <exit>
  ef:	90                   	nop

000000f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	53                   	push   %ebx
  f4:	8b 45 08             	mov    0x8(%ebp),%eax
  f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  fa:	89 c2                	mov    %eax,%edx
  fc:	42                   	inc    %edx
  fd:	41                   	inc    %ecx
  fe:	8a 59 ff             	mov    -0x1(%ecx),%bl
 101:	88 5a ff             	mov    %bl,-0x1(%edx)
 104:	84 db                	test   %bl,%bl
 106:	75 f4                	jne    fc <strcpy+0xc>
    ;
  return os;
}
 108:	5b                   	pop    %ebx
 109:	5d                   	pop    %ebp
 10a:	c3                   	ret    
 10b:	90                   	nop

0000010c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 10c:	55                   	push   %ebp
 10d:	89 e5                	mov    %esp,%ebp
 10f:	56                   	push   %esi
 110:	53                   	push   %ebx
 111:	8b 55 08             	mov    0x8(%ebp),%edx
 114:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 117:	0f b6 02             	movzbl (%edx),%eax
 11a:	0f b6 0b             	movzbl (%ebx),%ecx
 11d:	84 c0                	test   %al,%al
 11f:	75 14                	jne    135 <strcmp+0x29>
 121:	eb 1d                	jmp    140 <strcmp+0x34>
 123:	90                   	nop
    p++, q++;
 124:	42                   	inc    %edx
 125:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 128:	0f b6 02             	movzbl (%edx),%eax
 12b:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 12f:	84 c0                	test   %al,%al
 131:	74 0d                	je     140 <strcmp+0x34>
 133:	89 f3                	mov    %esi,%ebx
 135:	38 c8                	cmp    %cl,%al
 137:	74 eb                	je     124 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 139:	29 c8                	sub    %ecx,%eax
}
 13b:	5b                   	pop    %ebx
 13c:	5e                   	pop    %esi
 13d:	5d                   	pop    %ebp
 13e:	c3                   	ret    
 13f:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 140:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 142:	29 c8                	sub    %ecx,%eax
}
 144:	5b                   	pop    %ebx
 145:	5e                   	pop    %esi
 146:	5d                   	pop    %ebp
 147:	c3                   	ret    

00000148 <strlen>:

uint
strlen(char *s)
{
 148:	55                   	push   %ebp
 149:	89 e5                	mov    %esp,%ebp
 14b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 14e:	80 39 00             	cmpb   $0x0,(%ecx)
 151:	74 10                	je     163 <strlen+0x1b>
 153:	31 d2                	xor    %edx,%edx
 155:	8d 76 00             	lea    0x0(%esi),%esi
 158:	42                   	inc    %edx
 159:	89 d0                	mov    %edx,%eax
 15b:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 15f:	75 f7                	jne    158 <strlen+0x10>
    ;
  return n;
}
 161:	5d                   	pop    %ebp
 162:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 163:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 165:	5d                   	pop    %ebp
 166:	c3                   	ret    
 167:	90                   	nop

00000168 <memset>:

void*
memset(void *dst, int c, uint n)
{
 168:	55                   	push   %ebp
 169:	89 e5                	mov    %esp,%ebp
 16b:	57                   	push   %edi
 16c:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 16f:	89 d7                	mov    %edx,%edi
 171:	8b 4d 10             	mov    0x10(%ebp),%ecx
 174:	8b 45 0c             	mov    0xc(%ebp),%eax
 177:	fc                   	cld    
 178:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 17a:	89 d0                	mov    %edx,%eax
 17c:	5f                   	pop    %edi
 17d:	5d                   	pop    %ebp
 17e:	c3                   	ret    
 17f:	90                   	nop

00000180 <strchr>:

char*
strchr(const char *s, char c)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	53                   	push   %ebx
 184:	8b 45 08             	mov    0x8(%ebp),%eax
 187:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 18a:	8a 18                	mov    (%eax),%bl
 18c:	84 db                	test   %bl,%bl
 18e:	74 13                	je     1a3 <strchr+0x23>
 190:	88 d1                	mov    %dl,%cl
    if(*s == c)
 192:	38 d3                	cmp    %dl,%bl
 194:	75 06                	jne    19c <strchr+0x1c>
 196:	eb 0d                	jmp    1a5 <strchr+0x25>
 198:	38 ca                	cmp    %cl,%dl
 19a:	74 09                	je     1a5 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 19c:	40                   	inc    %eax
 19d:	8a 10                	mov    (%eax),%dl
 19f:	84 d2                	test   %dl,%dl
 1a1:	75 f5                	jne    198 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 1a3:	31 c0                	xor    %eax,%eax
}
 1a5:	5b                   	pop    %ebx
 1a6:	5d                   	pop    %ebp
 1a7:	c3                   	ret    

000001a8 <gets>:

char*
gets(char *buf, int max)
{
 1a8:	55                   	push   %ebp
 1a9:	89 e5                	mov    %esp,%ebp
 1ab:	57                   	push   %edi
 1ac:	56                   	push   %esi
 1ad:	53                   	push   %ebx
 1ae:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1b1:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 1b3:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1b6:	eb 26                	jmp    1de <gets+0x36>
    cc = read(0, &c, 1);
 1b8:	50                   	push   %eax
 1b9:	6a 01                	push   $0x1
 1bb:	57                   	push   %edi
 1bc:	6a 00                	push   $0x0
 1be:	e8 f0 00 00 00       	call   2b3 <read>
    if(cc < 1)
 1c3:	83 c4 10             	add    $0x10,%esp
 1c6:	85 c0                	test   %eax,%eax
 1c8:	7e 1c                	jle    1e6 <gets+0x3e>
      break;
    buf[i++] = c;
 1ca:	8a 45 e7             	mov    -0x19(%ebp),%al
 1cd:	8b 55 08             	mov    0x8(%ebp),%edx
 1d0:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
 1d4:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 1d6:	3c 0a                	cmp    $0xa,%al
 1d8:	74 0c                	je     1e6 <gets+0x3e>
 1da:	3c 0d                	cmp    $0xd,%al
 1dc:	74 08                	je     1e6 <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1de:	8d 5e 01             	lea    0x1(%esi),%ebx
 1e1:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1e4:	7c d2                	jl     1b8 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1e6:	8b 45 08             	mov    0x8(%ebp),%eax
 1e9:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1f0:	5b                   	pop    %ebx
 1f1:	5e                   	pop    %esi
 1f2:	5f                   	pop    %edi
 1f3:	5d                   	pop    %ebp
 1f4:	c3                   	ret    
 1f5:	8d 76 00             	lea    0x0(%esi),%esi

000001f8 <stat>:

int
stat(char *n, struct stat *st)
{
 1f8:	55                   	push   %ebp
 1f9:	89 e5                	mov    %esp,%ebp
 1fb:	56                   	push   %esi
 1fc:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1fd:	83 ec 08             	sub    $0x8,%esp
 200:	6a 00                	push   $0x0
 202:	ff 75 08             	pushl  0x8(%ebp)
 205:	e8 d1 00 00 00       	call   2db <open>
 20a:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 20c:	83 c4 10             	add    $0x10,%esp
 20f:	85 c0                	test   %eax,%eax
 211:	78 25                	js     238 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 213:	83 ec 08             	sub    $0x8,%esp
 216:	ff 75 0c             	pushl  0xc(%ebp)
 219:	50                   	push   %eax
 21a:	e8 d4 00 00 00       	call   2f3 <fstat>
 21f:	89 c6                	mov    %eax,%esi
  close(fd);
 221:	89 1c 24             	mov    %ebx,(%esp)
 224:	e8 9a 00 00 00       	call   2c3 <close>
  return r;
 229:	83 c4 10             	add    $0x10,%esp
 22c:	89 f0                	mov    %esi,%eax
}
 22e:	8d 65 f8             	lea    -0x8(%ebp),%esp
 231:	5b                   	pop    %ebx
 232:	5e                   	pop    %esi
 233:	5d                   	pop    %ebp
 234:	c3                   	ret    
 235:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 238:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 23d:	eb ef                	jmp    22e <stat+0x36>
 23f:	90                   	nop

00000240 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	53                   	push   %ebx
 244:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 247:	0f be 11             	movsbl (%ecx),%edx
 24a:	8d 42 d0             	lea    -0x30(%edx),%eax
 24d:	3c 09                	cmp    $0x9,%al
 24f:	b8 00 00 00 00       	mov    $0x0,%eax
 254:	77 15                	ja     26b <atoi+0x2b>
 256:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 258:	41                   	inc    %ecx
 259:	8d 04 80             	lea    (%eax,%eax,4),%eax
 25c:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 260:	0f be 11             	movsbl (%ecx),%edx
 263:	8d 5a d0             	lea    -0x30(%edx),%ebx
 266:	80 fb 09             	cmp    $0x9,%bl
 269:	76 ed                	jbe    258 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 26b:	5b                   	pop    %ebx
 26c:	5d                   	pop    %ebp
 26d:	c3                   	ret    
 26e:	66 90                	xchg   %ax,%ax

00000270 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	56                   	push   %esi
 274:	53                   	push   %ebx
 275:	8b 45 08             	mov    0x8(%ebp),%eax
 278:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 27b:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 27e:	31 d2                	xor    %edx,%edx
 280:	85 f6                	test   %esi,%esi
 282:	7e 0b                	jle    28f <memmove+0x1f>
    *dst++ = *src++;
 284:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 287:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 28a:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 28b:	39 f2                	cmp    %esi,%edx
 28d:	75 f5                	jne    284 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 28f:	5b                   	pop    %ebx
 290:	5e                   	pop    %esi
 291:	5d                   	pop    %ebp
 292:	c3                   	ret    

00000293 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 293:	b8 01 00 00 00       	mov    $0x1,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret    

0000029b <exit>:
SYSCALL(exit)
 29b:	b8 02 00 00 00       	mov    $0x2,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret    

000002a3 <wait>:
SYSCALL(wait)
 2a3:	b8 03 00 00 00       	mov    $0x3,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret    

000002ab <pipe>:
SYSCALL(pipe)
 2ab:	b8 04 00 00 00       	mov    $0x4,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret    

000002b3 <read>:
SYSCALL(read)
 2b3:	b8 05 00 00 00       	mov    $0x5,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret    

000002bb <write>:
SYSCALL(write)
 2bb:	b8 10 00 00 00       	mov    $0x10,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <close>:
SYSCALL(close)
 2c3:	b8 15 00 00 00       	mov    $0x15,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <kill>:
SYSCALL(kill)
 2cb:	b8 06 00 00 00       	mov    $0x6,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <exec>:
SYSCALL(exec)
 2d3:	b8 07 00 00 00       	mov    $0x7,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <open>:
SYSCALL(open)
 2db:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <mknod>:
SYSCALL(mknod)
 2e3:	b8 11 00 00 00       	mov    $0x11,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <unlink>:
SYSCALL(unlink)
 2eb:	b8 12 00 00 00       	mov    $0x12,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <fstat>:
SYSCALL(fstat)
 2f3:	b8 08 00 00 00       	mov    $0x8,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <link>:
SYSCALL(link)
 2fb:	b8 13 00 00 00       	mov    $0x13,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <mkdir>:
SYSCALL(mkdir)
 303:	b8 14 00 00 00       	mov    $0x14,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <chdir>:
SYSCALL(chdir)
 30b:	b8 09 00 00 00       	mov    $0x9,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <dup>:
SYSCALL(dup)
 313:	b8 0a 00 00 00       	mov    $0xa,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <getpid>:
SYSCALL(getpid)
 31b:	b8 0b 00 00 00       	mov    $0xb,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <sbrk>:
SYSCALL(sbrk)
 323:	b8 0c 00 00 00       	mov    $0xc,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <sleep>:
SYSCALL(sleep)
 32b:	b8 0d 00 00 00       	mov    $0xd,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <uptime>:
SYSCALL(uptime)
 333:	b8 0e 00 00 00       	mov    $0xe,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <mike>:
SYSCALL(mike)
 33b:	b8 16 00 00 00       	mov    $0x16,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    
