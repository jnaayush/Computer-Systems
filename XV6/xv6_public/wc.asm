
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
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
  1c:	7e 5a                	jle    78 <main+0x78>
  1e:	83 c3 04             	add    $0x4,%ebx
  21:	be 01 00 00 00       	mov    $0x1,%esi
  26:	66 90                	xchg   %ax,%ax
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  28:	83 ec 08             	sub    $0x8,%esp
  2b:	6a 00                	push   $0x0
  2d:	ff 33                	pushl  (%ebx)
  2f:	e8 0b 03 00 00       	call   33f <open>
  34:	83 c4 10             	add    $0x10,%esp
  37:	85 c0                	test   %eax,%eax
  39:	78 29                	js     64 <main+0x64>
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
  3b:	83 ec 08             	sub    $0x8,%esp
  3e:	ff 33                	pushl  (%ebx)
  40:	50                   	push   %eax
  41:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  44:	e8 43 00 00 00       	call   8c <wc>
    close(fd);
  49:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  4c:	89 04 24             	mov    %eax,(%esp)
  4f:	e8 d3 02 00 00       	call   327 <close>
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
  54:	46                   	inc    %esi
  55:	83 c3 04             	add    $0x4,%ebx
  58:	83 c4 10             	add    $0x10,%esp
  5b:	39 fe                	cmp    %edi,%esi
  5d:	75 c9                	jne    28 <main+0x28>
      exit();
    }
    wc(fd, argv[i]);
    close(fd);
  }
  exit();
  5f:	e8 9b 02 00 00       	call   2ff <exit>
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "wc: cannot open %s\n", argv[i]);
  64:	50                   	push   %eax
  65:	ff 33                	pushl  (%ebx)
  67:	68 13 07 00 00       	push   $0x713
  6c:	6a 01                	push   $0x1
  6e:	e8 ad 03 00 00       	call   420 <printf>
      exit();
  73:	e8 87 02 00 00       	call   2ff <exit>
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
    wc(0, "");
  78:	52                   	push   %edx
  79:	52                   	push   %edx
  7a:	68 05 07 00 00       	push   $0x705
  7f:	6a 00                	push   $0x0
  81:	e8 06 00 00 00       	call   8c <wc>
    exit();
  86:	e8 74 02 00 00       	call   2ff <exit>
  8b:	90                   	nop

0000008c <wc>:

char buf[512];

void
wc(int fd, char *name)
{
  8c:	55                   	push   %ebp
  8d:	89 e5                	mov    %esp,%ebp
  8f:	57                   	push   %edi
  90:	56                   	push   %esi
  91:	53                   	push   %ebx
  92:	83 ec 1c             	sub    $0x1c,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  95:	31 db                	xor    %ebx,%ebx
wc(int fd, char *name)
{
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  97:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  9e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  a5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
  ac:	50                   	push   %eax
  ad:	68 00 02 00 00       	push   $0x200
  b2:	68 20 0a 00 00       	push   $0xa20
  b7:	ff 75 08             	pushl  0x8(%ebp)
  ba:	e8 58 02 00 00       	call   317 <read>
  bf:	89 c6                	mov    %eax,%esi
  c1:	83 c4 10             	add    $0x10,%esp
  c4:	83 f8 00             	cmp    $0x0,%eax
  c7:	7e 4e                	jle    117 <wc+0x8b>
  c9:	31 ff                	xor    %edi,%edi
  cb:	eb 1f                	jmp    ec <wc+0x60>
  cd:	8d 76 00             	lea    0x0(%esi),%esi
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  d0:	83 ec 08             	sub    $0x8,%esp
  d3:	50                   	push   %eax
  d4:	68 f0 06 00 00       	push   $0x6f0
  d9:	e8 06 01 00 00       	call   1e4 <strchr>
  de:	83 c4 10             	add    $0x10,%esp
  e1:	85 c0                	test   %eax,%eax
  e3:	74 17                	je     fc <wc+0x70>
        inword = 0;
  e5:	31 db                	xor    %ebx,%ebx
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  e7:	47                   	inc    %edi
  e8:	39 f7                	cmp    %esi,%edi
  ea:	74 1e                	je     10a <wc+0x7e>
      c++;
      if(buf[i] == '\n')
  ec:	0f be 87 20 0a 00 00 	movsbl 0xa20(%edi),%eax
  f3:	3c 0a                	cmp    $0xa,%al
  f5:	75 d9                	jne    d0 <wc+0x44>
        l++;
  f7:	ff 45 e4             	incl   -0x1c(%ebp)
  fa:	eb d4                	jmp    d0 <wc+0x44>
      if(strchr(" \r\t\n\v", buf[i]))
        inword = 0;
      else if(!inword){
  fc:	85 db                	test   %ebx,%ebx
  fe:	75 10                	jne    110 <wc+0x84>
        w++;
 100:	ff 45 e0             	incl   -0x20(%ebp)
        inword = 1;
 103:	b3 01                	mov    $0x1,%bl
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
 105:	47                   	inc    %edi
 106:	39 f7                	cmp    %esi,%edi
 108:	75 e2                	jne    ec <wc+0x60>
 10a:	01 7d dc             	add    %edi,-0x24(%ebp)
 10d:	eb 9d                	jmp    ac <wc+0x20>
 10f:	90                   	nop
 110:	bb 01 00 00 00       	mov    $0x1,%ebx
 115:	eb d0                	jmp    e7 <wc+0x5b>
        w++;
        inword = 1;
      }
    }
  }
  if(n < 0){
 117:	75 26                	jne    13f <wc+0xb3>
    printf(1, "wc: read error\n");
    exit();
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
 119:	83 ec 08             	sub    $0x8,%esp
 11c:	ff 75 0c             	pushl  0xc(%ebp)
 11f:	ff 75 dc             	pushl  -0x24(%ebp)
 122:	ff 75 e0             	pushl  -0x20(%ebp)
 125:	ff 75 e4             	pushl  -0x1c(%ebp)
 128:	68 06 07 00 00       	push   $0x706
 12d:	6a 01                	push   $0x1
 12f:	e8 ec 02 00 00       	call   420 <printf>
 134:	83 c4 20             	add    $0x20,%esp
}
 137:	8d 65 f4             	lea    -0xc(%ebp),%esp
 13a:	5b                   	pop    %ebx
 13b:	5e                   	pop    %esi
 13c:	5f                   	pop    %edi
 13d:	5d                   	pop    %ebp
 13e:	c3                   	ret    
        inword = 1;
      }
    }
  }
  if(n < 0){
    printf(1, "wc: read error\n");
 13f:	83 ec 08             	sub    $0x8,%esp
 142:	68 f6 06 00 00       	push   $0x6f6
 147:	6a 01                	push   $0x1
 149:	e8 d2 02 00 00       	call   420 <printf>
    exit();
 14e:	e8 ac 01 00 00       	call   2ff <exit>
 153:	90                   	nop

00000154 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 154:	55                   	push   %ebp
 155:	89 e5                	mov    %esp,%ebp
 157:	53                   	push   %ebx
 158:	8b 45 08             	mov    0x8(%ebp),%eax
 15b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 15e:	89 c2                	mov    %eax,%edx
 160:	42                   	inc    %edx
 161:	41                   	inc    %ecx
 162:	8a 59 ff             	mov    -0x1(%ecx),%bl
 165:	88 5a ff             	mov    %bl,-0x1(%edx)
 168:	84 db                	test   %bl,%bl
 16a:	75 f4                	jne    160 <strcpy+0xc>
    ;
  return os;
}
 16c:	5b                   	pop    %ebx
 16d:	5d                   	pop    %ebp
 16e:	c3                   	ret    
 16f:	90                   	nop

00000170 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	56                   	push   %esi
 174:	53                   	push   %ebx
 175:	8b 55 08             	mov    0x8(%ebp),%edx
 178:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 17b:	0f b6 02             	movzbl (%edx),%eax
 17e:	0f b6 0b             	movzbl (%ebx),%ecx
 181:	84 c0                	test   %al,%al
 183:	75 14                	jne    199 <strcmp+0x29>
 185:	eb 1d                	jmp    1a4 <strcmp+0x34>
 187:	90                   	nop
    p++, q++;
 188:	42                   	inc    %edx
 189:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 18c:	0f b6 02             	movzbl (%edx),%eax
 18f:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 193:	84 c0                	test   %al,%al
 195:	74 0d                	je     1a4 <strcmp+0x34>
 197:	89 f3                	mov    %esi,%ebx
 199:	38 c8                	cmp    %cl,%al
 19b:	74 eb                	je     188 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 19d:	29 c8                	sub    %ecx,%eax
}
 19f:	5b                   	pop    %ebx
 1a0:	5e                   	pop    %esi
 1a1:	5d                   	pop    %ebp
 1a2:	c3                   	ret    
 1a3:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1a4:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1a6:	29 c8                	sub    %ecx,%eax
}
 1a8:	5b                   	pop    %ebx
 1a9:	5e                   	pop    %esi
 1aa:	5d                   	pop    %ebp
 1ab:	c3                   	ret    

000001ac <strlen>:

uint
strlen(char *s)
{
 1ac:	55                   	push   %ebp
 1ad:	89 e5                	mov    %esp,%ebp
 1af:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1b2:	80 39 00             	cmpb   $0x0,(%ecx)
 1b5:	74 10                	je     1c7 <strlen+0x1b>
 1b7:	31 d2                	xor    %edx,%edx
 1b9:	8d 76 00             	lea    0x0(%esi),%esi
 1bc:	42                   	inc    %edx
 1bd:	89 d0                	mov    %edx,%eax
 1bf:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1c3:	75 f7                	jne    1bc <strlen+0x10>
    ;
  return n;
}
 1c5:	5d                   	pop    %ebp
 1c6:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 1c7:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 1c9:	5d                   	pop    %ebp
 1ca:	c3                   	ret    
 1cb:	90                   	nop

000001cc <memset>:

void*
memset(void *dst, int c, uint n)
{
 1cc:	55                   	push   %ebp
 1cd:	89 e5                	mov    %esp,%ebp
 1cf:	57                   	push   %edi
 1d0:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1d3:	89 d7                	mov    %edx,%edi
 1d5:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1d8:	8b 45 0c             	mov    0xc(%ebp),%eax
 1db:	fc                   	cld    
 1dc:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1de:	89 d0                	mov    %edx,%eax
 1e0:	5f                   	pop    %edi
 1e1:	5d                   	pop    %ebp
 1e2:	c3                   	ret    
 1e3:	90                   	nop

000001e4 <strchr>:

char*
strchr(const char *s, char c)
{
 1e4:	55                   	push   %ebp
 1e5:	89 e5                	mov    %esp,%ebp
 1e7:	53                   	push   %ebx
 1e8:	8b 45 08             	mov    0x8(%ebp),%eax
 1eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 1ee:	8a 18                	mov    (%eax),%bl
 1f0:	84 db                	test   %bl,%bl
 1f2:	74 13                	je     207 <strchr+0x23>
 1f4:	88 d1                	mov    %dl,%cl
    if(*s == c)
 1f6:	38 d3                	cmp    %dl,%bl
 1f8:	75 06                	jne    200 <strchr+0x1c>
 1fa:	eb 0d                	jmp    209 <strchr+0x25>
 1fc:	38 ca                	cmp    %cl,%dl
 1fe:	74 09                	je     209 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 200:	40                   	inc    %eax
 201:	8a 10                	mov    (%eax),%dl
 203:	84 d2                	test   %dl,%dl
 205:	75 f5                	jne    1fc <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 207:	31 c0                	xor    %eax,%eax
}
 209:	5b                   	pop    %ebx
 20a:	5d                   	pop    %ebp
 20b:	c3                   	ret    

0000020c <gets>:

char*
gets(char *buf, int max)
{
 20c:	55                   	push   %ebp
 20d:	89 e5                	mov    %esp,%ebp
 20f:	57                   	push   %edi
 210:	56                   	push   %esi
 211:	53                   	push   %ebx
 212:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 215:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 217:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 21a:	eb 26                	jmp    242 <gets+0x36>
    cc = read(0, &c, 1);
 21c:	50                   	push   %eax
 21d:	6a 01                	push   $0x1
 21f:	57                   	push   %edi
 220:	6a 00                	push   $0x0
 222:	e8 f0 00 00 00       	call   317 <read>
    if(cc < 1)
 227:	83 c4 10             	add    $0x10,%esp
 22a:	85 c0                	test   %eax,%eax
 22c:	7e 1c                	jle    24a <gets+0x3e>
      break;
    buf[i++] = c;
 22e:	8a 45 e7             	mov    -0x19(%ebp),%al
 231:	8b 55 08             	mov    0x8(%ebp),%edx
 234:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
 238:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 23a:	3c 0a                	cmp    $0xa,%al
 23c:	74 0c                	je     24a <gets+0x3e>
 23e:	3c 0d                	cmp    $0xd,%al
 240:	74 08                	je     24a <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 242:	8d 5e 01             	lea    0x1(%esi),%ebx
 245:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 248:	7c d2                	jl     21c <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 24a:	8b 45 08             	mov    0x8(%ebp),%eax
 24d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 251:	8d 65 f4             	lea    -0xc(%ebp),%esp
 254:	5b                   	pop    %ebx
 255:	5e                   	pop    %esi
 256:	5f                   	pop    %edi
 257:	5d                   	pop    %ebp
 258:	c3                   	ret    
 259:	8d 76 00             	lea    0x0(%esi),%esi

0000025c <stat>:

int
stat(char *n, struct stat *st)
{
 25c:	55                   	push   %ebp
 25d:	89 e5                	mov    %esp,%ebp
 25f:	56                   	push   %esi
 260:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 261:	83 ec 08             	sub    $0x8,%esp
 264:	6a 00                	push   $0x0
 266:	ff 75 08             	pushl  0x8(%ebp)
 269:	e8 d1 00 00 00       	call   33f <open>
 26e:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 270:	83 c4 10             	add    $0x10,%esp
 273:	85 c0                	test   %eax,%eax
 275:	78 25                	js     29c <stat+0x40>
    return -1;
  r = fstat(fd, st);
 277:	83 ec 08             	sub    $0x8,%esp
 27a:	ff 75 0c             	pushl  0xc(%ebp)
 27d:	50                   	push   %eax
 27e:	e8 d4 00 00 00       	call   357 <fstat>
 283:	89 c6                	mov    %eax,%esi
  close(fd);
 285:	89 1c 24             	mov    %ebx,(%esp)
 288:	e8 9a 00 00 00       	call   327 <close>
  return r;
 28d:	83 c4 10             	add    $0x10,%esp
 290:	89 f0                	mov    %esi,%eax
}
 292:	8d 65 f8             	lea    -0x8(%ebp),%esp
 295:	5b                   	pop    %ebx
 296:	5e                   	pop    %esi
 297:	5d                   	pop    %ebp
 298:	c3                   	ret    
 299:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 29c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2a1:	eb ef                	jmp    292 <stat+0x36>
 2a3:	90                   	nop

000002a4 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 2a4:	55                   	push   %ebp
 2a5:	89 e5                	mov    %esp,%ebp
 2a7:	53                   	push   %ebx
 2a8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2ab:	0f be 11             	movsbl (%ecx),%edx
 2ae:	8d 42 d0             	lea    -0x30(%edx),%eax
 2b1:	3c 09                	cmp    $0x9,%al
 2b3:	b8 00 00 00 00       	mov    $0x0,%eax
 2b8:	77 15                	ja     2cf <atoi+0x2b>
 2ba:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 2bc:	41                   	inc    %ecx
 2bd:	8d 04 80             	lea    (%eax,%eax,4),%eax
 2c0:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2c4:	0f be 11             	movsbl (%ecx),%edx
 2c7:	8d 5a d0             	lea    -0x30(%edx),%ebx
 2ca:	80 fb 09             	cmp    $0x9,%bl
 2cd:	76 ed                	jbe    2bc <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 2cf:	5b                   	pop    %ebx
 2d0:	5d                   	pop    %ebp
 2d1:	c3                   	ret    
 2d2:	66 90                	xchg   %ax,%ax

000002d4 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2d4:	55                   	push   %ebp
 2d5:	89 e5                	mov    %esp,%ebp
 2d7:	56                   	push   %esi
 2d8:	53                   	push   %ebx
 2d9:	8b 45 08             	mov    0x8(%ebp),%eax
 2dc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 2df:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2e2:	31 d2                	xor    %edx,%edx
 2e4:	85 f6                	test   %esi,%esi
 2e6:	7e 0b                	jle    2f3 <memmove+0x1f>
    *dst++ = *src++;
 2e8:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 2eb:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2ee:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ef:	39 f2                	cmp    %esi,%edx
 2f1:	75 f5                	jne    2e8 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 2f3:	5b                   	pop    %ebx
 2f4:	5e                   	pop    %esi
 2f5:	5d                   	pop    %ebp
 2f6:	c3                   	ret    

000002f7 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2f7:	b8 01 00 00 00       	mov    $0x1,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <exit>:
SYSCALL(exit)
 2ff:	b8 02 00 00 00       	mov    $0x2,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <wait>:
SYSCALL(wait)
 307:	b8 03 00 00 00       	mov    $0x3,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <pipe>:
SYSCALL(pipe)
 30f:	b8 04 00 00 00       	mov    $0x4,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <read>:
SYSCALL(read)
 317:	b8 05 00 00 00       	mov    $0x5,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <write>:
SYSCALL(write)
 31f:	b8 10 00 00 00       	mov    $0x10,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <close>:
SYSCALL(close)
 327:	b8 15 00 00 00       	mov    $0x15,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <kill>:
SYSCALL(kill)
 32f:	b8 06 00 00 00       	mov    $0x6,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <exec>:
SYSCALL(exec)
 337:	b8 07 00 00 00       	mov    $0x7,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <open>:
SYSCALL(open)
 33f:	b8 0f 00 00 00       	mov    $0xf,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    

00000347 <mknod>:
SYSCALL(mknod)
 347:	b8 11 00 00 00       	mov    $0x11,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    

0000034f <unlink>:
SYSCALL(unlink)
 34f:	b8 12 00 00 00       	mov    $0x12,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret    

00000357 <fstat>:
SYSCALL(fstat)
 357:	b8 08 00 00 00       	mov    $0x8,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret    

0000035f <link>:
SYSCALL(link)
 35f:	b8 13 00 00 00       	mov    $0x13,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret    

00000367 <mkdir>:
SYSCALL(mkdir)
 367:	b8 14 00 00 00       	mov    $0x14,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret    

0000036f <chdir>:
SYSCALL(chdir)
 36f:	b8 09 00 00 00       	mov    $0x9,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret    

00000377 <dup>:
SYSCALL(dup)
 377:	b8 0a 00 00 00       	mov    $0xa,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret    

0000037f <getpid>:
SYSCALL(getpid)
 37f:	b8 0b 00 00 00       	mov    $0xb,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret    

00000387 <sbrk>:
SYSCALL(sbrk)
 387:	b8 0c 00 00 00       	mov    $0xc,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret    

0000038f <sleep>:
SYSCALL(sleep)
 38f:	b8 0d 00 00 00       	mov    $0xd,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret    

00000397 <uptime>:
SYSCALL(uptime)
 397:	b8 0e 00 00 00       	mov    $0xe,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret    

0000039f <mike>:
SYSCALL(mike)
 39f:	b8 16 00 00 00       	mov    $0x16,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret    
 3a7:	90                   	nop

000003a8 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3a8:	55                   	push   %ebp
 3a9:	89 e5                	mov    %esp,%ebp
 3ab:	57                   	push   %edi
 3ac:	56                   	push   %esi
 3ad:	53                   	push   %ebx
 3ae:	83 ec 3c             	sub    $0x3c,%esp
 3b1:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3b3:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 3b8:	85 db                	test   %ebx,%ebx
 3ba:	74 04                	je     3c0 <printint+0x18>
 3bc:	85 d2                	test   %edx,%edx
 3be:	78 53                	js     413 <printint+0x6b>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3c0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 3c7:	31 db                	xor    %ebx,%ebx
 3c9:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 3cc:	43                   	inc    %ebx
 3cd:	31 d2                	xor    %edx,%edx
 3cf:	f7 f1                	div    %ecx
 3d1:	8a 92 30 07 00 00    	mov    0x730(%edx),%dl
 3d7:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 3da:	85 c0                	test   %eax,%eax
 3dc:	75 ee                	jne    3cc <printint+0x24>
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 3de:	89 d8                	mov    %ebx,%eax
  }while((x /= base) != 0);
  if(neg)
 3e0:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 3e3:	85 d2                	test   %edx,%edx
 3e5:	74 06                	je     3ed <printint+0x45>
    buf[i++] = '-';
 3e7:	43                   	inc    %ebx
 3e8:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 3ed:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 3f1:	8d 76 00             	lea    0x0(%esi),%esi
 3f4:	8a 03                	mov    (%ebx),%al
 3f6:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3f9:	50                   	push   %eax
 3fa:	6a 01                	push   $0x1
 3fc:	56                   	push   %esi
 3fd:	57                   	push   %edi
 3fe:	e8 1c ff ff ff       	call   31f <write>
 403:	4b                   	dec    %ebx
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 404:	83 c4 10             	add    $0x10,%esp
 407:	39 f3                	cmp    %esi,%ebx
 409:	75 e9                	jne    3f4 <printint+0x4c>
    putc(fd, buf[i]);
}
 40b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 40e:	5b                   	pop    %ebx
 40f:	5e                   	pop    %esi
 410:	5f                   	pop    %edi
 411:	5d                   	pop    %ebp
 412:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 413:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 415:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 41c:	eb a9                	jmp    3c7 <printint+0x1f>
 41e:	66 90                	xchg   %ax,%ax

00000420 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	56                   	push   %esi
 425:	53                   	push   %ebx
 426:	83 ec 2c             	sub    $0x2c,%esp
 429:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 42c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 42f:	8a 13                	mov    (%ebx),%dl
 431:	84 d2                	test   %dl,%dl
 433:	0f 84 a3 00 00 00    	je     4dc <printf+0xbc>
 439:	43                   	inc    %ebx
 43a:	8d 45 10             	lea    0x10(%ebp),%eax
 43d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 440:	31 ff                	xor    %edi,%edi
 442:	eb 24                	jmp    468 <printf+0x48>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 444:	83 fa 25             	cmp    $0x25,%edx
 447:	0f 84 97 00 00 00    	je     4e4 <printf+0xc4>
        state = '%';
      } else {
        putc(fd, c);
 44d:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 450:	50                   	push   %eax
 451:	6a 01                	push   $0x1
 453:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 456:	50                   	push   %eax
 457:	56                   	push   %esi
 458:	e8 c2 fe ff ff       	call   31f <write>
 45d:	83 c4 10             	add    $0x10,%esp
 460:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 461:	8a 53 ff             	mov    -0x1(%ebx),%dl
 464:	84 d2                	test   %dl,%dl
 466:	74 74                	je     4dc <printf+0xbc>
    c = fmt[i] & 0xff;
 468:	0f be c2             	movsbl %dl,%eax
 46b:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
 46e:	85 ff                	test   %edi,%edi
 470:	74 d2                	je     444 <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 472:	83 ff 25             	cmp    $0x25,%edi
 475:	75 e9                	jne    460 <printf+0x40>
      if(c == 'd'){
 477:	83 fa 64             	cmp    $0x64,%edx
 47a:	0f 84 e8 00 00 00    	je     568 <printf+0x148>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 480:	25 f7 00 00 00       	and    $0xf7,%eax
 485:	83 f8 70             	cmp    $0x70,%eax
 488:	74 66                	je     4f0 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 48a:	83 fa 73             	cmp    $0x73,%edx
 48d:	0f 84 85 00 00 00    	je     518 <printf+0xf8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 493:	83 fa 63             	cmp    $0x63,%edx
 496:	0f 84 b5 00 00 00    	je     551 <printf+0x131>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 49c:	83 fa 25             	cmp    $0x25,%edx
 49f:	0f 84 cf 00 00 00    	je     574 <printf+0x154>
 4a5:	89 55 d0             	mov    %edx,-0x30(%ebp)
 4a8:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4ac:	50                   	push   %eax
 4ad:	6a 01                	push   $0x1
 4af:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4b2:	50                   	push   %eax
 4b3:	56                   	push   %esi
 4b4:	e8 66 fe ff ff       	call   31f <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4b9:	8b 55 d0             	mov    -0x30(%ebp),%edx
 4bc:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4bf:	83 c4 0c             	add    $0xc,%esp
 4c2:	6a 01                	push   $0x1
 4c4:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4c7:	50                   	push   %eax
 4c8:	56                   	push   %esi
 4c9:	e8 51 fe ff ff       	call   31f <write>
 4ce:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4d1:	31 ff                	xor    %edi,%edi
 4d3:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4d4:	8a 53 ff             	mov    -0x1(%ebx),%dl
 4d7:	84 d2                	test   %dl,%dl
 4d9:	75 8d                	jne    468 <printf+0x48>
 4db:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4df:	5b                   	pop    %ebx
 4e0:	5e                   	pop    %esi
 4e1:	5f                   	pop    %edi
 4e2:	5d                   	pop    %ebp
 4e3:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4e4:	bf 25 00 00 00       	mov    $0x25,%edi
 4e9:	e9 72 ff ff ff       	jmp    460 <printf+0x40>
 4ee:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4f0:	83 ec 0c             	sub    $0xc,%esp
 4f3:	6a 00                	push   $0x0
 4f5:	b9 10 00 00 00       	mov    $0x10,%ecx
 4fa:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4fd:	8b 17                	mov    (%edi),%edx
 4ff:	89 f0                	mov    %esi,%eax
 501:	e8 a2 fe ff ff       	call   3a8 <printint>
        ap++;
 506:	89 f8                	mov    %edi,%eax
 508:	83 c0 04             	add    $0x4,%eax
 50b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 50e:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 511:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 513:	e9 48 ff ff ff       	jmp    460 <printf+0x40>
      } else if(c == 's'){
        s = (char*)*ap;
 518:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 51b:	8b 38                	mov    (%eax),%edi
        ap++;
 51d:	83 c0 04             	add    $0x4,%eax
 520:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 523:	85 ff                	test   %edi,%edi
 525:	74 5c                	je     583 <printf+0x163>
          s = "(null)";
        while(*s != 0){
 527:	8a 07                	mov    (%edi),%al
 529:	84 c0                	test   %al,%al
 52b:	74 1d                	je     54a <printf+0x12a>
 52d:	8d 76 00             	lea    0x0(%esi),%esi
 530:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 533:	50                   	push   %eax
 534:	6a 01                	push   $0x1
 536:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 539:	50                   	push   %eax
 53a:	56                   	push   %esi
 53b:	e8 df fd ff ff       	call   31f <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 540:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 541:	8a 07                	mov    (%edi),%al
 543:	83 c4 10             	add    $0x10,%esp
 546:	84 c0                	test   %al,%al
 548:	75 e6                	jne    530 <printf+0x110>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 54a:	31 ff                	xor    %edi,%edi
 54c:	e9 0f ff ff ff       	jmp    460 <printf+0x40>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 551:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 554:	8b 07                	mov    (%edi),%eax
 556:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 559:	51                   	push   %ecx
 55a:	6a 01                	push   $0x1
 55c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 55f:	50                   	push   %eax
 560:	56                   	push   %esi
 561:	e8 b9 fd ff ff       	call   31f <write>
 566:	eb 9e                	jmp    506 <printf+0xe6>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 568:	83 ec 0c             	sub    $0xc,%esp
 56b:	6a 01                	push   $0x1
 56d:	b9 0a 00 00 00       	mov    $0xa,%ecx
 572:	eb 86                	jmp    4fa <printf+0xda>
 574:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 578:	52                   	push   %edx
 579:	6a 01                	push   $0x1
 57b:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 57e:	e9 44 ff ff ff       	jmp    4c7 <printf+0xa7>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 583:	bf 27 07 00 00       	mov    $0x727,%edi
 588:	eb 9d                	jmp    527 <printf+0x107>
 58a:	66 90                	xchg   %ax,%ax

0000058c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 58c:	55                   	push   %ebp
 58d:	89 e5                	mov    %esp,%ebp
 58f:	57                   	push   %edi
 590:	56                   	push   %esi
 591:	53                   	push   %ebx
 592:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 595:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 598:	a1 00 0a 00 00       	mov    0xa00,%eax
 59d:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5a0:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5a2:	39 c8                	cmp    %ecx,%eax
 5a4:	73 2e                	jae    5d4 <free+0x48>
 5a6:	39 d1                	cmp    %edx,%ecx
 5a8:	72 04                	jb     5ae <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5aa:	39 d0                	cmp    %edx,%eax
 5ac:	72 2e                	jb     5dc <free+0x50>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5ae:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5b1:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5b4:	39 d7                	cmp    %edx,%edi
 5b6:	74 28                	je     5e0 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5b8:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5bb:	8b 50 04             	mov    0x4(%eax),%edx
 5be:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5c1:	39 f1                	cmp    %esi,%ecx
 5c3:	74 32                	je     5f7 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5c5:	89 08                	mov    %ecx,(%eax)
  freep = p;
 5c7:	a3 00 0a 00 00       	mov    %eax,0xa00
}
 5cc:	5b                   	pop    %ebx
 5cd:	5e                   	pop    %esi
 5ce:	5f                   	pop    %edi
 5cf:	5d                   	pop    %ebp
 5d0:	c3                   	ret    
 5d1:	8d 76 00             	lea    0x0(%esi),%esi
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5d4:	39 d0                	cmp    %edx,%eax
 5d6:	72 04                	jb     5dc <free+0x50>
 5d8:	39 d1                	cmp    %edx,%ecx
 5da:	72 d2                	jb     5ae <free+0x22>
static Header base;
static Header *freep;

void
free(void *ap)
{
 5dc:	89 d0                	mov    %edx,%eax
 5de:	eb c0                	jmp    5a0 <free+0x14>
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5e0:	03 72 04             	add    0x4(%edx),%esi
 5e3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5e6:	8b 10                	mov    (%eax),%edx
 5e8:	8b 12                	mov    (%edx),%edx
 5ea:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5ed:	8b 50 04             	mov    0x4(%eax),%edx
 5f0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5f3:	39 f1                	cmp    %esi,%ecx
 5f5:	75 ce                	jne    5c5 <free+0x39>
    p->s.size += bp->s.size;
 5f7:	03 53 fc             	add    -0x4(%ebx),%edx
 5fa:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5fd:	8b 53 f8             	mov    -0x8(%ebx),%edx
 600:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 602:	a3 00 0a 00 00       	mov    %eax,0xa00
}
 607:	5b                   	pop    %ebx
 608:	5e                   	pop    %esi
 609:	5f                   	pop    %edi
 60a:	5d                   	pop    %ebp
 60b:	c3                   	ret    

0000060c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 60c:	55                   	push   %ebp
 60d:	89 e5                	mov    %esp,%ebp
 60f:	57                   	push   %edi
 610:	56                   	push   %esi
 611:	53                   	push   %ebx
 612:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 615:	8b 45 08             	mov    0x8(%ebp),%eax
 618:	8d 70 07             	lea    0x7(%eax),%esi
 61b:	c1 ee 03             	shr    $0x3,%esi
 61e:	46                   	inc    %esi
  if((prevp = freep) == 0){
 61f:	8b 15 00 0a 00 00    	mov    0xa00,%edx
 625:	85 d2                	test   %edx,%edx
 627:	0f 84 99 00 00 00    	je     6c6 <malloc+0xba>
 62d:	8b 02                	mov    (%edx),%eax
 62f:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 632:	39 ce                	cmp    %ecx,%esi
 634:	76 62                	jbe    698 <malloc+0x8c>
 636:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 63d:	eb 0a                	jmp    649 <malloc+0x3d>
 63f:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 640:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 642:	8b 48 04             	mov    0x4(%eax),%ecx
 645:	39 ce                	cmp    %ecx,%esi
 647:	76 4f                	jbe    698 <malloc+0x8c>
 649:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 64b:	3b 05 00 0a 00 00    	cmp    0xa00,%eax
 651:	75 ed                	jne    640 <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 653:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 659:	77 5d                	ja     6b8 <malloc+0xac>
 65b:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 660:	bf 00 10 00 00       	mov    $0x1000,%edi
  p = sbrk(nu * sizeof(Header));
 665:	83 ec 0c             	sub    $0xc,%esp
 668:	50                   	push   %eax
 669:	e8 19 fd ff ff       	call   387 <sbrk>
  if(p == (char*)-1)
 66e:	83 c4 10             	add    $0x10,%esp
 671:	83 f8 ff             	cmp    $0xffffffff,%eax
 674:	74 1c                	je     692 <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 676:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 679:	83 ec 0c             	sub    $0xc,%esp
 67c:	83 c0 08             	add    $0x8,%eax
 67f:	50                   	push   %eax
 680:	e8 07 ff ff ff       	call   58c <free>
  return freep;
 685:	8b 15 00 0a 00 00    	mov    0xa00,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 68b:	83 c4 10             	add    $0x10,%esp
 68e:	85 d2                	test   %edx,%edx
 690:	75 ae                	jne    640 <malloc+0x34>
        return 0;
 692:	31 c0                	xor    %eax,%eax
 694:	eb 1a                	jmp    6b0 <malloc+0xa4>
 696:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 698:	39 ce                	cmp    %ecx,%esi
 69a:	74 24                	je     6c0 <malloc+0xb4>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 69c:	29 f1                	sub    %esi,%ecx
 69e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 6a1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6a4:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
 6a7:	89 15 00 0a 00 00    	mov    %edx,0xa00
      return (void*)(p + 1);
 6ad:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6b3:	5b                   	pop    %ebx
 6b4:	5e                   	pop    %esi
 6b5:	5f                   	pop    %edi
 6b6:	5d                   	pop    %ebp
 6b7:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 6b8:	89 d8                	mov    %ebx,%eax
 6ba:	89 f7                	mov    %esi,%edi
 6bc:	eb a7                	jmp    665 <malloc+0x59>
 6be:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 6c0:	8b 08                	mov    (%eax),%ecx
 6c2:	89 0a                	mov    %ecx,(%edx)
 6c4:	eb e1                	jmp    6a7 <malloc+0x9b>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 6c6:	c7 05 00 0a 00 00 04 	movl   $0xa04,0xa00
 6cd:	0a 00 00 
 6d0:	c7 05 04 0a 00 00 04 	movl   $0xa04,0xa04
 6d7:	0a 00 00 
    base.s.size = 0;
 6da:	c7 05 08 0a 00 00 00 	movl   $0x0,0xa08
 6e1:	00 00 00 
 6e4:	b8 04 0a 00 00       	mov    $0xa04,%eax
 6e9:	e9 48 ff ff ff       	jmp    636 <malloc+0x2a>
