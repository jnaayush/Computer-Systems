
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
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
  11:	83 ec 18             	sub    $0x18,%esp
  14:	8b 39                	mov    (%ecx),%edi
  16:	8b 59 04             	mov    0x4(%ecx),%ebx
  int fd, i;

  if(argc <= 1){
  19:	83 ff 01             	cmp    $0x1,%edi
  1c:	7e 58                	jle    76 <main+0x76>
  1e:	83 c3 04             	add    $0x4,%ebx
  21:	be 01 00 00 00       	mov    $0x1,%esi
  26:	66 90                	xchg   %ax,%ax
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  28:	83 ec 08             	sub    $0x8,%esp
  2b:	6a 00                	push   $0x0
  2d:	ff 33                	pushl  (%ebx)
  2f:	e8 af 02 00 00       	call   2e3 <open>
  34:	83 c4 10             	add    $0x10,%esp
  37:	85 c0                	test   %eax,%eax
  39:	78 27                	js     62 <main+0x62>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  3b:	83 ec 0c             	sub    $0xc,%esp
  3e:	50                   	push   %eax
  3f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  42:	e8 41 00 00 00       	call   88 <cat>
    close(fd);
  47:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  4a:	89 04 24             	mov    %eax,(%esp)
  4d:	e8 79 02 00 00       	call   2cb <close>
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
  52:	46                   	inc    %esi
  53:	83 c3 04             	add    $0x4,%ebx
  56:	83 c4 10             	add    $0x10,%esp
  59:	39 fe                	cmp    %edi,%esi
  5b:	75 cb                	jne    28 <main+0x28>
      exit();
    }
    cat(fd);
    close(fd);
  }
  exit();
  5d:	e8 41 02 00 00       	call   2a3 <exit>
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
  62:	50                   	push   %eax
  63:	ff 33                	pushl  (%ebx)
  65:	68 b7 06 00 00       	push   $0x6b7
  6a:	6a 01                	push   $0x1
  6c:	e8 53 03 00 00       	call   3c4 <printf>
      exit();
  71:	e8 2d 02 00 00       	call   2a3 <exit>
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
    cat(0);
  76:	83 ec 0c             	sub    $0xc,%esp
  79:	6a 00                	push   $0x0
  7b:	e8 08 00 00 00       	call   88 <cat>
    exit();
  80:	e8 1e 02 00 00       	call   2a3 <exit>
  85:	66 90                	xchg   %ax,%ax
  87:	90                   	nop

00000088 <cat>:

char buf[512];

void
cat(int fd)
{
  88:	55                   	push   %ebp
  89:	89 e5                	mov    %esp,%ebp
  8b:	56                   	push   %esi
  8c:	53                   	push   %ebx
  8d:	8b 75 08             	mov    0x8(%ebp),%esi
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  90:	eb 17                	jmp    a9 <cat+0x21>
  92:	66 90                	xchg   %ax,%ax
    if (write(1, buf, n) != n) {
  94:	52                   	push   %edx
  95:	53                   	push   %ebx
  96:	68 c0 09 00 00       	push   $0x9c0
  9b:	6a 01                	push   $0x1
  9d:	e8 21 02 00 00       	call   2c3 <write>
  a2:	83 c4 10             	add    $0x10,%esp
  a5:	39 d8                	cmp    %ebx,%eax
  a7:	75 24                	jne    cd <cat+0x45>
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  a9:	50                   	push   %eax
  aa:	68 00 02 00 00       	push   $0x200
  af:	68 c0 09 00 00       	push   $0x9c0
  b4:	56                   	push   %esi
  b5:	e8 01 02 00 00       	call   2bb <read>
  ba:	89 c3                	mov    %eax,%ebx
  bc:	83 c4 10             	add    $0x10,%esp
  bf:	83 f8 00             	cmp    $0x0,%eax
  c2:	7f d0                	jg     94 <cat+0xc>
    if (write(1, buf, n) != n) {
      printf(1, "cat: write error\n");
      exit();
    }
  }
  if(n < 0){
  c4:	75 1b                	jne    e1 <cat+0x59>
    printf(1, "cat: read error\n");
    exit();
  }
}
  c6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  c9:	5b                   	pop    %ebx
  ca:	5e                   	pop    %esi
  cb:	5d                   	pop    %ebp
  cc:	c3                   	ret    
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
    if (write(1, buf, n) != n) {
      printf(1, "cat: write error\n");
  cd:	83 ec 08             	sub    $0x8,%esp
  d0:	68 94 06 00 00       	push   $0x694
  d5:	6a 01                	push   $0x1
  d7:	e8 e8 02 00 00       	call   3c4 <printf>
      exit();
  dc:	e8 c2 01 00 00       	call   2a3 <exit>
    }
  }
  if(n < 0){
    printf(1, "cat: read error\n");
  e1:	83 ec 08             	sub    $0x8,%esp
  e4:	68 a6 06 00 00       	push   $0x6a6
  e9:	6a 01                	push   $0x1
  eb:	e8 d4 02 00 00       	call   3c4 <printf>
    exit();
  f0:	e8 ae 01 00 00       	call   2a3 <exit>
  f5:	66 90                	xchg   %ax,%ax
  f7:	90                   	nop

000000f8 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  f8:	55                   	push   %ebp
  f9:	89 e5                	mov    %esp,%ebp
  fb:	53                   	push   %ebx
  fc:	8b 45 08             	mov    0x8(%ebp),%eax
  ff:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 102:	89 c2                	mov    %eax,%edx
 104:	42                   	inc    %edx
 105:	41                   	inc    %ecx
 106:	8a 59 ff             	mov    -0x1(%ecx),%bl
 109:	88 5a ff             	mov    %bl,-0x1(%edx)
 10c:	84 db                	test   %bl,%bl
 10e:	75 f4                	jne    104 <strcpy+0xc>
    ;
  return os;
}
 110:	5b                   	pop    %ebx
 111:	5d                   	pop    %ebp
 112:	c3                   	ret    
 113:	90                   	nop

00000114 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 114:	55                   	push   %ebp
 115:	89 e5                	mov    %esp,%ebp
 117:	56                   	push   %esi
 118:	53                   	push   %ebx
 119:	8b 55 08             	mov    0x8(%ebp),%edx
 11c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 11f:	0f b6 02             	movzbl (%edx),%eax
 122:	0f b6 0b             	movzbl (%ebx),%ecx
 125:	84 c0                	test   %al,%al
 127:	75 14                	jne    13d <strcmp+0x29>
 129:	eb 1d                	jmp    148 <strcmp+0x34>
 12b:	90                   	nop
    p++, q++;
 12c:	42                   	inc    %edx
 12d:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 130:	0f b6 02             	movzbl (%edx),%eax
 133:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 137:	84 c0                	test   %al,%al
 139:	74 0d                	je     148 <strcmp+0x34>
 13b:	89 f3                	mov    %esi,%ebx
 13d:	38 c8                	cmp    %cl,%al
 13f:	74 eb                	je     12c <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 141:	29 c8                	sub    %ecx,%eax
}
 143:	5b                   	pop    %ebx
 144:	5e                   	pop    %esi
 145:	5d                   	pop    %ebp
 146:	c3                   	ret    
 147:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 148:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 14a:	29 c8                	sub    %ecx,%eax
}
 14c:	5b                   	pop    %ebx
 14d:	5e                   	pop    %esi
 14e:	5d                   	pop    %ebp
 14f:	c3                   	ret    

00000150 <strlen>:

uint
strlen(char *s)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 156:	80 39 00             	cmpb   $0x0,(%ecx)
 159:	74 10                	je     16b <strlen+0x1b>
 15b:	31 d2                	xor    %edx,%edx
 15d:	8d 76 00             	lea    0x0(%esi),%esi
 160:	42                   	inc    %edx
 161:	89 d0                	mov    %edx,%eax
 163:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 167:	75 f7                	jne    160 <strlen+0x10>
    ;
  return n;
}
 169:	5d                   	pop    %ebp
 16a:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 16b:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 16d:	5d                   	pop    %ebp
 16e:	c3                   	ret    
 16f:	90                   	nop

00000170 <memset>:

void*
memset(void *dst, int c, uint n)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	57                   	push   %edi
 174:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 177:	89 d7                	mov    %edx,%edi
 179:	8b 4d 10             	mov    0x10(%ebp),%ecx
 17c:	8b 45 0c             	mov    0xc(%ebp),%eax
 17f:	fc                   	cld    
 180:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 182:	89 d0                	mov    %edx,%eax
 184:	5f                   	pop    %edi
 185:	5d                   	pop    %ebp
 186:	c3                   	ret    
 187:	90                   	nop

00000188 <strchr>:

char*
strchr(const char *s, char c)
{
 188:	55                   	push   %ebp
 189:	89 e5                	mov    %esp,%ebp
 18b:	53                   	push   %ebx
 18c:	8b 45 08             	mov    0x8(%ebp),%eax
 18f:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 192:	8a 18                	mov    (%eax),%bl
 194:	84 db                	test   %bl,%bl
 196:	74 13                	je     1ab <strchr+0x23>
 198:	88 d1                	mov    %dl,%cl
    if(*s == c)
 19a:	38 d3                	cmp    %dl,%bl
 19c:	75 06                	jne    1a4 <strchr+0x1c>
 19e:	eb 0d                	jmp    1ad <strchr+0x25>
 1a0:	38 ca                	cmp    %cl,%dl
 1a2:	74 09                	je     1ad <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1a4:	40                   	inc    %eax
 1a5:	8a 10                	mov    (%eax),%dl
 1a7:	84 d2                	test   %dl,%dl
 1a9:	75 f5                	jne    1a0 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 1ab:	31 c0                	xor    %eax,%eax
}
 1ad:	5b                   	pop    %ebx
 1ae:	5d                   	pop    %ebp
 1af:	c3                   	ret    

000001b0 <gets>:

char*
gets(char *buf, int max)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	57                   	push   %edi
 1b4:	56                   	push   %esi
 1b5:	53                   	push   %ebx
 1b6:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1b9:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 1bb:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1be:	eb 26                	jmp    1e6 <gets+0x36>
    cc = read(0, &c, 1);
 1c0:	50                   	push   %eax
 1c1:	6a 01                	push   $0x1
 1c3:	57                   	push   %edi
 1c4:	6a 00                	push   $0x0
 1c6:	e8 f0 00 00 00       	call   2bb <read>
    if(cc < 1)
 1cb:	83 c4 10             	add    $0x10,%esp
 1ce:	85 c0                	test   %eax,%eax
 1d0:	7e 1c                	jle    1ee <gets+0x3e>
      break;
    buf[i++] = c;
 1d2:	8a 45 e7             	mov    -0x19(%ebp),%al
 1d5:	8b 55 08             	mov    0x8(%ebp),%edx
 1d8:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
 1dc:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 1de:	3c 0a                	cmp    $0xa,%al
 1e0:	74 0c                	je     1ee <gets+0x3e>
 1e2:	3c 0d                	cmp    $0xd,%al
 1e4:	74 08                	je     1ee <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e6:	8d 5e 01             	lea    0x1(%esi),%ebx
 1e9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1ec:	7c d2                	jl     1c0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1ee:	8b 45 08             	mov    0x8(%ebp),%eax
 1f1:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1f8:	5b                   	pop    %ebx
 1f9:	5e                   	pop    %esi
 1fa:	5f                   	pop    %edi
 1fb:	5d                   	pop    %ebp
 1fc:	c3                   	ret    
 1fd:	8d 76 00             	lea    0x0(%esi),%esi

00000200 <stat>:

int
stat(char *n, struct stat *st)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	56                   	push   %esi
 204:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 205:	83 ec 08             	sub    $0x8,%esp
 208:	6a 00                	push   $0x0
 20a:	ff 75 08             	pushl  0x8(%ebp)
 20d:	e8 d1 00 00 00       	call   2e3 <open>
 212:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 214:	83 c4 10             	add    $0x10,%esp
 217:	85 c0                	test   %eax,%eax
 219:	78 25                	js     240 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 21b:	83 ec 08             	sub    $0x8,%esp
 21e:	ff 75 0c             	pushl  0xc(%ebp)
 221:	50                   	push   %eax
 222:	e8 d4 00 00 00       	call   2fb <fstat>
 227:	89 c6                	mov    %eax,%esi
  close(fd);
 229:	89 1c 24             	mov    %ebx,(%esp)
 22c:	e8 9a 00 00 00       	call   2cb <close>
  return r;
 231:	83 c4 10             	add    $0x10,%esp
 234:	89 f0                	mov    %esi,%eax
}
 236:	8d 65 f8             	lea    -0x8(%ebp),%esp
 239:	5b                   	pop    %ebx
 23a:	5e                   	pop    %esi
 23b:	5d                   	pop    %ebp
 23c:	c3                   	ret    
 23d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 240:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 245:	eb ef                	jmp    236 <stat+0x36>
 247:	90                   	nop

00000248 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 248:	55                   	push   %ebp
 249:	89 e5                	mov    %esp,%ebp
 24b:	53                   	push   %ebx
 24c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 24f:	0f be 11             	movsbl (%ecx),%edx
 252:	8d 42 d0             	lea    -0x30(%edx),%eax
 255:	3c 09                	cmp    $0x9,%al
 257:	b8 00 00 00 00       	mov    $0x0,%eax
 25c:	77 15                	ja     273 <atoi+0x2b>
 25e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 260:	41                   	inc    %ecx
 261:	8d 04 80             	lea    (%eax,%eax,4),%eax
 264:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 268:	0f be 11             	movsbl (%ecx),%edx
 26b:	8d 5a d0             	lea    -0x30(%edx),%ebx
 26e:	80 fb 09             	cmp    $0x9,%bl
 271:	76 ed                	jbe    260 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 273:	5b                   	pop    %ebx
 274:	5d                   	pop    %ebp
 275:	c3                   	ret    
 276:	66 90                	xchg   %ax,%ax

00000278 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 278:	55                   	push   %ebp
 279:	89 e5                	mov    %esp,%ebp
 27b:	56                   	push   %esi
 27c:	53                   	push   %ebx
 27d:	8b 45 08             	mov    0x8(%ebp),%eax
 280:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 283:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 286:	31 d2                	xor    %edx,%edx
 288:	85 f6                	test   %esi,%esi
 28a:	7e 0b                	jle    297 <memmove+0x1f>
    *dst++ = *src++;
 28c:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 28f:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 292:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 293:	39 f2                	cmp    %esi,%edx
 295:	75 f5                	jne    28c <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 297:	5b                   	pop    %ebx
 298:	5e                   	pop    %esi
 299:	5d                   	pop    %ebp
 29a:	c3                   	ret    

0000029b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 29b:	b8 01 00 00 00       	mov    $0x1,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret    

000002a3 <exit>:
SYSCALL(exit)
 2a3:	b8 02 00 00 00       	mov    $0x2,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret    

000002ab <wait>:
SYSCALL(wait)
 2ab:	b8 03 00 00 00       	mov    $0x3,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret    

000002b3 <pipe>:
SYSCALL(pipe)
 2b3:	b8 04 00 00 00       	mov    $0x4,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret    

000002bb <read>:
SYSCALL(read)
 2bb:	b8 05 00 00 00       	mov    $0x5,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <write>:
SYSCALL(write)
 2c3:	b8 10 00 00 00       	mov    $0x10,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <close>:
SYSCALL(close)
 2cb:	b8 15 00 00 00       	mov    $0x15,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <kill>:
SYSCALL(kill)
 2d3:	b8 06 00 00 00       	mov    $0x6,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <exec>:
SYSCALL(exec)
 2db:	b8 07 00 00 00       	mov    $0x7,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <open>:
SYSCALL(open)
 2e3:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <mknod>:
SYSCALL(mknod)
 2eb:	b8 11 00 00 00       	mov    $0x11,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <unlink>:
SYSCALL(unlink)
 2f3:	b8 12 00 00 00       	mov    $0x12,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <fstat>:
SYSCALL(fstat)
 2fb:	b8 08 00 00 00       	mov    $0x8,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <link>:
SYSCALL(link)
 303:	b8 13 00 00 00       	mov    $0x13,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <mkdir>:
SYSCALL(mkdir)
 30b:	b8 14 00 00 00       	mov    $0x14,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <chdir>:
SYSCALL(chdir)
 313:	b8 09 00 00 00       	mov    $0x9,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <dup>:
SYSCALL(dup)
 31b:	b8 0a 00 00 00       	mov    $0xa,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <getpid>:
SYSCALL(getpid)
 323:	b8 0b 00 00 00       	mov    $0xb,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <sbrk>:
SYSCALL(sbrk)
 32b:	b8 0c 00 00 00       	mov    $0xc,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <sleep>:
SYSCALL(sleep)
 333:	b8 0d 00 00 00       	mov    $0xd,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <uptime>:
SYSCALL(uptime)
 33b:	b8 0e 00 00 00       	mov    $0xe,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <mike>:
SYSCALL(mike)
 343:	b8 16 00 00 00       	mov    $0x16,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    
 34b:	90                   	nop

0000034c <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 34c:	55                   	push   %ebp
 34d:	89 e5                	mov    %esp,%ebp
 34f:	57                   	push   %edi
 350:	56                   	push   %esi
 351:	53                   	push   %ebx
 352:	83 ec 3c             	sub    $0x3c,%esp
 355:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 357:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 359:	8b 5d 08             	mov    0x8(%ebp),%ebx
 35c:	85 db                	test   %ebx,%ebx
 35e:	74 04                	je     364 <printint+0x18>
 360:	85 d2                	test   %edx,%edx
 362:	78 53                	js     3b7 <printint+0x6b>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 364:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 36b:	31 db                	xor    %ebx,%ebx
 36d:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 370:	43                   	inc    %ebx
 371:	31 d2                	xor    %edx,%edx
 373:	f7 f1                	div    %ecx
 375:	8a 92 d4 06 00 00    	mov    0x6d4(%edx),%dl
 37b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 37e:	85 c0                	test   %eax,%eax
 380:	75 ee                	jne    370 <printint+0x24>
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 382:	89 d8                	mov    %ebx,%eax
  }while((x /= base) != 0);
  if(neg)
 384:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 387:	85 d2                	test   %edx,%edx
 389:	74 06                	je     391 <printint+0x45>
    buf[i++] = '-';
 38b:	43                   	inc    %ebx
 38c:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 391:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 395:	8d 76 00             	lea    0x0(%esi),%esi
 398:	8a 03                	mov    (%ebx),%al
 39a:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 39d:	50                   	push   %eax
 39e:	6a 01                	push   $0x1
 3a0:	56                   	push   %esi
 3a1:	57                   	push   %edi
 3a2:	e8 1c ff ff ff       	call   2c3 <write>
 3a7:	4b                   	dec    %ebx
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3a8:	83 c4 10             	add    $0x10,%esp
 3ab:	39 f3                	cmp    %esi,%ebx
 3ad:	75 e9                	jne    398 <printint+0x4c>
    putc(fd, buf[i]);
}
 3af:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3b2:	5b                   	pop    %ebx
 3b3:	5e                   	pop    %esi
 3b4:	5f                   	pop    %edi
 3b5:	5d                   	pop    %ebp
 3b6:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3b7:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 3b9:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 3c0:	eb a9                	jmp    36b <printint+0x1f>
 3c2:	66 90                	xchg   %ax,%ax

000003c4 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3c4:	55                   	push   %ebp
 3c5:	89 e5                	mov    %esp,%ebp
 3c7:	57                   	push   %edi
 3c8:	56                   	push   %esi
 3c9:	53                   	push   %ebx
 3ca:	83 ec 2c             	sub    $0x2c,%esp
 3cd:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3d0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 3d3:	8a 13                	mov    (%ebx),%dl
 3d5:	84 d2                	test   %dl,%dl
 3d7:	0f 84 a3 00 00 00    	je     480 <printf+0xbc>
 3dd:	43                   	inc    %ebx
 3de:	8d 45 10             	lea    0x10(%ebp),%eax
 3e1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 3e4:	31 ff                	xor    %edi,%edi
 3e6:	eb 24                	jmp    40c <printf+0x48>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3e8:	83 fa 25             	cmp    $0x25,%edx
 3eb:	0f 84 97 00 00 00    	je     488 <printf+0xc4>
        state = '%';
      } else {
        putc(fd, c);
 3f1:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3f4:	50                   	push   %eax
 3f5:	6a 01                	push   $0x1
 3f7:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 3fa:	50                   	push   %eax
 3fb:	56                   	push   %esi
 3fc:	e8 c2 fe ff ff       	call   2c3 <write>
 401:	83 c4 10             	add    $0x10,%esp
 404:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 405:	8a 53 ff             	mov    -0x1(%ebx),%dl
 408:	84 d2                	test   %dl,%dl
 40a:	74 74                	je     480 <printf+0xbc>
    c = fmt[i] & 0xff;
 40c:	0f be c2             	movsbl %dl,%eax
 40f:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
 412:	85 ff                	test   %edi,%edi
 414:	74 d2                	je     3e8 <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 416:	83 ff 25             	cmp    $0x25,%edi
 419:	75 e9                	jne    404 <printf+0x40>
      if(c == 'd'){
 41b:	83 fa 64             	cmp    $0x64,%edx
 41e:	0f 84 e8 00 00 00    	je     50c <printf+0x148>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 424:	25 f7 00 00 00       	and    $0xf7,%eax
 429:	83 f8 70             	cmp    $0x70,%eax
 42c:	74 66                	je     494 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 42e:	83 fa 73             	cmp    $0x73,%edx
 431:	0f 84 85 00 00 00    	je     4bc <printf+0xf8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 437:	83 fa 63             	cmp    $0x63,%edx
 43a:	0f 84 b5 00 00 00    	je     4f5 <printf+0x131>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 440:	83 fa 25             	cmp    $0x25,%edx
 443:	0f 84 cf 00 00 00    	je     518 <printf+0x154>
 449:	89 55 d0             	mov    %edx,-0x30(%ebp)
 44c:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 450:	50                   	push   %eax
 451:	6a 01                	push   $0x1
 453:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 456:	50                   	push   %eax
 457:	56                   	push   %esi
 458:	e8 66 fe ff ff       	call   2c3 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 45d:	8b 55 d0             	mov    -0x30(%ebp),%edx
 460:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 463:	83 c4 0c             	add    $0xc,%esp
 466:	6a 01                	push   $0x1
 468:	8d 45 e7             	lea    -0x19(%ebp),%eax
 46b:	50                   	push   %eax
 46c:	56                   	push   %esi
 46d:	e8 51 fe ff ff       	call   2c3 <write>
 472:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 475:	31 ff                	xor    %edi,%edi
 477:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 478:	8a 53 ff             	mov    -0x1(%ebx),%dl
 47b:	84 d2                	test   %dl,%dl
 47d:	75 8d                	jne    40c <printf+0x48>
 47f:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 480:	8d 65 f4             	lea    -0xc(%ebp),%esp
 483:	5b                   	pop    %ebx
 484:	5e                   	pop    %esi
 485:	5f                   	pop    %edi
 486:	5d                   	pop    %ebp
 487:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 488:	bf 25 00 00 00       	mov    $0x25,%edi
 48d:	e9 72 ff ff ff       	jmp    404 <printf+0x40>
 492:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 494:	83 ec 0c             	sub    $0xc,%esp
 497:	6a 00                	push   $0x0
 499:	b9 10 00 00 00       	mov    $0x10,%ecx
 49e:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4a1:	8b 17                	mov    (%edi),%edx
 4a3:	89 f0                	mov    %esi,%eax
 4a5:	e8 a2 fe ff ff       	call   34c <printint>
        ap++;
 4aa:	89 f8                	mov    %edi,%eax
 4ac:	83 c0 04             	add    $0x4,%eax
 4af:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4b2:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4b5:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 4b7:	e9 48 ff ff ff       	jmp    404 <printf+0x40>
      } else if(c == 's'){
        s = (char*)*ap;
 4bc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4bf:	8b 38                	mov    (%eax),%edi
        ap++;
 4c1:	83 c0 04             	add    $0x4,%eax
 4c4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 4c7:	85 ff                	test   %edi,%edi
 4c9:	74 5c                	je     527 <printf+0x163>
          s = "(null)";
        while(*s != 0){
 4cb:	8a 07                	mov    (%edi),%al
 4cd:	84 c0                	test   %al,%al
 4cf:	74 1d                	je     4ee <printf+0x12a>
 4d1:	8d 76 00             	lea    0x0(%esi),%esi
 4d4:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4d7:	50                   	push   %eax
 4d8:	6a 01                	push   $0x1
 4da:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 4dd:	50                   	push   %eax
 4de:	56                   	push   %esi
 4df:	e8 df fd ff ff       	call   2c3 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 4e4:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4e5:	8a 07                	mov    (%edi),%al
 4e7:	83 c4 10             	add    $0x10,%esp
 4ea:	84 c0                	test   %al,%al
 4ec:	75 e6                	jne    4d4 <printf+0x110>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4ee:	31 ff                	xor    %edi,%edi
 4f0:	e9 0f ff ff ff       	jmp    404 <printf+0x40>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 4f5:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4f8:	8b 07                	mov    (%edi),%eax
 4fa:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4fd:	51                   	push   %ecx
 4fe:	6a 01                	push   $0x1
 500:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 503:	50                   	push   %eax
 504:	56                   	push   %esi
 505:	e8 b9 fd ff ff       	call   2c3 <write>
 50a:	eb 9e                	jmp    4aa <printf+0xe6>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 50c:	83 ec 0c             	sub    $0xc,%esp
 50f:	6a 01                	push   $0x1
 511:	b9 0a 00 00 00       	mov    $0xa,%ecx
 516:	eb 86                	jmp    49e <printf+0xda>
 518:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 51c:	52                   	push   %edx
 51d:	6a 01                	push   $0x1
 51f:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 522:	e9 44 ff ff ff       	jmp    46b <printf+0xa7>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 527:	bf cc 06 00 00       	mov    $0x6cc,%edi
 52c:	eb 9d                	jmp    4cb <printf+0x107>
 52e:	66 90                	xchg   %ax,%ax

00000530 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	57                   	push   %edi
 534:	56                   	push   %esi
 535:	53                   	push   %ebx
 536:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 539:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 53c:	a1 a0 09 00 00       	mov    0x9a0,%eax
 541:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 544:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 546:	39 c8                	cmp    %ecx,%eax
 548:	73 2e                	jae    578 <free+0x48>
 54a:	39 d1                	cmp    %edx,%ecx
 54c:	72 04                	jb     552 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 54e:	39 d0                	cmp    %edx,%eax
 550:	72 2e                	jb     580 <free+0x50>
      break;
  if(bp + bp->s.size == p->s.ptr){
 552:	8b 73 fc             	mov    -0x4(%ebx),%esi
 555:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 558:	39 d7                	cmp    %edx,%edi
 55a:	74 28                	je     584 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 55c:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 55f:	8b 50 04             	mov    0x4(%eax),%edx
 562:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 565:	39 f1                	cmp    %esi,%ecx
 567:	74 32                	je     59b <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 569:	89 08                	mov    %ecx,(%eax)
  freep = p;
 56b:	a3 a0 09 00 00       	mov    %eax,0x9a0
}
 570:	5b                   	pop    %ebx
 571:	5e                   	pop    %esi
 572:	5f                   	pop    %edi
 573:	5d                   	pop    %ebp
 574:	c3                   	ret    
 575:	8d 76 00             	lea    0x0(%esi),%esi
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 578:	39 d0                	cmp    %edx,%eax
 57a:	72 04                	jb     580 <free+0x50>
 57c:	39 d1                	cmp    %edx,%ecx
 57e:	72 d2                	jb     552 <free+0x22>
static Header base;
static Header *freep;

void
free(void *ap)
{
 580:	89 d0                	mov    %edx,%eax
 582:	eb c0                	jmp    544 <free+0x14>
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 584:	03 72 04             	add    0x4(%edx),%esi
 587:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 58a:	8b 10                	mov    (%eax),%edx
 58c:	8b 12                	mov    (%edx),%edx
 58e:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 591:	8b 50 04             	mov    0x4(%eax),%edx
 594:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 597:	39 f1                	cmp    %esi,%ecx
 599:	75 ce                	jne    569 <free+0x39>
    p->s.size += bp->s.size;
 59b:	03 53 fc             	add    -0x4(%ebx),%edx
 59e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5a1:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5a4:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 5a6:	a3 a0 09 00 00       	mov    %eax,0x9a0
}
 5ab:	5b                   	pop    %ebx
 5ac:	5e                   	pop    %esi
 5ad:	5f                   	pop    %edi
 5ae:	5d                   	pop    %ebp
 5af:	c3                   	ret    

000005b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	57                   	push   %edi
 5b4:	56                   	push   %esi
 5b5:	53                   	push   %ebx
 5b6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5b9:	8b 45 08             	mov    0x8(%ebp),%eax
 5bc:	8d 70 07             	lea    0x7(%eax),%esi
 5bf:	c1 ee 03             	shr    $0x3,%esi
 5c2:	46                   	inc    %esi
  if((prevp = freep) == 0){
 5c3:	8b 15 a0 09 00 00    	mov    0x9a0,%edx
 5c9:	85 d2                	test   %edx,%edx
 5cb:	0f 84 99 00 00 00    	je     66a <malloc+0xba>
 5d1:	8b 02                	mov    (%edx),%eax
 5d3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 5d6:	39 ce                	cmp    %ecx,%esi
 5d8:	76 62                	jbe    63c <malloc+0x8c>
 5da:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 5e1:	eb 0a                	jmp    5ed <malloc+0x3d>
 5e3:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5e4:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 5e6:	8b 48 04             	mov    0x4(%eax),%ecx
 5e9:	39 ce                	cmp    %ecx,%esi
 5eb:	76 4f                	jbe    63c <malloc+0x8c>
 5ed:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 5ef:	3b 05 a0 09 00 00    	cmp    0x9a0,%eax
 5f5:	75 ed                	jne    5e4 <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 5f7:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 5fd:	77 5d                	ja     65c <malloc+0xac>
 5ff:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 604:	bf 00 10 00 00       	mov    $0x1000,%edi
  p = sbrk(nu * sizeof(Header));
 609:	83 ec 0c             	sub    $0xc,%esp
 60c:	50                   	push   %eax
 60d:	e8 19 fd ff ff       	call   32b <sbrk>
  if(p == (char*)-1)
 612:	83 c4 10             	add    $0x10,%esp
 615:	83 f8 ff             	cmp    $0xffffffff,%eax
 618:	74 1c                	je     636 <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 61a:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 61d:	83 ec 0c             	sub    $0xc,%esp
 620:	83 c0 08             	add    $0x8,%eax
 623:	50                   	push   %eax
 624:	e8 07 ff ff ff       	call   530 <free>
  return freep;
 629:	8b 15 a0 09 00 00    	mov    0x9a0,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 62f:	83 c4 10             	add    $0x10,%esp
 632:	85 d2                	test   %edx,%edx
 634:	75 ae                	jne    5e4 <malloc+0x34>
        return 0;
 636:	31 c0                	xor    %eax,%eax
 638:	eb 1a                	jmp    654 <malloc+0xa4>
 63a:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 63c:	39 ce                	cmp    %ecx,%esi
 63e:	74 24                	je     664 <malloc+0xb4>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 640:	29 f1                	sub    %esi,%ecx
 642:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 645:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 648:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
 64b:	89 15 a0 09 00 00    	mov    %edx,0x9a0
      return (void*)(p + 1);
 651:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 654:	8d 65 f4             	lea    -0xc(%ebp),%esp
 657:	5b                   	pop    %ebx
 658:	5e                   	pop    %esi
 659:	5f                   	pop    %edi
 65a:	5d                   	pop    %ebp
 65b:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 65c:	89 d8                	mov    %ebx,%eax
 65e:	89 f7                	mov    %esi,%edi
 660:	eb a7                	jmp    609 <malloc+0x59>
 662:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 664:	8b 08                	mov    (%eax),%ecx
 666:	89 0a                	mov    %ecx,(%edx)
 668:	eb e1                	jmp    64b <malloc+0x9b>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 66a:	c7 05 a0 09 00 00 a4 	movl   $0x9a4,0x9a0
 671:	09 00 00 
 674:	c7 05 a4 09 00 00 a4 	movl   $0x9a4,0x9a4
 67b:	09 00 00 
    base.s.size = 0;
 67e:	c7 05 a8 09 00 00 00 	movl   $0x0,0x9a8
 685:	00 00 00 
 688:	b8 a4 09 00 00       	mov    $0x9a4,%eax
 68d:	e9 48 ff ff ff       	jmp    5da <malloc+0x2a>
