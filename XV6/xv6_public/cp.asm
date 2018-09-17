
_cp:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
 #include "fcntl.h"
#include "types.h"
#include "user.h" 
 int main(int argc,char **argv)
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
  11:	81 ec 18 04 00 00    	sub    $0x418,%esp
  17:	8b 59 04             	mov    0x4(%ecx),%ebx
    printf(1,"Copying %s to %s\n",argv[1],argv[2]);
  1a:	ff 73 08             	pushl  0x8(%ebx)
  1d:	ff 73 04             	pushl  0x4(%ebx)
  20:	68 60 06 00 00       	push   $0x660
  25:	6a 01                	push   $0x1
  27:	e8 64 03 00 00       	call   390 <printf>
    int fp1;
    int fp2;
    char buf[1024];
    fp1 = open(argv[1],O_RDONLY);
  2c:	58                   	pop    %eax
  2d:	5a                   	pop    %edx
  2e:	6a 00                	push   $0x0
  30:	ff 73 04             	pushl  0x4(%ebx)
  33:	e8 77 02 00 00       	call   2af <open>
  38:	89 c6                	mov    %eax,%esi
    fp2 = open(argv[2],O_CREATE | O_RDWR);
  3a:	59                   	pop    %ecx
  3b:	5f                   	pop    %edi
  3c:	68 02 02 00 00       	push   $0x202
  41:	ff 73 08             	pushl  0x8(%ebx)
  44:	e8 66 02 00 00       	call   2af <open>
  49:	89 85 e4 fb ff ff    	mov    %eax,-0x41c(%ebp)
    
    int numRead;
    while ((numRead = read(fp1,buf,1024)) > 0)
  4f:	83 c4 10             	add    $0x10,%esp
  52:	8d 9d e8 fb ff ff    	lea    -0x418(%ebp),%ebx
  58:	eb 17                	jmp    71 <main+0x71>
  5a:	66 90                	xchg   %ax,%ax
    {
         if (write(fp2, buf, numRead) != numRead)
  5c:	50                   	push   %eax
  5d:	57                   	push   %edi
  5e:	53                   	push   %ebx
  5f:	ff b5 e4 fb ff ff    	pushl  -0x41c(%ebp)
  65:	e8 25 02 00 00       	call   28f <write>
  6a:	83 c4 10             	add    $0x10,%esp
  6d:	39 f8                	cmp    %edi,%eax
  6f:	75 3d                	jne    ae <main+0xae>
    char buf[1024];
    fp1 = open(argv[1],O_RDONLY);
    fp2 = open(argv[2],O_CREATE | O_RDWR);
    
    int numRead;
    while ((numRead = read(fp1,buf,1024)) > 0)
  71:	51                   	push   %ecx
  72:	68 00 04 00 00       	push   $0x400
  77:	53                   	push   %ebx
  78:	56                   	push   %esi
  79:	e8 09 02 00 00       	call   287 <read>
  7e:	89 c7                	mov    %eax,%edi
  80:	83 c4 10             	add    $0x10,%esp
  83:	85 c0                	test   %eax,%eax
  85:	7f d5                	jg     5c <main+0x5c>
            {
                printf(1,"couldn't write whole buffer");
                exit();
            }
    }
    printf(1,"Copying finished\n");
  87:	50                   	push   %eax
  88:	50                   	push   %eax
  89:	68 8e 06 00 00       	push   $0x68e
  8e:	6a 01                	push   $0x1
  90:	e8 fb 02 00 00       	call   390 <printf>
    close(fp1);
  95:	89 34 24             	mov    %esi,(%esp)
  98:	e8 fa 01 00 00       	call   297 <close>
    close(fp2);
  9d:	5a                   	pop    %edx
  9e:	ff b5 e4 fb ff ff    	pushl  -0x41c(%ebp)
  a4:	e8 ee 01 00 00       	call   297 <close>
    exit();
  a9:	e8 c1 01 00 00       	call   26f <exit>
    int numRead;
    while ((numRead = read(fp1,buf,1024)) > 0)
    {
         if (write(fp2, buf, numRead) != numRead)
            {
                printf(1,"couldn't write whole buffer");
  ae:	53                   	push   %ebx
  af:	53                   	push   %ebx
  b0:	68 72 06 00 00       	push   $0x672
  b5:	6a 01                	push   $0x1
  b7:	e8 d4 02 00 00       	call   390 <printf>
                exit();
  bc:	e8 ae 01 00 00       	call   26f <exit>
  c1:	66 90                	xchg   %ax,%ax
  c3:	90                   	nop

000000c4 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  c4:	55                   	push   %ebp
  c5:	89 e5                	mov    %esp,%ebp
  c7:	53                   	push   %ebx
  c8:	8b 45 08             	mov    0x8(%ebp),%eax
  cb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  ce:	89 c2                	mov    %eax,%edx
  d0:	42                   	inc    %edx
  d1:	41                   	inc    %ecx
  d2:	8a 59 ff             	mov    -0x1(%ecx),%bl
  d5:	88 5a ff             	mov    %bl,-0x1(%edx)
  d8:	84 db                	test   %bl,%bl
  da:	75 f4                	jne    d0 <strcpy+0xc>
    ;
  return os;
}
  dc:	5b                   	pop    %ebx
  dd:	5d                   	pop    %ebp
  de:	c3                   	ret    
  df:	90                   	nop

000000e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	56                   	push   %esi
  e4:	53                   	push   %ebx
  e5:	8b 55 08             	mov    0x8(%ebp),%edx
  e8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  eb:	0f b6 02             	movzbl (%edx),%eax
  ee:	0f b6 0b             	movzbl (%ebx),%ecx
  f1:	84 c0                	test   %al,%al
  f3:	75 14                	jne    109 <strcmp+0x29>
  f5:	eb 1d                	jmp    114 <strcmp+0x34>
  f7:	90                   	nop
    p++, q++;
  f8:	42                   	inc    %edx
  f9:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  fc:	0f b6 02             	movzbl (%edx),%eax
  ff:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 103:	84 c0                	test   %al,%al
 105:	74 0d                	je     114 <strcmp+0x34>
 107:	89 f3                	mov    %esi,%ebx
 109:	38 c8                	cmp    %cl,%al
 10b:	74 eb                	je     f8 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 10d:	29 c8                	sub    %ecx,%eax
}
 10f:	5b                   	pop    %ebx
 110:	5e                   	pop    %esi
 111:	5d                   	pop    %ebp
 112:	c3                   	ret    
 113:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 114:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 116:	29 c8                	sub    %ecx,%eax
}
 118:	5b                   	pop    %ebx
 119:	5e                   	pop    %esi
 11a:	5d                   	pop    %ebp
 11b:	c3                   	ret    

0000011c <strlen>:

uint
strlen(char *s)
{
 11c:	55                   	push   %ebp
 11d:	89 e5                	mov    %esp,%ebp
 11f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 122:	80 39 00             	cmpb   $0x0,(%ecx)
 125:	74 10                	je     137 <strlen+0x1b>
 127:	31 d2                	xor    %edx,%edx
 129:	8d 76 00             	lea    0x0(%esi),%esi
 12c:	42                   	inc    %edx
 12d:	89 d0                	mov    %edx,%eax
 12f:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 133:	75 f7                	jne    12c <strlen+0x10>
    ;
  return n;
}
 135:	5d                   	pop    %ebp
 136:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 137:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 139:	5d                   	pop    %ebp
 13a:	c3                   	ret    
 13b:	90                   	nop

0000013c <memset>:

void*
memset(void *dst, int c, uint n)
{
 13c:	55                   	push   %ebp
 13d:	89 e5                	mov    %esp,%ebp
 13f:	57                   	push   %edi
 140:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 143:	89 d7                	mov    %edx,%edi
 145:	8b 4d 10             	mov    0x10(%ebp),%ecx
 148:	8b 45 0c             	mov    0xc(%ebp),%eax
 14b:	fc                   	cld    
 14c:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 14e:	89 d0                	mov    %edx,%eax
 150:	5f                   	pop    %edi
 151:	5d                   	pop    %ebp
 152:	c3                   	ret    
 153:	90                   	nop

00000154 <strchr>:

char*
strchr(const char *s, char c)
{
 154:	55                   	push   %ebp
 155:	89 e5                	mov    %esp,%ebp
 157:	53                   	push   %ebx
 158:	8b 45 08             	mov    0x8(%ebp),%eax
 15b:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 15e:	8a 18                	mov    (%eax),%bl
 160:	84 db                	test   %bl,%bl
 162:	74 13                	je     177 <strchr+0x23>
 164:	88 d1                	mov    %dl,%cl
    if(*s == c)
 166:	38 d3                	cmp    %dl,%bl
 168:	75 06                	jne    170 <strchr+0x1c>
 16a:	eb 0d                	jmp    179 <strchr+0x25>
 16c:	38 ca                	cmp    %cl,%dl
 16e:	74 09                	je     179 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 170:	40                   	inc    %eax
 171:	8a 10                	mov    (%eax),%dl
 173:	84 d2                	test   %dl,%dl
 175:	75 f5                	jne    16c <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 177:	31 c0                	xor    %eax,%eax
}
 179:	5b                   	pop    %ebx
 17a:	5d                   	pop    %ebp
 17b:	c3                   	ret    

0000017c <gets>:

char*
gets(char *buf, int max)
{
 17c:	55                   	push   %ebp
 17d:	89 e5                	mov    %esp,%ebp
 17f:	57                   	push   %edi
 180:	56                   	push   %esi
 181:	53                   	push   %ebx
 182:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 185:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 187:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 18a:	eb 26                	jmp    1b2 <gets+0x36>
    cc = read(0, &c, 1);
 18c:	50                   	push   %eax
 18d:	6a 01                	push   $0x1
 18f:	57                   	push   %edi
 190:	6a 00                	push   $0x0
 192:	e8 f0 00 00 00       	call   287 <read>
    if(cc < 1)
 197:	83 c4 10             	add    $0x10,%esp
 19a:	85 c0                	test   %eax,%eax
 19c:	7e 1c                	jle    1ba <gets+0x3e>
      break;
    buf[i++] = c;
 19e:	8a 45 e7             	mov    -0x19(%ebp),%al
 1a1:	8b 55 08             	mov    0x8(%ebp),%edx
 1a4:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
 1a8:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 1aa:	3c 0a                	cmp    $0xa,%al
 1ac:	74 0c                	je     1ba <gets+0x3e>
 1ae:	3c 0d                	cmp    $0xd,%al
 1b0:	74 08                	je     1ba <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1b2:	8d 5e 01             	lea    0x1(%esi),%ebx
 1b5:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1b8:	7c d2                	jl     18c <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1ba:	8b 45 08             	mov    0x8(%ebp),%eax
 1bd:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1c4:	5b                   	pop    %ebx
 1c5:	5e                   	pop    %esi
 1c6:	5f                   	pop    %edi
 1c7:	5d                   	pop    %ebp
 1c8:	c3                   	ret    
 1c9:	8d 76 00             	lea    0x0(%esi),%esi

000001cc <stat>:

int
stat(char *n, struct stat *st)
{
 1cc:	55                   	push   %ebp
 1cd:	89 e5                	mov    %esp,%ebp
 1cf:	56                   	push   %esi
 1d0:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d1:	83 ec 08             	sub    $0x8,%esp
 1d4:	6a 00                	push   $0x0
 1d6:	ff 75 08             	pushl  0x8(%ebp)
 1d9:	e8 d1 00 00 00       	call   2af <open>
 1de:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 1e0:	83 c4 10             	add    $0x10,%esp
 1e3:	85 c0                	test   %eax,%eax
 1e5:	78 25                	js     20c <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1e7:	83 ec 08             	sub    $0x8,%esp
 1ea:	ff 75 0c             	pushl  0xc(%ebp)
 1ed:	50                   	push   %eax
 1ee:	e8 d4 00 00 00       	call   2c7 <fstat>
 1f3:	89 c6                	mov    %eax,%esi
  close(fd);
 1f5:	89 1c 24             	mov    %ebx,(%esp)
 1f8:	e8 9a 00 00 00       	call   297 <close>
  return r;
 1fd:	83 c4 10             	add    $0x10,%esp
 200:	89 f0                	mov    %esi,%eax
}
 202:	8d 65 f8             	lea    -0x8(%ebp),%esp
 205:	5b                   	pop    %ebx
 206:	5e                   	pop    %esi
 207:	5d                   	pop    %ebp
 208:	c3                   	ret    
 209:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 20c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 211:	eb ef                	jmp    202 <stat+0x36>
 213:	90                   	nop

00000214 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 214:	55                   	push   %ebp
 215:	89 e5                	mov    %esp,%ebp
 217:	53                   	push   %ebx
 218:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 21b:	0f be 11             	movsbl (%ecx),%edx
 21e:	8d 42 d0             	lea    -0x30(%edx),%eax
 221:	3c 09                	cmp    $0x9,%al
 223:	b8 00 00 00 00       	mov    $0x0,%eax
 228:	77 15                	ja     23f <atoi+0x2b>
 22a:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 22c:	41                   	inc    %ecx
 22d:	8d 04 80             	lea    (%eax,%eax,4),%eax
 230:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 234:	0f be 11             	movsbl (%ecx),%edx
 237:	8d 5a d0             	lea    -0x30(%edx),%ebx
 23a:	80 fb 09             	cmp    $0x9,%bl
 23d:	76 ed                	jbe    22c <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 23f:	5b                   	pop    %ebx
 240:	5d                   	pop    %ebp
 241:	c3                   	ret    
 242:	66 90                	xchg   %ax,%ax

00000244 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 244:	55                   	push   %ebp
 245:	89 e5                	mov    %esp,%ebp
 247:	56                   	push   %esi
 248:	53                   	push   %ebx
 249:	8b 45 08             	mov    0x8(%ebp),%eax
 24c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 24f:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 252:	31 d2                	xor    %edx,%edx
 254:	85 f6                	test   %esi,%esi
 256:	7e 0b                	jle    263 <memmove+0x1f>
    *dst++ = *src++;
 258:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 25b:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 25e:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 25f:	39 f2                	cmp    %esi,%edx
 261:	75 f5                	jne    258 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 263:	5b                   	pop    %ebx
 264:	5e                   	pop    %esi
 265:	5d                   	pop    %ebp
 266:	c3                   	ret    

00000267 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 267:	b8 01 00 00 00       	mov    $0x1,%eax
 26c:	cd 40                	int    $0x40
 26e:	c3                   	ret    

0000026f <exit>:
SYSCALL(exit)
 26f:	b8 02 00 00 00       	mov    $0x2,%eax
 274:	cd 40                	int    $0x40
 276:	c3                   	ret    

00000277 <wait>:
SYSCALL(wait)
 277:	b8 03 00 00 00       	mov    $0x3,%eax
 27c:	cd 40                	int    $0x40
 27e:	c3                   	ret    

0000027f <pipe>:
SYSCALL(pipe)
 27f:	b8 04 00 00 00       	mov    $0x4,%eax
 284:	cd 40                	int    $0x40
 286:	c3                   	ret    

00000287 <read>:
SYSCALL(read)
 287:	b8 05 00 00 00       	mov    $0x5,%eax
 28c:	cd 40                	int    $0x40
 28e:	c3                   	ret    

0000028f <write>:
SYSCALL(write)
 28f:	b8 10 00 00 00       	mov    $0x10,%eax
 294:	cd 40                	int    $0x40
 296:	c3                   	ret    

00000297 <close>:
SYSCALL(close)
 297:	b8 15 00 00 00       	mov    $0x15,%eax
 29c:	cd 40                	int    $0x40
 29e:	c3                   	ret    

0000029f <kill>:
SYSCALL(kill)
 29f:	b8 06 00 00 00       	mov    $0x6,%eax
 2a4:	cd 40                	int    $0x40
 2a6:	c3                   	ret    

000002a7 <exec>:
SYSCALL(exec)
 2a7:	b8 07 00 00 00       	mov    $0x7,%eax
 2ac:	cd 40                	int    $0x40
 2ae:	c3                   	ret    

000002af <open>:
SYSCALL(open)
 2af:	b8 0f 00 00 00       	mov    $0xf,%eax
 2b4:	cd 40                	int    $0x40
 2b6:	c3                   	ret    

000002b7 <mknod>:
SYSCALL(mknod)
 2b7:	b8 11 00 00 00       	mov    $0x11,%eax
 2bc:	cd 40                	int    $0x40
 2be:	c3                   	ret    

000002bf <unlink>:
SYSCALL(unlink)
 2bf:	b8 12 00 00 00       	mov    $0x12,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret    

000002c7 <fstat>:
SYSCALL(fstat)
 2c7:	b8 08 00 00 00       	mov    $0x8,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <link>:
SYSCALL(link)
 2cf:	b8 13 00 00 00       	mov    $0x13,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    

000002d7 <mkdir>:
SYSCALL(mkdir)
 2d7:	b8 14 00 00 00       	mov    $0x14,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret    

000002df <chdir>:
SYSCALL(chdir)
 2df:	b8 09 00 00 00       	mov    $0x9,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <dup>:
SYSCALL(dup)
 2e7:	b8 0a 00 00 00       	mov    $0xa,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    

000002ef <getpid>:
SYSCALL(getpid)
 2ef:	b8 0b 00 00 00       	mov    $0xb,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <sbrk>:
SYSCALL(sbrk)
 2f7:	b8 0c 00 00 00       	mov    $0xc,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <sleep>:
SYSCALL(sleep)
 2ff:	b8 0d 00 00 00       	mov    $0xd,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <uptime>:
SYSCALL(uptime)
 307:	b8 0e 00 00 00       	mov    $0xe,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <mike>:
SYSCALL(mike)
 30f:	b8 16 00 00 00       	mov    $0x16,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    
 317:	90                   	nop

00000318 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 318:	55                   	push   %ebp
 319:	89 e5                	mov    %esp,%ebp
 31b:	57                   	push   %edi
 31c:	56                   	push   %esi
 31d:	53                   	push   %ebx
 31e:	83 ec 3c             	sub    $0x3c,%esp
 321:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 323:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 325:	8b 5d 08             	mov    0x8(%ebp),%ebx
 328:	85 db                	test   %ebx,%ebx
 32a:	74 04                	je     330 <printint+0x18>
 32c:	85 d2                	test   %edx,%edx
 32e:	78 53                	js     383 <printint+0x6b>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 330:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 337:	31 db                	xor    %ebx,%ebx
 339:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 33c:	43                   	inc    %ebx
 33d:	31 d2                	xor    %edx,%edx
 33f:	f7 f1                	div    %ecx
 341:	8a 92 a8 06 00 00    	mov    0x6a8(%edx),%dl
 347:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 34a:	85 c0                	test   %eax,%eax
 34c:	75 ee                	jne    33c <printint+0x24>
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 34e:	89 d8                	mov    %ebx,%eax
  }while((x /= base) != 0);
  if(neg)
 350:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 353:	85 d2                	test   %edx,%edx
 355:	74 06                	je     35d <printint+0x45>
    buf[i++] = '-';
 357:	43                   	inc    %ebx
 358:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 35d:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 361:	8d 76 00             	lea    0x0(%esi),%esi
 364:	8a 03                	mov    (%ebx),%al
 366:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 369:	50                   	push   %eax
 36a:	6a 01                	push   $0x1
 36c:	56                   	push   %esi
 36d:	57                   	push   %edi
 36e:	e8 1c ff ff ff       	call   28f <write>
 373:	4b                   	dec    %ebx
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 374:	83 c4 10             	add    $0x10,%esp
 377:	39 f3                	cmp    %esi,%ebx
 379:	75 e9                	jne    364 <printint+0x4c>
    putc(fd, buf[i]);
}
 37b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 37e:	5b                   	pop    %ebx
 37f:	5e                   	pop    %esi
 380:	5f                   	pop    %edi
 381:	5d                   	pop    %ebp
 382:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 383:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 385:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 38c:	eb a9                	jmp    337 <printint+0x1f>
 38e:	66 90                	xchg   %ax,%ax

00000390 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	56                   	push   %esi
 395:	53                   	push   %ebx
 396:	83 ec 2c             	sub    $0x2c,%esp
 399:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 39c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 39f:	8a 13                	mov    (%ebx),%dl
 3a1:	84 d2                	test   %dl,%dl
 3a3:	0f 84 a3 00 00 00    	je     44c <printf+0xbc>
 3a9:	43                   	inc    %ebx
 3aa:	8d 45 10             	lea    0x10(%ebp),%eax
 3ad:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 3b0:	31 ff                	xor    %edi,%edi
 3b2:	eb 24                	jmp    3d8 <printf+0x48>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3b4:	83 fa 25             	cmp    $0x25,%edx
 3b7:	0f 84 97 00 00 00    	je     454 <printf+0xc4>
        state = '%';
      } else {
        putc(fd, c);
 3bd:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3c0:	50                   	push   %eax
 3c1:	6a 01                	push   $0x1
 3c3:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 3c6:	50                   	push   %eax
 3c7:	56                   	push   %esi
 3c8:	e8 c2 fe ff ff       	call   28f <write>
 3cd:	83 c4 10             	add    $0x10,%esp
 3d0:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3d1:	8a 53 ff             	mov    -0x1(%ebx),%dl
 3d4:	84 d2                	test   %dl,%dl
 3d6:	74 74                	je     44c <printf+0xbc>
    c = fmt[i] & 0xff;
 3d8:	0f be c2             	movsbl %dl,%eax
 3db:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
 3de:	85 ff                	test   %edi,%edi
 3e0:	74 d2                	je     3b4 <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 3e2:	83 ff 25             	cmp    $0x25,%edi
 3e5:	75 e9                	jne    3d0 <printf+0x40>
      if(c == 'd'){
 3e7:	83 fa 64             	cmp    $0x64,%edx
 3ea:	0f 84 e8 00 00 00    	je     4d8 <printf+0x148>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 3f0:	25 f7 00 00 00       	and    $0xf7,%eax
 3f5:	83 f8 70             	cmp    $0x70,%eax
 3f8:	74 66                	je     460 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3fa:	83 fa 73             	cmp    $0x73,%edx
 3fd:	0f 84 85 00 00 00    	je     488 <printf+0xf8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 403:	83 fa 63             	cmp    $0x63,%edx
 406:	0f 84 b5 00 00 00    	je     4c1 <printf+0x131>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 40c:	83 fa 25             	cmp    $0x25,%edx
 40f:	0f 84 cf 00 00 00    	je     4e4 <printf+0x154>
 415:	89 55 d0             	mov    %edx,-0x30(%ebp)
 418:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 41c:	50                   	push   %eax
 41d:	6a 01                	push   $0x1
 41f:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 422:	50                   	push   %eax
 423:	56                   	push   %esi
 424:	e8 66 fe ff ff       	call   28f <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 429:	8b 55 d0             	mov    -0x30(%ebp),%edx
 42c:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 42f:	83 c4 0c             	add    $0xc,%esp
 432:	6a 01                	push   $0x1
 434:	8d 45 e7             	lea    -0x19(%ebp),%eax
 437:	50                   	push   %eax
 438:	56                   	push   %esi
 439:	e8 51 fe ff ff       	call   28f <write>
 43e:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 441:	31 ff                	xor    %edi,%edi
 443:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 444:	8a 53 ff             	mov    -0x1(%ebx),%dl
 447:	84 d2                	test   %dl,%dl
 449:	75 8d                	jne    3d8 <printf+0x48>
 44b:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 44c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 44f:	5b                   	pop    %ebx
 450:	5e                   	pop    %esi
 451:	5f                   	pop    %edi
 452:	5d                   	pop    %ebp
 453:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 454:	bf 25 00 00 00       	mov    $0x25,%edi
 459:	e9 72 ff ff ff       	jmp    3d0 <printf+0x40>
 45e:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 460:	83 ec 0c             	sub    $0xc,%esp
 463:	6a 00                	push   $0x0
 465:	b9 10 00 00 00       	mov    $0x10,%ecx
 46a:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 46d:	8b 17                	mov    (%edi),%edx
 46f:	89 f0                	mov    %esi,%eax
 471:	e8 a2 fe ff ff       	call   318 <printint>
        ap++;
 476:	89 f8                	mov    %edi,%eax
 478:	83 c0 04             	add    $0x4,%eax
 47b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 47e:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 481:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 483:	e9 48 ff ff ff       	jmp    3d0 <printf+0x40>
      } else if(c == 's'){
        s = (char*)*ap;
 488:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 48b:	8b 38                	mov    (%eax),%edi
        ap++;
 48d:	83 c0 04             	add    $0x4,%eax
 490:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 493:	85 ff                	test   %edi,%edi
 495:	74 5c                	je     4f3 <printf+0x163>
          s = "(null)";
        while(*s != 0){
 497:	8a 07                	mov    (%edi),%al
 499:	84 c0                	test   %al,%al
 49b:	74 1d                	je     4ba <printf+0x12a>
 49d:	8d 76 00             	lea    0x0(%esi),%esi
 4a0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4a3:	50                   	push   %eax
 4a4:	6a 01                	push   $0x1
 4a6:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 4a9:	50                   	push   %eax
 4aa:	56                   	push   %esi
 4ab:	e8 df fd ff ff       	call   28f <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 4b0:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4b1:	8a 07                	mov    (%edi),%al
 4b3:	83 c4 10             	add    $0x10,%esp
 4b6:	84 c0                	test   %al,%al
 4b8:	75 e6                	jne    4a0 <printf+0x110>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4ba:	31 ff                	xor    %edi,%edi
 4bc:	e9 0f ff ff ff       	jmp    3d0 <printf+0x40>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 4c1:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4c4:	8b 07                	mov    (%edi),%eax
 4c6:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4c9:	51                   	push   %ecx
 4ca:	6a 01                	push   $0x1
 4cc:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 4cf:	50                   	push   %eax
 4d0:	56                   	push   %esi
 4d1:	e8 b9 fd ff ff       	call   28f <write>
 4d6:	eb 9e                	jmp    476 <printf+0xe6>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 4d8:	83 ec 0c             	sub    $0xc,%esp
 4db:	6a 01                	push   $0x1
 4dd:	b9 0a 00 00 00       	mov    $0xa,%ecx
 4e2:	eb 86                	jmp    46a <printf+0xda>
 4e4:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4e8:	52                   	push   %edx
 4e9:	6a 01                	push   $0x1
 4eb:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 4ee:	e9 44 ff ff ff       	jmp    437 <printf+0xa7>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 4f3:	bf a0 06 00 00       	mov    $0x6a0,%edi
 4f8:	eb 9d                	jmp    497 <printf+0x107>
 4fa:	66 90                	xchg   %ax,%ax

000004fc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 4fc:	55                   	push   %ebp
 4fd:	89 e5                	mov    %esp,%ebp
 4ff:	57                   	push   %edi
 500:	56                   	push   %esi
 501:	53                   	push   %ebx
 502:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 505:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 508:	a1 3c 09 00 00       	mov    0x93c,%eax
 50d:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 510:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 512:	39 c8                	cmp    %ecx,%eax
 514:	73 2e                	jae    544 <free+0x48>
 516:	39 d1                	cmp    %edx,%ecx
 518:	72 04                	jb     51e <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 51a:	39 d0                	cmp    %edx,%eax
 51c:	72 2e                	jb     54c <free+0x50>
      break;
  if(bp + bp->s.size == p->s.ptr){
 51e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 521:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 524:	39 d7                	cmp    %edx,%edi
 526:	74 28                	je     550 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 528:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 52b:	8b 50 04             	mov    0x4(%eax),%edx
 52e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 531:	39 f1                	cmp    %esi,%ecx
 533:	74 32                	je     567 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 535:	89 08                	mov    %ecx,(%eax)
  freep = p;
 537:	a3 3c 09 00 00       	mov    %eax,0x93c
}
 53c:	5b                   	pop    %ebx
 53d:	5e                   	pop    %esi
 53e:	5f                   	pop    %edi
 53f:	5d                   	pop    %ebp
 540:	c3                   	ret    
 541:	8d 76 00             	lea    0x0(%esi),%esi
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 544:	39 d0                	cmp    %edx,%eax
 546:	72 04                	jb     54c <free+0x50>
 548:	39 d1                	cmp    %edx,%ecx
 54a:	72 d2                	jb     51e <free+0x22>
static Header base;
static Header *freep;

void
free(void *ap)
{
 54c:	89 d0                	mov    %edx,%eax
 54e:	eb c0                	jmp    510 <free+0x14>
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 550:	03 72 04             	add    0x4(%edx),%esi
 553:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 556:	8b 10                	mov    (%eax),%edx
 558:	8b 12                	mov    (%edx),%edx
 55a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 55d:	8b 50 04             	mov    0x4(%eax),%edx
 560:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 563:	39 f1                	cmp    %esi,%ecx
 565:	75 ce                	jne    535 <free+0x39>
    p->s.size += bp->s.size;
 567:	03 53 fc             	add    -0x4(%ebx),%edx
 56a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 56d:	8b 53 f8             	mov    -0x8(%ebx),%edx
 570:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 572:	a3 3c 09 00 00       	mov    %eax,0x93c
}
 577:	5b                   	pop    %ebx
 578:	5e                   	pop    %esi
 579:	5f                   	pop    %edi
 57a:	5d                   	pop    %ebp
 57b:	c3                   	ret    

0000057c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 57c:	55                   	push   %ebp
 57d:	89 e5                	mov    %esp,%ebp
 57f:	57                   	push   %edi
 580:	56                   	push   %esi
 581:	53                   	push   %ebx
 582:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 585:	8b 45 08             	mov    0x8(%ebp),%eax
 588:	8d 70 07             	lea    0x7(%eax),%esi
 58b:	c1 ee 03             	shr    $0x3,%esi
 58e:	46                   	inc    %esi
  if((prevp = freep) == 0){
 58f:	8b 15 3c 09 00 00    	mov    0x93c,%edx
 595:	85 d2                	test   %edx,%edx
 597:	0f 84 99 00 00 00    	je     636 <malloc+0xba>
 59d:	8b 02                	mov    (%edx),%eax
 59f:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 5a2:	39 ce                	cmp    %ecx,%esi
 5a4:	76 62                	jbe    608 <malloc+0x8c>
 5a6:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 5ad:	eb 0a                	jmp    5b9 <malloc+0x3d>
 5af:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5b0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 5b2:	8b 48 04             	mov    0x4(%eax),%ecx
 5b5:	39 ce                	cmp    %ecx,%esi
 5b7:	76 4f                	jbe    608 <malloc+0x8c>
 5b9:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 5bb:	3b 05 3c 09 00 00    	cmp    0x93c,%eax
 5c1:	75 ed                	jne    5b0 <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 5c3:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 5c9:	77 5d                	ja     628 <malloc+0xac>
 5cb:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 5d0:	bf 00 10 00 00       	mov    $0x1000,%edi
  p = sbrk(nu * sizeof(Header));
 5d5:	83 ec 0c             	sub    $0xc,%esp
 5d8:	50                   	push   %eax
 5d9:	e8 19 fd ff ff       	call   2f7 <sbrk>
  if(p == (char*)-1)
 5de:	83 c4 10             	add    $0x10,%esp
 5e1:	83 f8 ff             	cmp    $0xffffffff,%eax
 5e4:	74 1c                	je     602 <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 5e6:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 5e9:	83 ec 0c             	sub    $0xc,%esp
 5ec:	83 c0 08             	add    $0x8,%eax
 5ef:	50                   	push   %eax
 5f0:	e8 07 ff ff ff       	call   4fc <free>
  return freep;
 5f5:	8b 15 3c 09 00 00    	mov    0x93c,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 5fb:	83 c4 10             	add    $0x10,%esp
 5fe:	85 d2                	test   %edx,%edx
 600:	75 ae                	jne    5b0 <malloc+0x34>
        return 0;
 602:	31 c0                	xor    %eax,%eax
 604:	eb 1a                	jmp    620 <malloc+0xa4>
 606:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 608:	39 ce                	cmp    %ecx,%esi
 60a:	74 24                	je     630 <malloc+0xb4>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 60c:	29 f1                	sub    %esi,%ecx
 60e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 611:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 614:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
 617:	89 15 3c 09 00 00    	mov    %edx,0x93c
      return (void*)(p + 1);
 61d:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 620:	8d 65 f4             	lea    -0xc(%ebp),%esp
 623:	5b                   	pop    %ebx
 624:	5e                   	pop    %esi
 625:	5f                   	pop    %edi
 626:	5d                   	pop    %ebp
 627:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 628:	89 d8                	mov    %ebx,%eax
 62a:	89 f7                	mov    %esi,%edi
 62c:	eb a7                	jmp    5d5 <malloc+0x59>
 62e:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 630:	8b 08                	mov    (%eax),%ecx
 632:	89 0a                	mov    %ecx,(%edx)
 634:	eb e1                	jmp    617 <malloc+0x9b>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 636:	c7 05 3c 09 00 00 40 	movl   $0x940,0x93c
 63d:	09 00 00 
 640:	c7 05 40 09 00 00 40 	movl   $0x940,0x940
 647:	09 00 00 
    base.s.size = 0;
 64a:	c7 05 44 09 00 00 00 	movl   $0x0,0x944
 651:	00 00 00 
 654:	b8 40 09 00 00       	mov    $0x940,%eax
 659:	e9 48 ff ff ff       	jmp    5a6 <malloc+0x2a>
