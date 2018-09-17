
_grep:     file format elf32-i386


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
  14:	8b 01                	mov    (%ecx),%eax
  16:	89 45 e0             	mov    %eax,-0x20(%ebp)
  19:	8b 59 04             	mov    0x4(%ecx),%ebx
  int fd, i;
  char *pattern;

  if(argc <= 1){
  1c:	48                   	dec    %eax
  1d:	7e 70                	jle    8f <main+0x8f>
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
  1f:	8b 7b 04             	mov    0x4(%ebx),%edi

  if(argc <= 2){
  22:	83 7d e0 02          	cmpl   $0x2,-0x20(%ebp)
  26:	74 58                	je     80 <main+0x80>
  28:	83 c3 08             	add    $0x8,%ebx
  2b:	be 02 00 00 00       	mov    $0x2,%esi
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  30:	83 ec 08             	sub    $0x8,%esp
  33:	6a 00                	push   $0x0
  35:	ff 33                	pushl  (%ebx)
  37:	e8 47 04 00 00       	call   483 <open>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	85 c0                	test   %eax,%eax
  41:	78 29                	js     6c <main+0x6c>
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  43:	83 ec 08             	sub    $0x8,%esp
  46:	50                   	push   %eax
  47:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  4a:	57                   	push   %edi
  4b:	e8 64 01 00 00       	call   1b4 <grep>
    close(fd);
  50:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  53:	89 04 24             	mov    %eax,(%esp)
  56:	e8 10 04 00 00       	call   46b <close>
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
  5b:	46                   	inc    %esi
  5c:	83 c3 04             	add    $0x4,%ebx
  5f:	83 c4 10             	add    $0x10,%esp
  62:	39 75 e0             	cmp    %esi,-0x20(%ebp)
  65:	7f c9                	jg     30 <main+0x30>
      exit();
    }
    grep(pattern, fd);
    close(fd);
  }
  exit();
  67:	e8 d7 03 00 00       	call   443 <exit>
    exit();
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
  6c:	50                   	push   %eax
  6d:	ff 33                	pushl  (%ebx)
  6f:	68 54 08 00 00       	push   $0x854
  74:	6a 01                	push   $0x1
  76:	e8 e9 04 00 00       	call   564 <printf>
      exit();
  7b:	e8 c3 03 00 00       	call   443 <exit>
    exit();
  }
  pattern = argv[1];

  if(argc <= 2){
    grep(pattern, 0);
  80:	52                   	push   %edx
  81:	52                   	push   %edx
  82:	6a 00                	push   $0x0
  84:	57                   	push   %edi
  85:	e8 2a 01 00 00       	call   1b4 <grep>
    exit();
  8a:	e8 b4 03 00 00       	call   443 <exit>
{
  int fd, i;
  char *pattern;

  if(argc <= 1){
    printf(2, "usage: grep pattern [file ...]\n");
  8f:	51                   	push   %ecx
  90:	51                   	push   %ecx
  91:	68 34 08 00 00       	push   $0x834
  96:	6a 02                	push   $0x2
  98:	e8 c7 04 00 00       	call   564 <printf>
    exit();
  9d:	e8 a1 03 00 00       	call   443 <exit>
  a2:	66 90                	xchg   %ax,%ax

000000a4 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  a4:	55                   	push   %ebp
  a5:	89 e5                	mov    %esp,%ebp
  a7:	57                   	push   %edi
  a8:	56                   	push   %esi
  a9:	53                   	push   %ebx
  aa:	83 ec 0c             	sub    $0xc,%esp
  ad:	8b 5d 08             	mov    0x8(%ebp),%ebx
  b0:	8b 75 0c             	mov    0xc(%ebp),%esi
  b3:	8b 7d 10             	mov    0x10(%ebp),%edi
  b6:	66 90                	xchg   %ax,%ax
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
  b8:	83 ec 08             	sub    $0x8,%esp
  bb:	57                   	push   %edi
  bc:	56                   	push   %esi
  bd:	e8 32 00 00 00       	call   f4 <matchhere>
  c2:	83 c4 10             	add    $0x10,%esp
  c5:	85 c0                	test   %eax,%eax
  c7:	75 1b                	jne    e4 <matchstar+0x40>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  c9:	0f be 17             	movsbl (%edi),%edx
  cc:	84 d2                	test   %dl,%dl
  ce:	74 0a                	je     da <matchstar+0x36>
  d0:	47                   	inc    %edi
  d1:	39 da                	cmp    %ebx,%edx
  d3:	74 e3                	je     b8 <matchstar+0x14>
  d5:	83 fb 2e             	cmp    $0x2e,%ebx
  d8:	74 de                	je     b8 <matchstar+0x14>
  return 0;
}
  da:	8d 65 f4             	lea    -0xc(%ebp),%esp
  dd:	5b                   	pop    %ebx
  de:	5e                   	pop    %esi
  df:	5f                   	pop    %edi
  e0:	5d                   	pop    %ebp
  e1:	c3                   	ret    
  e2:	66 90                	xchg   %ax,%ax
// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  e4:	b8 01 00 00 00       	mov    $0x1,%eax
  }while(*text!='\0' && (*text++==c || c=='.'));
  return 0;
}
  e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ec:	5b                   	pop    %ebx
  ed:	5e                   	pop    %esi
  ee:	5f                   	pop    %edi
  ef:	5d                   	pop    %ebp
  f0:	c3                   	ret    
  f1:	8d 76 00             	lea    0x0(%esi),%esi

000000f4 <matchhere>:
  return 0;
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  f4:	55                   	push   %ebp
  f5:	89 e5                	mov    %esp,%ebp
  f7:	53                   	push   %ebx
  f8:	50                   	push   %eax
  f9:	8b 55 08             	mov    0x8(%ebp),%edx
  fc:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  if(re[0] == '\0')
  ff:	0f be 02             	movsbl (%edx),%eax
 102:	84 c0                	test   %al,%al
 104:	75 19                	jne    11f <matchhere+0x2b>
 106:	eb 38                	jmp    140 <matchhere+0x4c>
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 108:	8a 19                	mov    (%ecx),%bl
 10a:	84 db                	test   %bl,%bl
 10c:	74 2a                	je     138 <matchhere+0x44>
 10e:	3c 2e                	cmp    $0x2e,%al
 110:	74 04                	je     116 <matchhere+0x22>
 112:	38 d8                	cmp    %bl,%al
 114:	75 22                	jne    138 <matchhere+0x44>
    return matchhere(re+1, text+1);
 116:	41                   	inc    %ecx
 117:	42                   	inc    %edx
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
 118:	0f be 02             	movsbl (%edx),%eax
 11b:	84 c0                	test   %al,%al
 11d:	74 21                	je     140 <matchhere+0x4c>
    return 1;
  if(re[1] == '*')
 11f:	8a 5a 01             	mov    0x1(%edx),%bl
 122:	80 fb 2a             	cmp    $0x2a,%bl
 125:	74 25                	je     14c <matchhere+0x58>
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
 127:	3c 24                	cmp    $0x24,%al
 129:	75 dd                	jne    108 <matchhere+0x14>
 12b:	84 db                	test   %bl,%bl
 12d:	74 31                	je     160 <matchhere+0x6c>
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 12f:	8a 19                	mov    (%ecx),%bl
 131:	84 db                	test   %bl,%bl
 133:	75 dd                	jne    112 <matchhere+0x1e>
 135:	8d 76 00             	lea    0x0(%esi),%esi
    return matchhere(re+1, text+1);
  return 0;
 138:	31 c0                	xor    %eax,%eax
}
 13a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 13d:	c9                   	leave  
 13e:	c3                   	ret    
 13f:	90                   	nop

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    return 1;
 140:	b8 01 00 00 00       	mov    $0x1,%eax
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}
 145:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 148:	c9                   	leave  
 149:	c3                   	ret    
 14a:	66 90                	xchg   %ax,%ax
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
 14c:	53                   	push   %ebx
 14d:	51                   	push   %ecx
 14e:	83 c2 02             	add    $0x2,%edx
 151:	52                   	push   %edx
 152:	50                   	push   %eax
 153:	e8 4c ff ff ff       	call   a4 <matchstar>
 158:	83 c4 10             	add    $0x10,%esp
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}
 15b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 15e:	c9                   	leave  
 15f:	c3                   	ret    
  if(re[0] == '\0')
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
 160:	31 c0                	xor    %eax,%eax
 162:	80 39 00             	cmpb   $0x0,(%ecx)
 165:	0f 94 c0             	sete   %al
 168:	eb d0                	jmp    13a <matchhere+0x46>
 16a:	66 90                	xchg   %ax,%ax

0000016c <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
 16c:	55                   	push   %ebp
 16d:	89 e5                	mov    %esp,%ebp
 16f:	56                   	push   %esi
 170:	53                   	push   %ebx
 171:	8b 75 08             	mov    0x8(%ebp),%esi
 174:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '^')
 177:	80 3e 5e             	cmpb   $0x5e,(%esi)
 17a:	75 0b                	jne    187 <match+0x1b>
 17c:	eb 26                	jmp    1a4 <match+0x38>
 17e:	66 90                	xchg   %ax,%ax
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
 180:	43                   	inc    %ebx
 181:	80 7b ff 00          	cmpb   $0x0,-0x1(%ebx)
 185:	74 16                	je     19d <match+0x31>
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
 187:	83 ec 08             	sub    $0x8,%esp
 18a:	53                   	push   %ebx
 18b:	56                   	push   %esi
 18c:	e8 63 ff ff ff       	call   f4 <matchhere>
 191:	83 c4 10             	add    $0x10,%esp
 194:	85 c0                	test   %eax,%eax
 196:	74 e8                	je     180 <match+0x14>
      return 1;
 198:	b8 01 00 00 00       	mov    $0x1,%eax
  }while(*text++ != '\0');
  return 0;
}
 19d:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1a0:	5b                   	pop    %ebx
 1a1:	5e                   	pop    %esi
 1a2:	5d                   	pop    %ebp
 1a3:	c3                   	ret    

int
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
 1a4:	46                   	inc    %esi
 1a5:	89 75 08             	mov    %esi,0x8(%ebp)
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
  return 0;
}
 1a8:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1ab:	5b                   	pop    %ebx
 1ac:	5e                   	pop    %esi
 1ad:	5d                   	pop    %ebp

int
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
 1ae:	e9 41 ff ff ff       	jmp    f4 <matchhere>
 1b3:	90                   	nop

000001b4 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
 1b4:	55                   	push   %ebp
 1b5:	89 e5                	mov    %esp,%ebp
 1b7:	57                   	push   %edi
 1b8:	56                   	push   %esi
 1b9:	53                   	push   %ebx
 1ba:	83 ec 1c             	sub    $0x1c,%esp
 1bd:	8b 7d 08             	mov    0x8(%ebp),%edi
  int n, m;
  char *p, *q;

  m = 0;
 1c0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 1c7:	90                   	nop
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 1c8:	50                   	push   %eax
 1c9:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 1ce:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 1d1:	29 c8                	sub    %ecx,%eax
 1d3:	50                   	push   %eax
 1d4:	8d 81 00 0c 00 00    	lea    0xc00(%ecx),%eax
 1da:	50                   	push   %eax
 1db:	ff 75 0c             	pushl  0xc(%ebp)
 1de:	e8 78 02 00 00       	call   45b <read>
 1e3:	83 c4 10             	add    $0x10,%esp
 1e6:	85 c0                	test   %eax,%eax
 1e8:	0f 8e a2 00 00 00    	jle    290 <grep+0xdc>
    m += n;
 1ee:	01 45 e4             	add    %eax,-0x1c(%ebp)
 1f1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    buf[m] = '\0';
 1f4:	c6 82 00 0c 00 00 00 	movb   $0x0,0xc00(%edx)
    p = buf;
 1fb:	be 00 0c 00 00       	mov    $0xc00,%esi
    while((q = strchr(p, '\n')) != 0){
 200:	83 ec 08             	sub    $0x8,%esp
 203:	6a 0a                	push   $0xa
 205:	56                   	push   %esi
 206:	e8 1d 01 00 00       	call   328 <strchr>
 20b:	89 c3                	mov    %eax,%ebx
 20d:	83 c4 10             	add    $0x10,%esp
 210:	85 c0                	test   %eax,%eax
 212:	74 38                	je     24c <grep+0x98>
      *q = 0;
 214:	c6 03 00             	movb   $0x0,(%ebx)
      if(match(pattern, p)){
 217:	83 ec 08             	sub    $0x8,%esp
 21a:	56                   	push   %esi
 21b:	57                   	push   %edi
 21c:	e8 4b ff ff ff       	call   16c <match>
 221:	83 c4 10             	add    $0x10,%esp
 224:	85 c0                	test   %eax,%eax
 226:	75 08                	jne    230 <grep+0x7c>
 228:	8d 73 01             	lea    0x1(%ebx),%esi
 22b:	eb d3                	jmp    200 <grep+0x4c>
 22d:	8d 76 00             	lea    0x0(%esi),%esi
        *q = '\n';
 230:	c6 03 0a             	movb   $0xa,(%ebx)
        write(1, p, q+1 - p);
 233:	43                   	inc    %ebx
 234:	50                   	push   %eax
 235:	89 d8                	mov    %ebx,%eax
 237:	29 f0                	sub    %esi,%eax
 239:	50                   	push   %eax
 23a:	56                   	push   %esi
 23b:	6a 01                	push   $0x1
 23d:	e8 21 02 00 00       	call   463 <write>
 242:	83 c4 10             	add    $0x10,%esp
 245:	89 de                	mov    %ebx,%esi
 247:	eb b7                	jmp    200 <grep+0x4c>
 249:	8d 76 00             	lea    0x0(%esi),%esi
      }
      p = q+1;
    }
    if(p == buf)
 24c:	81 fe 00 0c 00 00    	cmp    $0xc00,%esi
 252:	74 30                	je     284 <grep+0xd0>
      m = 0;
    if(m > 0){
 254:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 257:	85 c9                	test   %ecx,%ecx
 259:	0f 8e 69 ff ff ff    	jle    1c8 <grep+0x14>
      m -= p - buf;
 25f:	b8 00 0c 00 00       	mov    $0xc00,%eax
 264:	29 f0                	sub    %esi,%eax
 266:	01 45 e4             	add    %eax,-0x1c(%ebp)
 269:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
      memmove(buf, p, m);
 26c:	52                   	push   %edx
 26d:	51                   	push   %ecx
 26e:	56                   	push   %esi
 26f:	68 00 0c 00 00       	push   $0xc00
 274:	e8 9f 01 00 00       	call   418 <memmove>
 279:	83 c4 10             	add    $0x10,%esp
 27c:	e9 47 ff ff ff       	jmp    1c8 <grep+0x14>
 281:	8d 76 00             	lea    0x0(%esi),%esi
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
      m = 0;
 284:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 28b:	e9 38 ff ff ff       	jmp    1c8 <grep+0x14>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
 290:	8d 65 f4             	lea    -0xc(%ebp),%esp
 293:	5b                   	pop    %ebx
 294:	5e                   	pop    %esi
 295:	5f                   	pop    %edi
 296:	5d                   	pop    %ebp
 297:	c3                   	ret    

00000298 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 298:	55                   	push   %ebp
 299:	89 e5                	mov    %esp,%ebp
 29b:	53                   	push   %ebx
 29c:	8b 45 08             	mov    0x8(%ebp),%eax
 29f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2a2:	89 c2                	mov    %eax,%edx
 2a4:	42                   	inc    %edx
 2a5:	41                   	inc    %ecx
 2a6:	8a 59 ff             	mov    -0x1(%ecx),%bl
 2a9:	88 5a ff             	mov    %bl,-0x1(%edx)
 2ac:	84 db                	test   %bl,%bl
 2ae:	75 f4                	jne    2a4 <strcpy+0xc>
    ;
  return os;
}
 2b0:	5b                   	pop    %ebx
 2b1:	5d                   	pop    %ebp
 2b2:	c3                   	ret    
 2b3:	90                   	nop

000002b4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2b4:	55                   	push   %ebp
 2b5:	89 e5                	mov    %esp,%ebp
 2b7:	56                   	push   %esi
 2b8:	53                   	push   %ebx
 2b9:	8b 55 08             	mov    0x8(%ebp),%edx
 2bc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 2bf:	0f b6 02             	movzbl (%edx),%eax
 2c2:	0f b6 0b             	movzbl (%ebx),%ecx
 2c5:	84 c0                	test   %al,%al
 2c7:	75 14                	jne    2dd <strcmp+0x29>
 2c9:	eb 1d                	jmp    2e8 <strcmp+0x34>
 2cb:	90                   	nop
    p++, q++;
 2cc:	42                   	inc    %edx
 2cd:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2d0:	0f b6 02             	movzbl (%edx),%eax
 2d3:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 2d7:	84 c0                	test   %al,%al
 2d9:	74 0d                	je     2e8 <strcmp+0x34>
 2db:	89 f3                	mov    %esi,%ebx
 2dd:	38 c8                	cmp    %cl,%al
 2df:	74 eb                	je     2cc <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 2e1:	29 c8                	sub    %ecx,%eax
}
 2e3:	5b                   	pop    %ebx
 2e4:	5e                   	pop    %esi
 2e5:	5d                   	pop    %ebp
 2e6:	c3                   	ret    
 2e7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2e8:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 2ea:	29 c8                	sub    %ecx,%eax
}
 2ec:	5b                   	pop    %ebx
 2ed:	5e                   	pop    %esi
 2ee:	5d                   	pop    %ebp
 2ef:	c3                   	ret    

000002f0 <strlen>:

uint
strlen(char *s)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 2f6:	80 39 00             	cmpb   $0x0,(%ecx)
 2f9:	74 10                	je     30b <strlen+0x1b>
 2fb:	31 d2                	xor    %edx,%edx
 2fd:	8d 76 00             	lea    0x0(%esi),%esi
 300:	42                   	inc    %edx
 301:	89 d0                	mov    %edx,%eax
 303:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 307:	75 f7                	jne    300 <strlen+0x10>
    ;
  return n;
}
 309:	5d                   	pop    %ebp
 30a:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 30b:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 30d:	5d                   	pop    %ebp
 30e:	c3                   	ret    
 30f:	90                   	nop

00000310 <memset>:

void*
memset(void *dst, int c, uint n)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	57                   	push   %edi
 314:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 317:	89 d7                	mov    %edx,%edi
 319:	8b 4d 10             	mov    0x10(%ebp),%ecx
 31c:	8b 45 0c             	mov    0xc(%ebp),%eax
 31f:	fc                   	cld    
 320:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 322:	89 d0                	mov    %edx,%eax
 324:	5f                   	pop    %edi
 325:	5d                   	pop    %ebp
 326:	c3                   	ret    
 327:	90                   	nop

00000328 <strchr>:

char*
strchr(const char *s, char c)
{
 328:	55                   	push   %ebp
 329:	89 e5                	mov    %esp,%ebp
 32b:	53                   	push   %ebx
 32c:	8b 45 08             	mov    0x8(%ebp),%eax
 32f:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 332:	8a 18                	mov    (%eax),%bl
 334:	84 db                	test   %bl,%bl
 336:	74 13                	je     34b <strchr+0x23>
 338:	88 d1                	mov    %dl,%cl
    if(*s == c)
 33a:	38 d3                	cmp    %dl,%bl
 33c:	75 06                	jne    344 <strchr+0x1c>
 33e:	eb 0d                	jmp    34d <strchr+0x25>
 340:	38 ca                	cmp    %cl,%dl
 342:	74 09                	je     34d <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 344:	40                   	inc    %eax
 345:	8a 10                	mov    (%eax),%dl
 347:	84 d2                	test   %dl,%dl
 349:	75 f5                	jne    340 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 34b:	31 c0                	xor    %eax,%eax
}
 34d:	5b                   	pop    %ebx
 34e:	5d                   	pop    %ebp
 34f:	c3                   	ret    

00000350 <gets>:

char*
gets(char *buf, int max)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	56                   	push   %esi
 355:	53                   	push   %ebx
 356:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 359:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 35b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 35e:	eb 26                	jmp    386 <gets+0x36>
    cc = read(0, &c, 1);
 360:	50                   	push   %eax
 361:	6a 01                	push   $0x1
 363:	57                   	push   %edi
 364:	6a 00                	push   $0x0
 366:	e8 f0 00 00 00       	call   45b <read>
    if(cc < 1)
 36b:	83 c4 10             	add    $0x10,%esp
 36e:	85 c0                	test   %eax,%eax
 370:	7e 1c                	jle    38e <gets+0x3e>
      break;
    buf[i++] = c;
 372:	8a 45 e7             	mov    -0x19(%ebp),%al
 375:	8b 55 08             	mov    0x8(%ebp),%edx
 378:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
 37c:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 37e:	3c 0a                	cmp    $0xa,%al
 380:	74 0c                	je     38e <gets+0x3e>
 382:	3c 0d                	cmp    $0xd,%al
 384:	74 08                	je     38e <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 386:	8d 5e 01             	lea    0x1(%esi),%ebx
 389:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 38c:	7c d2                	jl     360 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 38e:	8b 45 08             	mov    0x8(%ebp),%eax
 391:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 395:	8d 65 f4             	lea    -0xc(%ebp),%esp
 398:	5b                   	pop    %ebx
 399:	5e                   	pop    %esi
 39a:	5f                   	pop    %edi
 39b:	5d                   	pop    %ebp
 39c:	c3                   	ret    
 39d:	8d 76 00             	lea    0x0(%esi),%esi

000003a0 <stat>:

int
stat(char *n, struct stat *st)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	56                   	push   %esi
 3a4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3a5:	83 ec 08             	sub    $0x8,%esp
 3a8:	6a 00                	push   $0x0
 3aa:	ff 75 08             	pushl  0x8(%ebp)
 3ad:	e8 d1 00 00 00       	call   483 <open>
 3b2:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 3b4:	83 c4 10             	add    $0x10,%esp
 3b7:	85 c0                	test   %eax,%eax
 3b9:	78 25                	js     3e0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 3bb:	83 ec 08             	sub    $0x8,%esp
 3be:	ff 75 0c             	pushl  0xc(%ebp)
 3c1:	50                   	push   %eax
 3c2:	e8 d4 00 00 00       	call   49b <fstat>
 3c7:	89 c6                	mov    %eax,%esi
  close(fd);
 3c9:	89 1c 24             	mov    %ebx,(%esp)
 3cc:	e8 9a 00 00 00       	call   46b <close>
  return r;
 3d1:	83 c4 10             	add    $0x10,%esp
 3d4:	89 f0                	mov    %esi,%eax
}
 3d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3d9:	5b                   	pop    %ebx
 3da:	5e                   	pop    %esi
 3db:	5d                   	pop    %ebp
 3dc:	c3                   	ret    
 3dd:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 3e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 3e5:	eb ef                	jmp    3d6 <stat+0x36>
 3e7:	90                   	nop

000003e8 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 3e8:	55                   	push   %ebp
 3e9:	89 e5                	mov    %esp,%ebp
 3eb:	53                   	push   %ebx
 3ec:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3ef:	0f be 11             	movsbl (%ecx),%edx
 3f2:	8d 42 d0             	lea    -0x30(%edx),%eax
 3f5:	3c 09                	cmp    $0x9,%al
 3f7:	b8 00 00 00 00       	mov    $0x0,%eax
 3fc:	77 15                	ja     413 <atoi+0x2b>
 3fe:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 400:	41                   	inc    %ecx
 401:	8d 04 80             	lea    (%eax,%eax,4),%eax
 404:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 408:	0f be 11             	movsbl (%ecx),%edx
 40b:	8d 5a d0             	lea    -0x30(%edx),%ebx
 40e:	80 fb 09             	cmp    $0x9,%bl
 411:	76 ed                	jbe    400 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 413:	5b                   	pop    %ebx
 414:	5d                   	pop    %ebp
 415:	c3                   	ret    
 416:	66 90                	xchg   %ax,%ax

00000418 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 418:	55                   	push   %ebp
 419:	89 e5                	mov    %esp,%ebp
 41b:	56                   	push   %esi
 41c:	53                   	push   %ebx
 41d:	8b 45 08             	mov    0x8(%ebp),%eax
 420:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 423:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 426:	31 d2                	xor    %edx,%edx
 428:	85 f6                	test   %esi,%esi
 42a:	7e 0b                	jle    437 <memmove+0x1f>
    *dst++ = *src++;
 42c:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 42f:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 432:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 433:	39 f2                	cmp    %esi,%edx
 435:	75 f5                	jne    42c <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 437:	5b                   	pop    %ebx
 438:	5e                   	pop    %esi
 439:	5d                   	pop    %ebp
 43a:	c3                   	ret    

0000043b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 43b:	b8 01 00 00 00       	mov    $0x1,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <exit>:
SYSCALL(exit)
 443:	b8 02 00 00 00       	mov    $0x2,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <wait>:
SYSCALL(wait)
 44b:	b8 03 00 00 00       	mov    $0x3,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <pipe>:
SYSCALL(pipe)
 453:	b8 04 00 00 00       	mov    $0x4,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <read>:
SYSCALL(read)
 45b:	b8 05 00 00 00       	mov    $0x5,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <write>:
SYSCALL(write)
 463:	b8 10 00 00 00       	mov    $0x10,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <close>:
SYSCALL(close)
 46b:	b8 15 00 00 00       	mov    $0x15,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <kill>:
SYSCALL(kill)
 473:	b8 06 00 00 00       	mov    $0x6,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <exec>:
SYSCALL(exec)
 47b:	b8 07 00 00 00       	mov    $0x7,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <open>:
SYSCALL(open)
 483:	b8 0f 00 00 00       	mov    $0xf,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <mknod>:
SYSCALL(mknod)
 48b:	b8 11 00 00 00       	mov    $0x11,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <unlink>:
SYSCALL(unlink)
 493:	b8 12 00 00 00       	mov    $0x12,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <fstat>:
SYSCALL(fstat)
 49b:	b8 08 00 00 00       	mov    $0x8,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <link>:
SYSCALL(link)
 4a3:	b8 13 00 00 00       	mov    $0x13,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    

000004ab <mkdir>:
SYSCALL(mkdir)
 4ab:	b8 14 00 00 00       	mov    $0x14,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <chdir>:
SYSCALL(chdir)
 4b3:	b8 09 00 00 00       	mov    $0x9,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    

000004bb <dup>:
SYSCALL(dup)
 4bb:	b8 0a 00 00 00       	mov    $0xa,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret    

000004c3 <getpid>:
SYSCALL(getpid)
 4c3:	b8 0b 00 00 00       	mov    $0xb,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret    

000004cb <sbrk>:
SYSCALL(sbrk)
 4cb:	b8 0c 00 00 00       	mov    $0xc,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret    

000004d3 <sleep>:
SYSCALL(sleep)
 4d3:	b8 0d 00 00 00       	mov    $0xd,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret    

000004db <uptime>:
SYSCALL(uptime)
 4db:	b8 0e 00 00 00       	mov    $0xe,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret    

000004e3 <mike>:
SYSCALL(mike)
 4e3:	b8 16 00 00 00       	mov    $0x16,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret    
 4eb:	90                   	nop

000004ec <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4ec:	55                   	push   %ebp
 4ed:	89 e5                	mov    %esp,%ebp
 4ef:	57                   	push   %edi
 4f0:	56                   	push   %esi
 4f1:	53                   	push   %ebx
 4f2:	83 ec 3c             	sub    $0x3c,%esp
 4f5:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4f7:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
 4fc:	85 db                	test   %ebx,%ebx
 4fe:	74 04                	je     504 <printint+0x18>
 500:	85 d2                	test   %edx,%edx
 502:	78 53                	js     557 <printint+0x6b>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 504:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 50b:	31 db                	xor    %ebx,%ebx
 50d:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 510:	43                   	inc    %ebx
 511:	31 d2                	xor    %edx,%edx
 513:	f7 f1                	div    %ecx
 515:	8a 92 74 08 00 00    	mov    0x874(%edx),%dl
 51b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 51e:	85 c0                	test   %eax,%eax
 520:	75 ee                	jne    510 <printint+0x24>
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 522:	89 d8                	mov    %ebx,%eax
  }while((x /= base) != 0);
  if(neg)
 524:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 527:	85 d2                	test   %edx,%edx
 529:	74 06                	je     531 <printint+0x45>
    buf[i++] = '-';
 52b:	43                   	inc    %ebx
 52c:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 531:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 535:	8d 76 00             	lea    0x0(%esi),%esi
 538:	8a 03                	mov    (%ebx),%al
 53a:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 53d:	50                   	push   %eax
 53e:	6a 01                	push   $0x1
 540:	56                   	push   %esi
 541:	57                   	push   %edi
 542:	e8 1c ff ff ff       	call   463 <write>
 547:	4b                   	dec    %ebx
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 548:	83 c4 10             	add    $0x10,%esp
 54b:	39 f3                	cmp    %esi,%ebx
 54d:	75 e9                	jne    538 <printint+0x4c>
    putc(fd, buf[i]);
}
 54f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 552:	5b                   	pop    %ebx
 553:	5e                   	pop    %esi
 554:	5f                   	pop    %edi
 555:	5d                   	pop    %ebp
 556:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 557:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 559:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 560:	eb a9                	jmp    50b <printint+0x1f>
 562:	66 90                	xchg   %ax,%ax

00000564 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 564:	55                   	push   %ebp
 565:	89 e5                	mov    %esp,%ebp
 567:	57                   	push   %edi
 568:	56                   	push   %esi
 569:	53                   	push   %ebx
 56a:	83 ec 2c             	sub    $0x2c,%esp
 56d:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 570:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 573:	8a 13                	mov    (%ebx),%dl
 575:	84 d2                	test   %dl,%dl
 577:	0f 84 a3 00 00 00    	je     620 <printf+0xbc>
 57d:	43                   	inc    %ebx
 57e:	8d 45 10             	lea    0x10(%ebp),%eax
 581:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 584:	31 ff                	xor    %edi,%edi
 586:	eb 24                	jmp    5ac <printf+0x48>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 588:	83 fa 25             	cmp    $0x25,%edx
 58b:	0f 84 97 00 00 00    	je     628 <printf+0xc4>
        state = '%';
      } else {
        putc(fd, c);
 591:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 594:	50                   	push   %eax
 595:	6a 01                	push   $0x1
 597:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 59a:	50                   	push   %eax
 59b:	56                   	push   %esi
 59c:	e8 c2 fe ff ff       	call   463 <write>
 5a1:	83 c4 10             	add    $0x10,%esp
 5a4:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5a5:	8a 53 ff             	mov    -0x1(%ebx),%dl
 5a8:	84 d2                	test   %dl,%dl
 5aa:	74 74                	je     620 <printf+0xbc>
    c = fmt[i] & 0xff;
 5ac:	0f be c2             	movsbl %dl,%eax
 5af:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
 5b2:	85 ff                	test   %edi,%edi
 5b4:	74 d2                	je     588 <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5b6:	83 ff 25             	cmp    $0x25,%edi
 5b9:	75 e9                	jne    5a4 <printf+0x40>
      if(c == 'd'){
 5bb:	83 fa 64             	cmp    $0x64,%edx
 5be:	0f 84 e8 00 00 00    	je     6ac <printf+0x148>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5c4:	25 f7 00 00 00       	and    $0xf7,%eax
 5c9:	83 f8 70             	cmp    $0x70,%eax
 5cc:	74 66                	je     634 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5ce:	83 fa 73             	cmp    $0x73,%edx
 5d1:	0f 84 85 00 00 00    	je     65c <printf+0xf8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5d7:	83 fa 63             	cmp    $0x63,%edx
 5da:	0f 84 b5 00 00 00    	je     695 <printf+0x131>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5e0:	83 fa 25             	cmp    $0x25,%edx
 5e3:	0f 84 cf 00 00 00    	je     6b8 <printf+0x154>
 5e9:	89 55 d0             	mov    %edx,-0x30(%ebp)
 5ec:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5f0:	50                   	push   %eax
 5f1:	6a 01                	push   $0x1
 5f3:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5f6:	50                   	push   %eax
 5f7:	56                   	push   %esi
 5f8:	e8 66 fe ff ff       	call   463 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5fd:	8b 55 d0             	mov    -0x30(%ebp),%edx
 600:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 603:	83 c4 0c             	add    $0xc,%esp
 606:	6a 01                	push   $0x1
 608:	8d 45 e7             	lea    -0x19(%ebp),%eax
 60b:	50                   	push   %eax
 60c:	56                   	push   %esi
 60d:	e8 51 fe ff ff       	call   463 <write>
 612:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 615:	31 ff                	xor    %edi,%edi
 617:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 618:	8a 53 ff             	mov    -0x1(%ebx),%dl
 61b:	84 d2                	test   %dl,%dl
 61d:	75 8d                	jne    5ac <printf+0x48>
 61f:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 620:	8d 65 f4             	lea    -0xc(%ebp),%esp
 623:	5b                   	pop    %ebx
 624:	5e                   	pop    %esi
 625:	5f                   	pop    %edi
 626:	5d                   	pop    %ebp
 627:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 628:	bf 25 00 00 00       	mov    $0x25,%edi
 62d:	e9 72 ff ff ff       	jmp    5a4 <printf+0x40>
 632:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 634:	83 ec 0c             	sub    $0xc,%esp
 637:	6a 00                	push   $0x0
 639:	b9 10 00 00 00       	mov    $0x10,%ecx
 63e:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 641:	8b 17                	mov    (%edi),%edx
 643:	89 f0                	mov    %esi,%eax
 645:	e8 a2 fe ff ff       	call   4ec <printint>
        ap++;
 64a:	89 f8                	mov    %edi,%eax
 64c:	83 c0 04             	add    $0x4,%eax
 64f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 652:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 655:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 657:	e9 48 ff ff ff       	jmp    5a4 <printf+0x40>
      } else if(c == 's'){
        s = (char*)*ap;
 65c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 65f:	8b 38                	mov    (%eax),%edi
        ap++;
 661:	83 c0 04             	add    $0x4,%eax
 664:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 667:	85 ff                	test   %edi,%edi
 669:	74 5c                	je     6c7 <printf+0x163>
          s = "(null)";
        while(*s != 0){
 66b:	8a 07                	mov    (%edi),%al
 66d:	84 c0                	test   %al,%al
 66f:	74 1d                	je     68e <printf+0x12a>
 671:	8d 76 00             	lea    0x0(%esi),%esi
 674:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 677:	50                   	push   %eax
 678:	6a 01                	push   $0x1
 67a:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 67d:	50                   	push   %eax
 67e:	56                   	push   %esi
 67f:	e8 df fd ff ff       	call   463 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 684:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 685:	8a 07                	mov    (%edi),%al
 687:	83 c4 10             	add    $0x10,%esp
 68a:	84 c0                	test   %al,%al
 68c:	75 e6                	jne    674 <printf+0x110>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 68e:	31 ff                	xor    %edi,%edi
 690:	e9 0f ff ff ff       	jmp    5a4 <printf+0x40>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 695:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 698:	8b 07                	mov    (%edi),%eax
 69a:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 69d:	51                   	push   %ecx
 69e:	6a 01                	push   $0x1
 6a0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6a3:	50                   	push   %eax
 6a4:	56                   	push   %esi
 6a5:	e8 b9 fd ff ff       	call   463 <write>
 6aa:	eb 9e                	jmp    64a <printf+0xe6>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6ac:	83 ec 0c             	sub    $0xc,%esp
 6af:	6a 01                	push   $0x1
 6b1:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6b6:	eb 86                	jmp    63e <printf+0xda>
 6b8:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6bc:	52                   	push   %edx
 6bd:	6a 01                	push   $0x1
 6bf:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 6c2:	e9 44 ff ff ff       	jmp    60b <printf+0xa7>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 6c7:	bf 6a 08 00 00       	mov    $0x86a,%edi
 6cc:	eb 9d                	jmp    66b <printf+0x107>
 6ce:	66 90                	xchg   %ax,%ax

000006d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6d0:	55                   	push   %ebp
 6d1:	89 e5                	mov    %esp,%ebp
 6d3:	57                   	push   %edi
 6d4:	56                   	push   %esi
 6d5:	53                   	push   %ebx
 6d6:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6d9:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6dc:	a1 e0 0b 00 00       	mov    0xbe0,%eax
 6e1:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e4:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e6:	39 c8                	cmp    %ecx,%eax
 6e8:	73 2e                	jae    718 <free+0x48>
 6ea:	39 d1                	cmp    %edx,%ecx
 6ec:	72 04                	jb     6f2 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ee:	39 d0                	cmp    %edx,%eax
 6f0:	72 2e                	jb     720 <free+0x50>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6f2:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6f5:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6f8:	39 d7                	cmp    %edx,%edi
 6fa:	74 28                	je     724 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6fc:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6ff:	8b 50 04             	mov    0x4(%eax),%edx
 702:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 705:	39 f1                	cmp    %esi,%ecx
 707:	74 32                	je     73b <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 709:	89 08                	mov    %ecx,(%eax)
  freep = p;
 70b:	a3 e0 0b 00 00       	mov    %eax,0xbe0
}
 710:	5b                   	pop    %ebx
 711:	5e                   	pop    %esi
 712:	5f                   	pop    %edi
 713:	5d                   	pop    %ebp
 714:	c3                   	ret    
 715:	8d 76 00             	lea    0x0(%esi),%esi
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 718:	39 d0                	cmp    %edx,%eax
 71a:	72 04                	jb     720 <free+0x50>
 71c:	39 d1                	cmp    %edx,%ecx
 71e:	72 d2                	jb     6f2 <free+0x22>
static Header base;
static Header *freep;

void
free(void *ap)
{
 720:	89 d0                	mov    %edx,%eax
 722:	eb c0                	jmp    6e4 <free+0x14>
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 724:	03 72 04             	add    0x4(%edx),%esi
 727:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 72a:	8b 10                	mov    (%eax),%edx
 72c:	8b 12                	mov    (%edx),%edx
 72e:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 731:	8b 50 04             	mov    0x4(%eax),%edx
 734:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 737:	39 f1                	cmp    %esi,%ecx
 739:	75 ce                	jne    709 <free+0x39>
    p->s.size += bp->s.size;
 73b:	03 53 fc             	add    -0x4(%ebx),%edx
 73e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 741:	8b 53 f8             	mov    -0x8(%ebx),%edx
 744:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 746:	a3 e0 0b 00 00       	mov    %eax,0xbe0
}
 74b:	5b                   	pop    %ebx
 74c:	5e                   	pop    %esi
 74d:	5f                   	pop    %edi
 74e:	5d                   	pop    %ebp
 74f:	c3                   	ret    

00000750 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	57                   	push   %edi
 754:	56                   	push   %esi
 755:	53                   	push   %ebx
 756:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 759:	8b 45 08             	mov    0x8(%ebp),%eax
 75c:	8d 70 07             	lea    0x7(%eax),%esi
 75f:	c1 ee 03             	shr    $0x3,%esi
 762:	46                   	inc    %esi
  if((prevp = freep) == 0){
 763:	8b 15 e0 0b 00 00    	mov    0xbe0,%edx
 769:	85 d2                	test   %edx,%edx
 76b:	0f 84 99 00 00 00    	je     80a <malloc+0xba>
 771:	8b 02                	mov    (%edx),%eax
 773:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 776:	39 ce                	cmp    %ecx,%esi
 778:	76 62                	jbe    7dc <malloc+0x8c>
 77a:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 781:	eb 0a                	jmp    78d <malloc+0x3d>
 783:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 784:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 786:	8b 48 04             	mov    0x4(%eax),%ecx
 789:	39 ce                	cmp    %ecx,%esi
 78b:	76 4f                	jbe    7dc <malloc+0x8c>
 78d:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 78f:	3b 05 e0 0b 00 00    	cmp    0xbe0,%eax
 795:	75 ed                	jne    784 <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 797:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 79d:	77 5d                	ja     7fc <malloc+0xac>
 79f:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 7a4:	bf 00 10 00 00       	mov    $0x1000,%edi
  p = sbrk(nu * sizeof(Header));
 7a9:	83 ec 0c             	sub    $0xc,%esp
 7ac:	50                   	push   %eax
 7ad:	e8 19 fd ff ff       	call   4cb <sbrk>
  if(p == (char*)-1)
 7b2:	83 c4 10             	add    $0x10,%esp
 7b5:	83 f8 ff             	cmp    $0xffffffff,%eax
 7b8:	74 1c                	je     7d6 <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 7ba:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 7bd:	83 ec 0c             	sub    $0xc,%esp
 7c0:	83 c0 08             	add    $0x8,%eax
 7c3:	50                   	push   %eax
 7c4:	e8 07 ff ff ff       	call   6d0 <free>
  return freep;
 7c9:	8b 15 e0 0b 00 00    	mov    0xbe0,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 7cf:	83 c4 10             	add    $0x10,%esp
 7d2:	85 d2                	test   %edx,%edx
 7d4:	75 ae                	jne    784 <malloc+0x34>
        return 0;
 7d6:	31 c0                	xor    %eax,%eax
 7d8:	eb 1a                	jmp    7f4 <malloc+0xa4>
 7da:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 7dc:	39 ce                	cmp    %ecx,%esi
 7de:	74 24                	je     804 <malloc+0xb4>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 7e0:	29 f1                	sub    %esi,%ecx
 7e2:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7e5:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7e8:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
 7eb:	89 15 e0 0b 00 00    	mov    %edx,0xbe0
      return (void*)(p + 1);
 7f1:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7f7:	5b                   	pop    %ebx
 7f8:	5e                   	pop    %esi
 7f9:	5f                   	pop    %edi
 7fa:	5d                   	pop    %ebp
 7fb:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 7fc:	89 d8                	mov    %ebx,%eax
 7fe:	89 f7                	mov    %esi,%edi
 800:	eb a7                	jmp    7a9 <malloc+0x59>
 802:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 804:	8b 08                	mov    (%eax),%ecx
 806:	89 0a                	mov    %ecx,(%edx)
 808:	eb e1                	jmp    7eb <malloc+0x9b>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 80a:	c7 05 e0 0b 00 00 e4 	movl   $0xbe4,0xbe0
 811:	0b 00 00 
 814:	c7 05 e4 0b 00 00 e4 	movl   $0xbe4,0xbe4
 81b:	0b 00 00 
    base.s.size = 0;
 81e:	c7 05 e8 0b 00 00 00 	movl   $0x0,0xbe8
 825:	00 00 00 
 828:	b8 e4 0b 00 00       	mov    $0xbe4,%eax
 82d:	e9 48 ff ff ff       	jmp    77a <malloc+0x2a>
