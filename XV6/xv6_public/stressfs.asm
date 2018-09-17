
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
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
  11:	81 ec 20 02 00 00    	sub    $0x220,%esp
  int fd, i;
  char path[] = "stressfs0";
  17:	be cf 06 00 00       	mov    $0x6cf,%esi
  1c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  21:	8d bd de fd ff ff    	lea    -0x222(%ebp),%edi
  27:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  char data[512];

  printf(1, "stressfs starting\n");
  29:	68 ac 06 00 00       	push   $0x6ac
  2e:	6a 01                	push   $0x1
  30:	e8 a7 03 00 00       	call   3dc <printf>
  memset(data, 'a', sizeof(data));
  35:	83 c4 0c             	add    $0xc,%esp
  38:	68 00 02 00 00       	push   $0x200
  3d:	6a 61                	push   $0x61
  3f:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
  45:	56                   	push   %esi
  46:	e8 3d 01 00 00       	call   188 <memset>
  4b:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 4; i++)
  4e:	31 db                	xor    %ebx,%ebx
    if(fork() > 0)
  50:	e8 5e 02 00 00       	call   2b3 <fork>
  55:	85 c0                	test   %eax,%eax
  57:	0f 8f a9 00 00 00    	jg     106 <main+0x106>
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));

  for(i = 0; i < 4; i++)
  5d:	43                   	inc    %ebx
  5e:	83 fb 04             	cmp    $0x4,%ebx
  61:	75 ed                	jne    50 <main+0x50>
  63:	bf 04 00 00 00       	mov    $0x4,%edi
    if(fork() > 0)
      break;

  printf(1, "write %d\n", i);
  68:	50                   	push   %eax
  69:	53                   	push   %ebx
  6a:	68 bf 06 00 00       	push   $0x6bf
  6f:	6a 01                	push   $0x1
  71:	e8 66 03 00 00       	call   3dc <printf>

  path[8] += i;
  76:	89 f8                	mov    %edi,%eax
  78:	00 85 e6 fd ff ff    	add    %al,-0x21a(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
  7e:	58                   	pop    %eax
  7f:	5a                   	pop    %edx
  80:	68 02 02 00 00       	push   $0x202
  85:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  8b:	50                   	push   %eax
  8c:	e8 6a 02 00 00       	call   2fb <open>
  91:	89 c7                	mov    %eax,%edi
  93:	83 c4 10             	add    $0x10,%esp
  96:	bb 14 00 00 00       	mov    $0x14,%ebx
  9b:	90                   	nop
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  9c:	50                   	push   %eax
  9d:	68 00 02 00 00       	push   $0x200
  a2:	56                   	push   %esi
  a3:	57                   	push   %edi
  a4:	e8 32 02 00 00       	call   2db <write>

  printf(1, "write %d\n", i);

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 20; i++)
  a9:	83 c4 10             	add    $0x10,%esp
  ac:	4b                   	dec    %ebx
  ad:	75 ed                	jne    9c <main+0x9c>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  close(fd);
  af:	83 ec 0c             	sub    $0xc,%esp
  b2:	57                   	push   %edi
  b3:	e8 2b 02 00 00       	call   2e3 <close>

  printf(1, "read\n");
  b8:	5a                   	pop    %edx
  b9:	59                   	pop    %ecx
  ba:	68 c9 06 00 00       	push   $0x6c9
  bf:	6a 01                	push   $0x1
  c1:	e8 16 03 00 00       	call   3dc <printf>

  fd = open(path, O_RDONLY);
  c6:	5b                   	pop    %ebx
  c7:	5f                   	pop    %edi
  c8:	6a 00                	push   $0x0
  ca:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  d0:	50                   	push   %eax
  d1:	e8 25 02 00 00       	call   2fb <open>
  d6:	89 c7                	mov    %eax,%edi
  d8:	83 c4 10             	add    $0x10,%esp
  db:	bb 14 00 00 00       	mov    $0x14,%ebx
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  e0:	50                   	push   %eax
  e1:	68 00 02 00 00       	push   $0x200
  e6:	56                   	push   %esi
  e7:	57                   	push   %edi
  e8:	e8 e6 01 00 00       	call   2d3 <read>
  close(fd);

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  for (i = 0; i < 20; i++)
  ed:	83 c4 10             	add    $0x10,%esp
  f0:	4b                   	dec    %ebx
  f1:	75 ed                	jne    e0 <main+0xe0>
    read(fd, data, sizeof(data));
  close(fd);
  f3:	83 ec 0c             	sub    $0xc,%esp
  f6:	57                   	push   %edi
  f7:	e8 e7 01 00 00       	call   2e3 <close>

  wait();
  fc:	e8 c2 01 00 00       	call   2c3 <wait>

  exit();
 101:	e8 b5 01 00 00       	call   2bb <exit>
 106:	89 df                	mov    %ebx,%edi
 108:	e9 5b ff ff ff       	jmp    68 <main+0x68>
 10d:	66 90                	xchg   %ax,%ax
 10f:	90                   	nop

00000110 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	53                   	push   %ebx
 114:	8b 45 08             	mov    0x8(%ebp),%eax
 117:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 11a:	89 c2                	mov    %eax,%edx
 11c:	42                   	inc    %edx
 11d:	41                   	inc    %ecx
 11e:	8a 59 ff             	mov    -0x1(%ecx),%bl
 121:	88 5a ff             	mov    %bl,-0x1(%edx)
 124:	84 db                	test   %bl,%bl
 126:	75 f4                	jne    11c <strcpy+0xc>
    ;
  return os;
}
 128:	5b                   	pop    %ebx
 129:	5d                   	pop    %ebp
 12a:	c3                   	ret    
 12b:	90                   	nop

0000012c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 12c:	55                   	push   %ebp
 12d:	89 e5                	mov    %esp,%ebp
 12f:	56                   	push   %esi
 130:	53                   	push   %ebx
 131:	8b 55 08             	mov    0x8(%ebp),%edx
 134:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 137:	0f b6 02             	movzbl (%edx),%eax
 13a:	0f b6 0b             	movzbl (%ebx),%ecx
 13d:	84 c0                	test   %al,%al
 13f:	75 14                	jne    155 <strcmp+0x29>
 141:	eb 1d                	jmp    160 <strcmp+0x34>
 143:	90                   	nop
    p++, q++;
 144:	42                   	inc    %edx
 145:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 148:	0f b6 02             	movzbl (%edx),%eax
 14b:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 14f:	84 c0                	test   %al,%al
 151:	74 0d                	je     160 <strcmp+0x34>
 153:	89 f3                	mov    %esi,%ebx
 155:	38 c8                	cmp    %cl,%al
 157:	74 eb                	je     144 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 159:	29 c8                	sub    %ecx,%eax
}
 15b:	5b                   	pop    %ebx
 15c:	5e                   	pop    %esi
 15d:	5d                   	pop    %ebp
 15e:	c3                   	ret    
 15f:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 160:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 162:	29 c8                	sub    %ecx,%eax
}
 164:	5b                   	pop    %ebx
 165:	5e                   	pop    %esi
 166:	5d                   	pop    %ebp
 167:	c3                   	ret    

00000168 <strlen>:

uint
strlen(char *s)
{
 168:	55                   	push   %ebp
 169:	89 e5                	mov    %esp,%ebp
 16b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 16e:	80 39 00             	cmpb   $0x0,(%ecx)
 171:	74 10                	je     183 <strlen+0x1b>
 173:	31 d2                	xor    %edx,%edx
 175:	8d 76 00             	lea    0x0(%esi),%esi
 178:	42                   	inc    %edx
 179:	89 d0                	mov    %edx,%eax
 17b:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 17f:	75 f7                	jne    178 <strlen+0x10>
    ;
  return n;
}
 181:	5d                   	pop    %ebp
 182:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 183:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 185:	5d                   	pop    %ebp
 186:	c3                   	ret    
 187:	90                   	nop

00000188 <memset>:

void*
memset(void *dst, int c, uint n)
{
 188:	55                   	push   %ebp
 189:	89 e5                	mov    %esp,%ebp
 18b:	57                   	push   %edi
 18c:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 18f:	89 d7                	mov    %edx,%edi
 191:	8b 4d 10             	mov    0x10(%ebp),%ecx
 194:	8b 45 0c             	mov    0xc(%ebp),%eax
 197:	fc                   	cld    
 198:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 19a:	89 d0                	mov    %edx,%eax
 19c:	5f                   	pop    %edi
 19d:	5d                   	pop    %ebp
 19e:	c3                   	ret    
 19f:	90                   	nop

000001a0 <strchr>:

char*
strchr(const char *s, char c)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	53                   	push   %ebx
 1a4:	8b 45 08             	mov    0x8(%ebp),%eax
 1a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 1aa:	8a 18                	mov    (%eax),%bl
 1ac:	84 db                	test   %bl,%bl
 1ae:	74 13                	je     1c3 <strchr+0x23>
 1b0:	88 d1                	mov    %dl,%cl
    if(*s == c)
 1b2:	38 d3                	cmp    %dl,%bl
 1b4:	75 06                	jne    1bc <strchr+0x1c>
 1b6:	eb 0d                	jmp    1c5 <strchr+0x25>
 1b8:	38 ca                	cmp    %cl,%dl
 1ba:	74 09                	je     1c5 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1bc:	40                   	inc    %eax
 1bd:	8a 10                	mov    (%eax),%dl
 1bf:	84 d2                	test   %dl,%dl
 1c1:	75 f5                	jne    1b8 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 1c3:	31 c0                	xor    %eax,%eax
}
 1c5:	5b                   	pop    %ebx
 1c6:	5d                   	pop    %ebp
 1c7:	c3                   	ret    

000001c8 <gets>:

char*
gets(char *buf, int max)
{
 1c8:	55                   	push   %ebp
 1c9:	89 e5                	mov    %esp,%ebp
 1cb:	57                   	push   %edi
 1cc:	56                   	push   %esi
 1cd:	53                   	push   %ebx
 1ce:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d1:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 1d3:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d6:	eb 26                	jmp    1fe <gets+0x36>
    cc = read(0, &c, 1);
 1d8:	50                   	push   %eax
 1d9:	6a 01                	push   $0x1
 1db:	57                   	push   %edi
 1dc:	6a 00                	push   $0x0
 1de:	e8 f0 00 00 00       	call   2d3 <read>
    if(cc < 1)
 1e3:	83 c4 10             	add    $0x10,%esp
 1e6:	85 c0                	test   %eax,%eax
 1e8:	7e 1c                	jle    206 <gets+0x3e>
      break;
    buf[i++] = c;
 1ea:	8a 45 e7             	mov    -0x19(%ebp),%al
 1ed:	8b 55 08             	mov    0x8(%ebp),%edx
 1f0:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
 1f4:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 1f6:	3c 0a                	cmp    $0xa,%al
 1f8:	74 0c                	je     206 <gets+0x3e>
 1fa:	3c 0d                	cmp    $0xd,%al
 1fc:	74 08                	je     206 <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1fe:	8d 5e 01             	lea    0x1(%esi),%ebx
 201:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 204:	7c d2                	jl     1d8 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 206:	8b 45 08             	mov    0x8(%ebp),%eax
 209:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 20d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 210:	5b                   	pop    %ebx
 211:	5e                   	pop    %esi
 212:	5f                   	pop    %edi
 213:	5d                   	pop    %ebp
 214:	c3                   	ret    
 215:	8d 76 00             	lea    0x0(%esi),%esi

00000218 <stat>:

int
stat(char *n, struct stat *st)
{
 218:	55                   	push   %ebp
 219:	89 e5                	mov    %esp,%ebp
 21b:	56                   	push   %esi
 21c:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 21d:	83 ec 08             	sub    $0x8,%esp
 220:	6a 00                	push   $0x0
 222:	ff 75 08             	pushl  0x8(%ebp)
 225:	e8 d1 00 00 00       	call   2fb <open>
 22a:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 22c:	83 c4 10             	add    $0x10,%esp
 22f:	85 c0                	test   %eax,%eax
 231:	78 25                	js     258 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 233:	83 ec 08             	sub    $0x8,%esp
 236:	ff 75 0c             	pushl  0xc(%ebp)
 239:	50                   	push   %eax
 23a:	e8 d4 00 00 00       	call   313 <fstat>
 23f:	89 c6                	mov    %eax,%esi
  close(fd);
 241:	89 1c 24             	mov    %ebx,(%esp)
 244:	e8 9a 00 00 00       	call   2e3 <close>
  return r;
 249:	83 c4 10             	add    $0x10,%esp
 24c:	89 f0                	mov    %esi,%eax
}
 24e:	8d 65 f8             	lea    -0x8(%ebp),%esp
 251:	5b                   	pop    %ebx
 252:	5e                   	pop    %esi
 253:	5d                   	pop    %ebp
 254:	c3                   	ret    
 255:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 258:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 25d:	eb ef                	jmp    24e <stat+0x36>
 25f:	90                   	nop

00000260 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	53                   	push   %ebx
 264:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 267:	0f be 11             	movsbl (%ecx),%edx
 26a:	8d 42 d0             	lea    -0x30(%edx),%eax
 26d:	3c 09                	cmp    $0x9,%al
 26f:	b8 00 00 00 00       	mov    $0x0,%eax
 274:	77 15                	ja     28b <atoi+0x2b>
 276:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 278:	41                   	inc    %ecx
 279:	8d 04 80             	lea    (%eax,%eax,4),%eax
 27c:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 280:	0f be 11             	movsbl (%ecx),%edx
 283:	8d 5a d0             	lea    -0x30(%edx),%ebx
 286:	80 fb 09             	cmp    $0x9,%bl
 289:	76 ed                	jbe    278 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 28b:	5b                   	pop    %ebx
 28c:	5d                   	pop    %ebp
 28d:	c3                   	ret    
 28e:	66 90                	xchg   %ax,%ax

00000290 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	56                   	push   %esi
 294:	53                   	push   %ebx
 295:	8b 45 08             	mov    0x8(%ebp),%eax
 298:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 29b:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 29e:	31 d2                	xor    %edx,%edx
 2a0:	85 f6                	test   %esi,%esi
 2a2:	7e 0b                	jle    2af <memmove+0x1f>
    *dst++ = *src++;
 2a4:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 2a7:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2aa:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ab:	39 f2                	cmp    %esi,%edx
 2ad:	75 f5                	jne    2a4 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 2af:	5b                   	pop    %ebx
 2b0:	5e                   	pop    %esi
 2b1:	5d                   	pop    %ebp
 2b2:	c3                   	ret    

000002b3 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2b3:	b8 01 00 00 00       	mov    $0x1,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret    

000002bb <exit>:
SYSCALL(exit)
 2bb:	b8 02 00 00 00       	mov    $0x2,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <wait>:
SYSCALL(wait)
 2c3:	b8 03 00 00 00       	mov    $0x3,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <pipe>:
SYSCALL(pipe)
 2cb:	b8 04 00 00 00       	mov    $0x4,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <read>:
SYSCALL(read)
 2d3:	b8 05 00 00 00       	mov    $0x5,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <write>:
SYSCALL(write)
 2db:	b8 10 00 00 00       	mov    $0x10,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <close>:
SYSCALL(close)
 2e3:	b8 15 00 00 00       	mov    $0x15,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <kill>:
SYSCALL(kill)
 2eb:	b8 06 00 00 00       	mov    $0x6,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <exec>:
SYSCALL(exec)
 2f3:	b8 07 00 00 00       	mov    $0x7,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <open>:
SYSCALL(open)
 2fb:	b8 0f 00 00 00       	mov    $0xf,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <mknod>:
SYSCALL(mknod)
 303:	b8 11 00 00 00       	mov    $0x11,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <unlink>:
SYSCALL(unlink)
 30b:	b8 12 00 00 00       	mov    $0x12,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <fstat>:
SYSCALL(fstat)
 313:	b8 08 00 00 00       	mov    $0x8,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <link>:
SYSCALL(link)
 31b:	b8 13 00 00 00       	mov    $0x13,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <mkdir>:
SYSCALL(mkdir)
 323:	b8 14 00 00 00       	mov    $0x14,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <chdir>:
SYSCALL(chdir)
 32b:	b8 09 00 00 00       	mov    $0x9,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <dup>:
SYSCALL(dup)
 333:	b8 0a 00 00 00       	mov    $0xa,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <getpid>:
SYSCALL(getpid)
 33b:	b8 0b 00 00 00       	mov    $0xb,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <sbrk>:
SYSCALL(sbrk)
 343:	b8 0c 00 00 00       	mov    $0xc,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <sleep>:
SYSCALL(sleep)
 34b:	b8 0d 00 00 00       	mov    $0xd,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <uptime>:
SYSCALL(uptime)
 353:	b8 0e 00 00 00       	mov    $0xe,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <mike>:
SYSCALL(mike)
 35b:	b8 16 00 00 00       	mov    $0x16,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    
 363:	90                   	nop

00000364 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 364:	55                   	push   %ebp
 365:	89 e5                	mov    %esp,%ebp
 367:	57                   	push   %edi
 368:	56                   	push   %esi
 369:	53                   	push   %ebx
 36a:	83 ec 3c             	sub    $0x3c,%esp
 36d:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 36f:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 371:	8b 5d 08             	mov    0x8(%ebp),%ebx
 374:	85 db                	test   %ebx,%ebx
 376:	74 04                	je     37c <printint+0x18>
 378:	85 d2                	test   %edx,%edx
 37a:	78 53                	js     3cf <printint+0x6b>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 37c:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 383:	31 db                	xor    %ebx,%ebx
 385:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 388:	43                   	inc    %ebx
 389:	31 d2                	xor    %edx,%edx
 38b:	f7 f1                	div    %ecx
 38d:	8a 92 e0 06 00 00    	mov    0x6e0(%edx),%dl
 393:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 396:	85 c0                	test   %eax,%eax
 398:	75 ee                	jne    388 <printint+0x24>
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 39a:	89 d8                	mov    %ebx,%eax
  }while((x /= base) != 0);
  if(neg)
 39c:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 39f:	85 d2                	test   %edx,%edx
 3a1:	74 06                	je     3a9 <printint+0x45>
    buf[i++] = '-';
 3a3:	43                   	inc    %ebx
 3a4:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 3a9:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 3ad:	8d 76 00             	lea    0x0(%esi),%esi
 3b0:	8a 03                	mov    (%ebx),%al
 3b2:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3b5:	50                   	push   %eax
 3b6:	6a 01                	push   $0x1
 3b8:	56                   	push   %esi
 3b9:	57                   	push   %edi
 3ba:	e8 1c ff ff ff       	call   2db <write>
 3bf:	4b                   	dec    %ebx
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3c0:	83 c4 10             	add    $0x10,%esp
 3c3:	39 f3                	cmp    %esi,%ebx
 3c5:	75 e9                	jne    3b0 <printint+0x4c>
    putc(fd, buf[i]);
}
 3c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3ca:	5b                   	pop    %ebx
 3cb:	5e                   	pop    %esi
 3cc:	5f                   	pop    %edi
 3cd:	5d                   	pop    %ebp
 3ce:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3cf:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 3d1:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 3d8:	eb a9                	jmp    383 <printint+0x1f>
 3da:	66 90                	xchg   %ax,%ax

000003dc <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3dc:	55                   	push   %ebp
 3dd:	89 e5                	mov    %esp,%ebp
 3df:	57                   	push   %edi
 3e0:	56                   	push   %esi
 3e1:	53                   	push   %ebx
 3e2:	83 ec 2c             	sub    $0x2c,%esp
 3e5:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3e8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 3eb:	8a 13                	mov    (%ebx),%dl
 3ed:	84 d2                	test   %dl,%dl
 3ef:	0f 84 a3 00 00 00    	je     498 <printf+0xbc>
 3f5:	43                   	inc    %ebx
 3f6:	8d 45 10             	lea    0x10(%ebp),%eax
 3f9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 3fc:	31 ff                	xor    %edi,%edi
 3fe:	eb 24                	jmp    424 <printf+0x48>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 400:	83 fa 25             	cmp    $0x25,%edx
 403:	0f 84 97 00 00 00    	je     4a0 <printf+0xc4>
        state = '%';
      } else {
        putc(fd, c);
 409:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 40c:	50                   	push   %eax
 40d:	6a 01                	push   $0x1
 40f:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 412:	50                   	push   %eax
 413:	56                   	push   %esi
 414:	e8 c2 fe ff ff       	call   2db <write>
 419:	83 c4 10             	add    $0x10,%esp
 41c:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 41d:	8a 53 ff             	mov    -0x1(%ebx),%dl
 420:	84 d2                	test   %dl,%dl
 422:	74 74                	je     498 <printf+0xbc>
    c = fmt[i] & 0xff;
 424:	0f be c2             	movsbl %dl,%eax
 427:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
 42a:	85 ff                	test   %edi,%edi
 42c:	74 d2                	je     400 <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 42e:	83 ff 25             	cmp    $0x25,%edi
 431:	75 e9                	jne    41c <printf+0x40>
      if(c == 'd'){
 433:	83 fa 64             	cmp    $0x64,%edx
 436:	0f 84 e8 00 00 00    	je     524 <printf+0x148>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 43c:	25 f7 00 00 00       	and    $0xf7,%eax
 441:	83 f8 70             	cmp    $0x70,%eax
 444:	74 66                	je     4ac <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 446:	83 fa 73             	cmp    $0x73,%edx
 449:	0f 84 85 00 00 00    	je     4d4 <printf+0xf8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 44f:	83 fa 63             	cmp    $0x63,%edx
 452:	0f 84 b5 00 00 00    	je     50d <printf+0x131>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 458:	83 fa 25             	cmp    $0x25,%edx
 45b:	0f 84 cf 00 00 00    	je     530 <printf+0x154>
 461:	89 55 d0             	mov    %edx,-0x30(%ebp)
 464:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 468:	50                   	push   %eax
 469:	6a 01                	push   $0x1
 46b:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 46e:	50                   	push   %eax
 46f:	56                   	push   %esi
 470:	e8 66 fe ff ff       	call   2db <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 475:	8b 55 d0             	mov    -0x30(%ebp),%edx
 478:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 47b:	83 c4 0c             	add    $0xc,%esp
 47e:	6a 01                	push   $0x1
 480:	8d 45 e7             	lea    -0x19(%ebp),%eax
 483:	50                   	push   %eax
 484:	56                   	push   %esi
 485:	e8 51 fe ff ff       	call   2db <write>
 48a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 48d:	31 ff                	xor    %edi,%edi
 48f:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 490:	8a 53 ff             	mov    -0x1(%ebx),%dl
 493:	84 d2                	test   %dl,%dl
 495:	75 8d                	jne    424 <printf+0x48>
 497:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 498:	8d 65 f4             	lea    -0xc(%ebp),%esp
 49b:	5b                   	pop    %ebx
 49c:	5e                   	pop    %esi
 49d:	5f                   	pop    %edi
 49e:	5d                   	pop    %ebp
 49f:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4a0:	bf 25 00 00 00       	mov    $0x25,%edi
 4a5:	e9 72 ff ff ff       	jmp    41c <printf+0x40>
 4aa:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4ac:	83 ec 0c             	sub    $0xc,%esp
 4af:	6a 00                	push   $0x0
 4b1:	b9 10 00 00 00       	mov    $0x10,%ecx
 4b6:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4b9:	8b 17                	mov    (%edi),%edx
 4bb:	89 f0                	mov    %esi,%eax
 4bd:	e8 a2 fe ff ff       	call   364 <printint>
        ap++;
 4c2:	89 f8                	mov    %edi,%eax
 4c4:	83 c0 04             	add    $0x4,%eax
 4c7:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4ca:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4cd:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 4cf:	e9 48 ff ff ff       	jmp    41c <printf+0x40>
      } else if(c == 's'){
        s = (char*)*ap;
 4d4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4d7:	8b 38                	mov    (%eax),%edi
        ap++;
 4d9:	83 c0 04             	add    $0x4,%eax
 4dc:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 4df:	85 ff                	test   %edi,%edi
 4e1:	74 5c                	je     53f <printf+0x163>
          s = "(null)";
        while(*s != 0){
 4e3:	8a 07                	mov    (%edi),%al
 4e5:	84 c0                	test   %al,%al
 4e7:	74 1d                	je     506 <printf+0x12a>
 4e9:	8d 76 00             	lea    0x0(%esi),%esi
 4ec:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4ef:	50                   	push   %eax
 4f0:	6a 01                	push   $0x1
 4f2:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 4f5:	50                   	push   %eax
 4f6:	56                   	push   %esi
 4f7:	e8 df fd ff ff       	call   2db <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 4fc:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4fd:	8a 07                	mov    (%edi),%al
 4ff:	83 c4 10             	add    $0x10,%esp
 502:	84 c0                	test   %al,%al
 504:	75 e6                	jne    4ec <printf+0x110>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 506:	31 ff                	xor    %edi,%edi
 508:	e9 0f ff ff ff       	jmp    41c <printf+0x40>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 50d:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 510:	8b 07                	mov    (%edi),%eax
 512:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 515:	51                   	push   %ecx
 516:	6a 01                	push   $0x1
 518:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 51b:	50                   	push   %eax
 51c:	56                   	push   %esi
 51d:	e8 b9 fd ff ff       	call   2db <write>
 522:	eb 9e                	jmp    4c2 <printf+0xe6>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 524:	83 ec 0c             	sub    $0xc,%esp
 527:	6a 01                	push   $0x1
 529:	b9 0a 00 00 00       	mov    $0xa,%ecx
 52e:	eb 86                	jmp    4b6 <printf+0xda>
 530:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 534:	52                   	push   %edx
 535:	6a 01                	push   $0x1
 537:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 53a:	e9 44 ff ff ff       	jmp    483 <printf+0xa7>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 53f:	bf d9 06 00 00       	mov    $0x6d9,%edi
 544:	eb 9d                	jmp    4e3 <printf+0x107>
 546:	66 90                	xchg   %ax,%ax

00000548 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 548:	55                   	push   %ebp
 549:	89 e5                	mov    %esp,%ebp
 54b:	57                   	push   %edi
 54c:	56                   	push   %esi
 54d:	53                   	push   %ebx
 54e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 551:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 554:	a1 74 09 00 00       	mov    0x974,%eax
 559:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 55c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 55e:	39 c8                	cmp    %ecx,%eax
 560:	73 2e                	jae    590 <free+0x48>
 562:	39 d1                	cmp    %edx,%ecx
 564:	72 04                	jb     56a <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 566:	39 d0                	cmp    %edx,%eax
 568:	72 2e                	jb     598 <free+0x50>
      break;
  if(bp + bp->s.size == p->s.ptr){
 56a:	8b 73 fc             	mov    -0x4(%ebx),%esi
 56d:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 570:	39 d7                	cmp    %edx,%edi
 572:	74 28                	je     59c <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 574:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 577:	8b 50 04             	mov    0x4(%eax),%edx
 57a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 57d:	39 f1                	cmp    %esi,%ecx
 57f:	74 32                	je     5b3 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 581:	89 08                	mov    %ecx,(%eax)
  freep = p;
 583:	a3 74 09 00 00       	mov    %eax,0x974
}
 588:	5b                   	pop    %ebx
 589:	5e                   	pop    %esi
 58a:	5f                   	pop    %edi
 58b:	5d                   	pop    %ebp
 58c:	c3                   	ret    
 58d:	8d 76 00             	lea    0x0(%esi),%esi
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 590:	39 d0                	cmp    %edx,%eax
 592:	72 04                	jb     598 <free+0x50>
 594:	39 d1                	cmp    %edx,%ecx
 596:	72 d2                	jb     56a <free+0x22>
static Header base;
static Header *freep;

void
free(void *ap)
{
 598:	89 d0                	mov    %edx,%eax
 59a:	eb c0                	jmp    55c <free+0x14>
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 59c:	03 72 04             	add    0x4(%edx),%esi
 59f:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5a2:	8b 10                	mov    (%eax),%edx
 5a4:	8b 12                	mov    (%edx),%edx
 5a6:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5a9:	8b 50 04             	mov    0x4(%eax),%edx
 5ac:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5af:	39 f1                	cmp    %esi,%ecx
 5b1:	75 ce                	jne    581 <free+0x39>
    p->s.size += bp->s.size;
 5b3:	03 53 fc             	add    -0x4(%ebx),%edx
 5b6:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5b9:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5bc:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 5be:	a3 74 09 00 00       	mov    %eax,0x974
}
 5c3:	5b                   	pop    %ebx
 5c4:	5e                   	pop    %esi
 5c5:	5f                   	pop    %edi
 5c6:	5d                   	pop    %ebp
 5c7:	c3                   	ret    

000005c8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5c8:	55                   	push   %ebp
 5c9:	89 e5                	mov    %esp,%ebp
 5cb:	57                   	push   %edi
 5cc:	56                   	push   %esi
 5cd:	53                   	push   %ebx
 5ce:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5d1:	8b 45 08             	mov    0x8(%ebp),%eax
 5d4:	8d 70 07             	lea    0x7(%eax),%esi
 5d7:	c1 ee 03             	shr    $0x3,%esi
 5da:	46                   	inc    %esi
  if((prevp = freep) == 0){
 5db:	8b 15 74 09 00 00    	mov    0x974,%edx
 5e1:	85 d2                	test   %edx,%edx
 5e3:	0f 84 99 00 00 00    	je     682 <malloc+0xba>
 5e9:	8b 02                	mov    (%edx),%eax
 5eb:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 5ee:	39 ce                	cmp    %ecx,%esi
 5f0:	76 62                	jbe    654 <malloc+0x8c>
 5f2:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 5f9:	eb 0a                	jmp    605 <malloc+0x3d>
 5fb:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5fc:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 5fe:	8b 48 04             	mov    0x4(%eax),%ecx
 601:	39 ce                	cmp    %ecx,%esi
 603:	76 4f                	jbe    654 <malloc+0x8c>
 605:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 607:	3b 05 74 09 00 00    	cmp    0x974,%eax
 60d:	75 ed                	jne    5fc <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 60f:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 615:	77 5d                	ja     674 <malloc+0xac>
 617:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 61c:	bf 00 10 00 00       	mov    $0x1000,%edi
  p = sbrk(nu * sizeof(Header));
 621:	83 ec 0c             	sub    $0xc,%esp
 624:	50                   	push   %eax
 625:	e8 19 fd ff ff       	call   343 <sbrk>
  if(p == (char*)-1)
 62a:	83 c4 10             	add    $0x10,%esp
 62d:	83 f8 ff             	cmp    $0xffffffff,%eax
 630:	74 1c                	je     64e <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 632:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 635:	83 ec 0c             	sub    $0xc,%esp
 638:	83 c0 08             	add    $0x8,%eax
 63b:	50                   	push   %eax
 63c:	e8 07 ff ff ff       	call   548 <free>
  return freep;
 641:	8b 15 74 09 00 00    	mov    0x974,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 647:	83 c4 10             	add    $0x10,%esp
 64a:	85 d2                	test   %edx,%edx
 64c:	75 ae                	jne    5fc <malloc+0x34>
        return 0;
 64e:	31 c0                	xor    %eax,%eax
 650:	eb 1a                	jmp    66c <malloc+0xa4>
 652:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 654:	39 ce                	cmp    %ecx,%esi
 656:	74 24                	je     67c <malloc+0xb4>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 658:	29 f1                	sub    %esi,%ecx
 65a:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 65d:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 660:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
 663:	89 15 74 09 00 00    	mov    %edx,0x974
      return (void*)(p + 1);
 669:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 66c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 66f:	5b                   	pop    %ebx
 670:	5e                   	pop    %esi
 671:	5f                   	pop    %edi
 672:	5d                   	pop    %ebp
 673:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 674:	89 d8                	mov    %ebx,%eax
 676:	89 f7                	mov    %esi,%edi
 678:	eb a7                	jmp    621 <malloc+0x59>
 67a:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 67c:	8b 08                	mov    (%eax),%ecx
 67e:	89 0a                	mov    %ecx,(%edx)
 680:	eb e1                	jmp    663 <malloc+0x9b>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 682:	c7 05 74 09 00 00 78 	movl   $0x978,0x974
 689:	09 00 00 
 68c:	c7 05 78 09 00 00 78 	movl   $0x978,0x978
 693:	09 00 00 
    base.s.size = 0;
 696:	c7 05 7c 09 00 00 00 	movl   $0x0,0x97c
 69d:	00 00 00 
 6a0:	b8 78 09 00 00       	mov    $0x978,%eax
 6a5:	e9 48 ff ff ff       	jmp    5f2 <malloc+0x2a>
