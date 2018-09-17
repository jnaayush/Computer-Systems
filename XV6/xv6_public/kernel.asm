
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4 0f                	in     $0xf,%al

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 80 10 00       	mov    $0x108000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc c0 a5 10 80       	mov    $0x8010a5c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 34 2a 10 80       	mov    $0x80102a34,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	53                   	push   %ebx
80100038:	83 ec 0c             	sub    $0xc,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003b:	68 60 64 10 80       	push   $0x80106460
80100040:	68 c0 a5 10 80       	push   $0x8010a5c0
80100045:	e8 6a 3b 00 00       	call   80103bb4 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004a:	c7 05 0c ed 10 80 bc 	movl   $0x8010ecbc,0x8010ed0c
80100051:	ec 10 80 
  bcache.head.next = &bcache.head;
80100054:	c7 05 10 ed 10 80 bc 	movl   $0x8010ecbc,0x8010ed10
8010005b:	ec 10 80 
8010005e:	83 c4 10             	add    $0x10,%esp
80100061:	ba bc ec 10 80       	mov    $0x8010ecbc,%edx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100066:	bb f4 a5 10 80       	mov    $0x8010a5f4,%ebx
8010006b:	eb 05                	jmp    80100072 <binit+0x3e>
8010006d:	8d 76 00             	lea    0x0(%esi),%esi
80100070:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
80100072:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
80100075:	c7 43 50 bc ec 10 80 	movl   $0x8010ecbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
8010007c:	83 ec 08             	sub    $0x8,%esp
8010007f:	68 67 64 10 80       	push   $0x80106467
80100084:	8d 43 0c             	lea    0xc(%ebx),%eax
80100087:	50                   	push   %eax
80100088:	e8 3b 3a 00 00       	call   80103ac8 <initsleeplock>
    bcache.head.next->prev = b;
8010008d:	a1 10 ed 10 80       	mov    0x8010ed10,%eax
80100092:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100095:	89 1d 10 ed 10 80    	mov    %ebx,0x8010ed10

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009b:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
801000a1:	89 da                	mov    %ebx,%edx
801000a3:	83 c4 10             	add    $0x10,%esp
801000a6:	3d bc ec 10 80       	cmp    $0x8010ecbc,%eax
801000ab:	75 c3                	jne    80100070 <binit+0x3c>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000ad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000b0:	c9                   	leave  
801000b1:	c3                   	ret    
801000b2:	66 90                	xchg   %ax,%ax

801000b4 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000b4:	55                   	push   %ebp
801000b5:	89 e5                	mov    %esp,%ebp
801000b7:	57                   	push   %edi
801000b8:	56                   	push   %esi
801000b9:	53                   	push   %ebx
801000ba:	83 ec 28             	sub    $0x28,%esp
801000bd:	8b 75 08             	mov    0x8(%ebp),%esi
801000c0:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000c3:	68 c0 a5 10 80       	push   $0x8010a5c0
801000c8:	e8 ab 3b 00 00       	call   80103c78 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000cd:	8b 1d 10 ed 10 80    	mov    0x8010ed10,%ebx
801000d3:	83 c4 10             	add    $0x10,%esp
801000d6:	81 fb bc ec 10 80    	cmp    $0x8010ecbc,%ebx
801000dc:	75 0d                	jne    801000eb <bread+0x37>
801000de:	eb 1c                	jmp    801000fc <bread+0x48>
801000e0:	8b 5b 54             	mov    0x54(%ebx),%ebx
801000e3:	81 fb bc ec 10 80    	cmp    $0x8010ecbc,%ebx
801000e9:	74 11                	je     801000fc <bread+0x48>
    if(b->dev == dev && b->blockno == blockno){
801000eb:	3b 73 04             	cmp    0x4(%ebx),%esi
801000ee:	75 f0                	jne    801000e0 <bread+0x2c>
801000f0:	3b 7b 08             	cmp    0x8(%ebx),%edi
801000f3:	75 eb                	jne    801000e0 <bread+0x2c>
      b->refcnt++;
801000f5:	ff 43 4c             	incl   0x4c(%ebx)
801000f8:	eb 3c                	jmp    80100136 <bread+0x82>
801000fa:	66 90                	xchg   %ax,%ax
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
801000fc:	8b 1d 0c ed 10 80    	mov    0x8010ed0c,%ebx
80100102:	81 fb bc ec 10 80    	cmp    $0x8010ecbc,%ebx
80100108:	75 0d                	jne    80100117 <bread+0x63>
8010010a:	eb 66                	jmp    80100172 <bread+0xbe>
8010010c:	8b 5b 50             	mov    0x50(%ebx),%ebx
8010010f:	81 fb bc ec 10 80    	cmp    $0x8010ecbc,%ebx
80100115:	74 5b                	je     80100172 <bread+0xbe>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
80100117:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010011a:	85 c0                	test   %eax,%eax
8010011c:	75 ee                	jne    8010010c <bread+0x58>
8010011e:	f6 03 04             	testb  $0x4,(%ebx)
80100121:	75 e9                	jne    8010010c <bread+0x58>
      b->dev = dev;
80100123:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
80100126:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
80100129:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
8010012f:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100136:	83 ec 0c             	sub    $0xc,%esp
80100139:	68 c0 a5 10 80       	push   $0x8010a5c0
8010013e:	e8 09 3c 00 00       	call   80103d4c <release>
      acquiresleep(&b->lock);
80100143:	8d 43 0c             	lea    0xc(%ebx),%eax
80100146:	89 04 24             	mov    %eax,(%esp)
80100149:	e8 ae 39 00 00       	call   80103afc <acquiresleep>
8010014e:	83 c4 10             	add    $0x10,%esp
80100151:	89 d8                	mov    %ebx,%eax
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100153:	f6 03 02             	testb  $0x2,(%ebx)
80100156:	75 12                	jne    8010016a <bread+0xb6>
    iderw(b);
80100158:	83 ec 0c             	sub    $0xc,%esp
8010015b:	53                   	push   %ebx
8010015c:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
8010015f:	e8 24 1d 00 00       	call   80101e88 <iderw>
80100164:	83 c4 10             	add    $0x10,%esp
80100167:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }
  return b;
}
8010016a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010016d:	5b                   	pop    %ebx
8010016e:	5e                   	pop    %esi
8010016f:	5f                   	pop    %edi
80100170:	5d                   	pop    %ebp
80100171:	c3                   	ret    
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100172:	83 ec 0c             	sub    $0xc,%esp
80100175:	68 6e 64 10 80       	push   $0x8010646e
8010017a:	e8 b9 01 00 00       	call   80100338 <panic>
8010017f:	90                   	nop

80100180 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
80100180:	55                   	push   %ebp
80100181:	89 e5                	mov    %esp,%ebp
80100183:	53                   	push   %ebx
80100184:	83 ec 10             	sub    $0x10,%esp
80100187:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
8010018a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010018d:	50                   	push   %eax
8010018e:	e8 f9 39 00 00       	call   80103b8c <holdingsleep>
80100193:	83 c4 10             	add    $0x10,%esp
80100196:	85 c0                	test   %eax,%eax
80100198:	74 0f                	je     801001a9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
8010019a:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
8010019d:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001a3:	c9                   	leave  
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801001a4:	e9 df 1c 00 00       	jmp    80101e88 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001a9:	83 ec 0c             	sub    $0xc,%esp
801001ac:	68 7f 64 10 80       	push   $0x8010647f
801001b1:	e8 82 01 00 00       	call   80100338 <panic>
801001b6:	66 90                	xchg   %ax,%ax

801001b8 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001b8:	55                   	push   %ebp
801001b9:	89 e5                	mov    %esp,%ebp
801001bb:	56                   	push   %esi
801001bc:	53                   	push   %ebx
801001bd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001c0:	8d 73 0c             	lea    0xc(%ebx),%esi
801001c3:	83 ec 0c             	sub    $0xc,%esp
801001c6:	56                   	push   %esi
801001c7:	e8 c0 39 00 00       	call   80103b8c <holdingsleep>
801001cc:	83 c4 10             	add    $0x10,%esp
801001cf:	85 c0                	test   %eax,%eax
801001d1:	74 64                	je     80100237 <brelse+0x7f>
    panic("brelse");

  releasesleep(&b->lock);
801001d3:	83 ec 0c             	sub    $0xc,%esp
801001d6:	56                   	push   %esi
801001d7:	e8 74 39 00 00       	call   80103b50 <releasesleep>

  acquire(&bcache.lock);
801001dc:	c7 04 24 c0 a5 10 80 	movl   $0x8010a5c0,(%esp)
801001e3:	e8 90 3a 00 00       	call   80103c78 <acquire>
  b->refcnt--;
801001e8:	8b 43 4c             	mov    0x4c(%ebx),%eax
801001eb:	48                   	dec    %eax
801001ec:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
801001ef:	83 c4 10             	add    $0x10,%esp
801001f2:	85 c0                	test   %eax,%eax
801001f4:	75 2f                	jne    80100225 <brelse+0x6d>
    // no one is waiting for it.
    b->next->prev = b->prev;
801001f6:	8b 43 54             	mov    0x54(%ebx),%eax
801001f9:	8b 53 50             	mov    0x50(%ebx),%edx
801001fc:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
801001ff:	8b 43 50             	mov    0x50(%ebx),%eax
80100202:	8b 53 54             	mov    0x54(%ebx),%edx
80100205:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100208:	a1 10 ed 10 80       	mov    0x8010ed10,%eax
8010020d:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
80100210:	c7 43 50 bc ec 10 80 	movl   $0x8010ecbc,0x50(%ebx)
    bcache.head.next->prev = b;
80100217:	a1 10 ed 10 80       	mov    0x8010ed10,%eax
8010021c:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010021f:	89 1d 10 ed 10 80    	mov    %ebx,0x8010ed10
  }
  
  release(&bcache.lock);
80100225:	c7 45 08 c0 a5 10 80 	movl   $0x8010a5c0,0x8(%ebp)
}
8010022c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010022f:	5b                   	pop    %ebx
80100230:	5e                   	pop    %esi
80100231:	5d                   	pop    %ebp
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
  
  release(&bcache.lock);
80100232:	e9 15 3b 00 00       	jmp    80103d4c <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100237:	83 ec 0c             	sub    $0xc,%esp
8010023a:	68 86 64 10 80       	push   $0x80106486
8010023f:	e8 f4 00 00 00       	call   80100338 <panic>

80100244 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100244:	55                   	push   %ebp
80100245:	89 e5                	mov    %esp,%ebp
80100247:	57                   	push   %edi
80100248:	56                   	push   %esi
80100249:	53                   	push   %ebx
8010024a:	83 ec 28             	sub    $0x28,%esp
8010024d:	8b 7d 08             	mov    0x8(%ebp),%edi
80100250:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
80100253:	57                   	push   %edi
80100254:	e8 43 13 00 00       	call   8010159c <iunlock>
  target = n;
  acquire(&cons.lock);
80100259:	c7 04 24 20 95 10 80 	movl   $0x80109520,(%esp)
80100260:	e8 13 3a 00 00       	call   80103c78 <acquire>
  while(n > 0){
80100265:	83 c4 10             	add    $0x10,%esp
80100268:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010026b:	31 c0                	xor    %eax,%eax
8010026d:	85 db                	test   %ebx,%ebx
8010026f:	0f 8e 92 00 00 00    	jle    80100307 <consoleread+0xc3>
    while(input.r == input.w){
80100275:	a1 a0 ef 10 80       	mov    0x8010efa0,%eax
8010027a:	3b 05 a4 ef 10 80    	cmp    0x8010efa4,%eax
80100280:	74 24                	je     801002a6 <consoleread+0x62>
80100282:	eb 54                	jmp    801002d8 <consoleread+0x94>
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
80100284:	83 ec 08             	sub    $0x8,%esp
80100287:	68 20 95 10 80       	push   $0x80109520
8010028c:	68 a0 ef 10 80       	push   $0x8010efa0
80100291:	e8 26 35 00 00       	call   801037bc <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
80100296:	a1 a0 ef 10 80       	mov    0x8010efa0,%eax
8010029b:	83 c4 10             	add    $0x10,%esp
8010029e:	3b 05 a4 ef 10 80    	cmp    0x8010efa4,%eax
801002a4:	75 32                	jne    801002d8 <consoleread+0x94>
      if(myproc()->killed){
801002a6:	e8 1d 30 00 00       	call   801032c8 <myproc>
801002ab:	8b 40 24             	mov    0x24(%eax),%eax
801002ae:	85 c0                	test   %eax,%eax
801002b0:	74 d2                	je     80100284 <consoleread+0x40>
        release(&cons.lock);
801002b2:	83 ec 0c             	sub    $0xc,%esp
801002b5:	68 20 95 10 80       	push   $0x80109520
801002ba:	e8 8d 3a 00 00       	call   80103d4c <release>
        ilock(ip);
801002bf:	89 3c 24             	mov    %edi,(%esp)
801002c2:	e8 0d 12 00 00       	call   801014d4 <ilock>
        return -1;
801002c7:	83 c4 10             	add    $0x10,%esp
801002ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002cf:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002d2:	5b                   	pop    %ebx
801002d3:	5e                   	pop    %esi
801002d4:	5f                   	pop    %edi
801002d5:	5d                   	pop    %ebp
801002d6:	c3                   	ret    
801002d7:	90                   	nop
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
801002d8:	8d 50 01             	lea    0x1(%eax),%edx
801002db:	89 15 a0 ef 10 80    	mov    %edx,0x8010efa0
801002e1:	89 c2                	mov    %eax,%edx
801002e3:	83 e2 7f             	and    $0x7f,%edx
801002e6:	0f be 92 20 ef 10 80 	movsbl -0x7fef10e0(%edx),%edx
    if(c == C('D')){  // EOF
801002ed:	83 fa 04             	cmp    $0x4,%edx
801002f0:	74 35                	je     80100327 <consoleread+0xe3>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002f2:	46                   	inc    %esi
801002f3:	88 56 ff             	mov    %dl,-0x1(%esi)
    --n;
801002f6:	4b                   	dec    %ebx
    if(c == '\n')
801002f7:	83 fa 0a             	cmp    $0xa,%edx
801002fa:	74 35                	je     80100331 <consoleread+0xed>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
801002fc:	85 db                	test   %ebx,%ebx
801002fe:	0f 85 71 ff ff ff    	jne    80100275 <consoleread+0x31>
80100304:	8b 45 10             	mov    0x10(%ebp),%eax
80100307:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
8010030a:	83 ec 0c             	sub    $0xc,%esp
8010030d:	68 20 95 10 80       	push   $0x80109520
80100312:	e8 35 3a 00 00       	call   80103d4c <release>
  ilock(ip);
80100317:	89 3c 24             	mov    %edi,(%esp)
8010031a:	e8 b5 11 00 00       	call   801014d4 <ilock>

  return target - n;
8010031f:	83 c4 10             	add    $0x10,%esp
80100322:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100325:	eb a8                	jmp    801002cf <consoleread+0x8b>
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
80100327:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010032a:	76 05                	jbe    80100331 <consoleread+0xed>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
8010032c:	a3 a0 ef 10 80       	mov    %eax,0x8010efa0
80100331:	8b 45 10             	mov    0x10(%ebp),%eax
80100334:	29 d8                	sub    %ebx,%eax
80100336:	eb cf                	jmp    80100307 <consoleread+0xc3>

80100338 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
80100338:	55                   	push   %ebp
80100339:	89 e5                	mov    %esp,%ebp
8010033b:	56                   	push   %esi
8010033c:	53                   	push   %ebx
8010033d:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100340:	fa                   	cli    
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
80100341:	c7 05 54 95 10 80 00 	movl   $0x0,0x80109554
80100348:	00 00 00 
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
8010034b:	e8 fc 20 00 00       	call   8010244c <lapicid>
80100350:	83 ec 08             	sub    $0x8,%esp
80100353:	50                   	push   %eax
80100354:	68 8d 64 10 80       	push   $0x8010648d
80100359:	e8 aa 02 00 00       	call   80100608 <cprintf>
  cprintf(s);
8010035e:	58                   	pop    %eax
8010035f:	ff 75 08             	pushl  0x8(%ebp)
80100362:	e8 a1 02 00 00       	call   80100608 <cprintf>
  cprintf("\n");
80100367:	c7 04 24 fb 6d 10 80 	movl   $0x80106dfb,(%esp)
8010036e:	e8 95 02 00 00       	call   80100608 <cprintf>
  getcallerpcs(&s, pcs);
80100373:	5a                   	pop    %edx
80100374:	59                   	pop    %ecx
80100375:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100378:	53                   	push   %ebx
80100379:	8d 45 08             	lea    0x8(%ebp),%eax
8010037c:	50                   	push   %eax
8010037d:	e8 4e 38 00 00       	call   80103bd0 <getcallerpcs>
80100382:	8d 75 f8             	lea    -0x8(%ebp),%esi
80100385:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
80100388:	83 ec 08             	sub    $0x8,%esp
8010038b:	ff 33                	pushl  (%ebx)
8010038d:	68 a1 64 10 80       	push   $0x801064a1
80100392:	e8 71 02 00 00       	call   80100608 <cprintf>
80100397:	83 c3 04             	add    $0x4,%ebx
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
8010039a:	83 c4 10             	add    $0x10,%esp
8010039d:	39 f3                	cmp    %esi,%ebx
8010039f:	75 e7                	jne    80100388 <panic+0x50>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801003a1:	c7 05 58 95 10 80 01 	movl   $0x1,0x80109558
801003a8:	00 00 00 
  for(;;)
    ;
801003ab:	eb fe                	jmp    801003ab <panic+0x73>
801003ad:	8d 76 00             	lea    0x0(%esi),%esi

801003b0 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
801003b0:	8b 15 58 95 10 80    	mov    0x80109558,%edx
801003b6:	85 d2                	test   %edx,%edx
801003b8:	74 06                	je     801003c0 <consputc+0x10>
801003ba:	fa                   	cli    
    cli();
    for(;;)
      ;
801003bb:	eb fe                	jmp    801003bb <consputc+0xb>
801003bd:	8d 76 00             	lea    0x0(%esi),%esi
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
801003c0:	55                   	push   %ebp
801003c1:	89 e5                	mov    %esp,%ebp
801003c3:	57                   	push   %edi
801003c4:	56                   	push   %esi
801003c5:	53                   	push   %ebx
801003c6:	83 ec 1c             	sub    $0x1c,%esp
801003c9:	89 c3                	mov    %eax,%ebx
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
801003cb:	3d 00 01 00 00       	cmp    $0x100,%eax
801003d0:	0f 84 a0 00 00 00    	je     80100476 <consputc+0xc6>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
801003d6:	83 ec 0c             	sub    $0xc,%esp
801003d9:	50                   	push   %eax
801003da:	e8 6d 4d 00 00       	call   8010514c <uartputc>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003df:	bf d4 03 00 00       	mov    $0x3d4,%edi
801003e4:	b0 0e                	mov    $0xe,%al
801003e6:	89 fa                	mov    %edi,%edx
801003e8:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801003e9:	be d5 03 00 00       	mov    $0x3d5,%esi
801003ee:	89 f2                	mov    %esi,%edx
801003f0:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
801003f1:	0f b6 c8             	movzbl %al,%ecx
801003f4:	c1 e1 08             	shl    $0x8,%ecx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003f7:	b0 0f                	mov    $0xf,%al
801003f9:	89 fa                	mov    %edi,%edx
801003fb:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801003fc:	89 f2                	mov    %esi,%edx
801003fe:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
801003ff:	0f b6 c0             	movzbl %al,%eax
80100402:	09 c1                	or     %eax,%ecx

  if(c == '\n')
80100404:	83 c4 10             	add    $0x10,%esp
80100407:	83 fb 0a             	cmp    $0xa,%ebx
8010040a:	0f 84 22 01 00 00    	je     80100532 <consputc+0x182>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100410:	8d 71 01             	lea    0x1(%ecx),%esi
80100413:	0f b6 c3             	movzbl %bl,%eax
80100416:	80 cc 07             	or     $0x7,%ah
80100419:	66 89 84 09 00 80 0b 	mov    %ax,-0x7ff48000(%ecx,%ecx,1)
80100420:	80 

  if(pos < 0 || pos > 25*80)
80100421:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
80100427:	0f 8f a6 00 00 00    	jg     801004d3 <consputc+0x123>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
8010042d:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100433:	0f 8f a7 00 00 00    	jg     801004e0 <consputc+0x130>
80100439:	89 f0                	mov    %esi,%eax
8010043b:	c1 e8 08             	shr    $0x8,%eax
8010043e:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100441:	89 f1                	mov    %esi,%ecx
80100443:	8d 9c 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%ebx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010044a:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010044f:	b0 0e                	mov    $0xe,%al
80100451:	89 fa                	mov    %edi,%edx
80100453:	ee                   	out    %al,(%dx)
80100454:	be d5 03 00 00       	mov    $0x3d5,%esi
80100459:	8a 45 d8             	mov    -0x28(%ebp),%al
8010045c:	89 f2                	mov    %esi,%edx
8010045e:	ee                   	out    %al,(%dx)
8010045f:	b0 0f                	mov    $0xf,%al
80100461:	89 fa                	mov    %edi,%edx
80100463:	ee                   	out    %al,(%dx)
80100464:	88 c8                	mov    %cl,%al
80100466:	89 f2                	mov    %esi,%edx
80100468:	ee                   	out    %al,(%dx)

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
80100469:	66 c7 03 20 07       	movw   $0x720,(%ebx)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
8010046e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100471:	5b                   	pop    %ebx
80100472:	5e                   	pop    %esi
80100473:	5f                   	pop    %edi
80100474:	5d                   	pop    %ebp
80100475:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100476:	83 ec 0c             	sub    $0xc,%esp
80100479:	6a 08                	push   $0x8
8010047b:	e8 cc 4c 00 00       	call   8010514c <uartputc>
80100480:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100487:	e8 c0 4c 00 00       	call   8010514c <uartputc>
8010048c:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100493:	e8 b4 4c 00 00       	call   8010514c <uartputc>
80100498:	bb d4 03 00 00       	mov    $0x3d4,%ebx
8010049d:	b0 0e                	mov    $0xe,%al
8010049f:	89 da                	mov    %ebx,%edx
801004a1:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801004a2:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801004a7:	89 ca                	mov    %ecx,%edx
801004a9:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
801004aa:	0f b6 c0             	movzbl %al,%eax
801004ad:	c1 e0 08             	shl    $0x8,%eax
801004b0:	89 c6                	mov    %eax,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004b2:	b0 0f                	mov    $0xf,%al
801004b4:	89 da                	mov    %ebx,%edx
801004b6:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801004b7:	89 ca                	mov    %ecx,%edx
801004b9:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
801004ba:	0f b6 c0             	movzbl %al,%eax

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
801004bd:	83 c4 10             	add    $0x10,%esp
801004c0:	09 f0                	or     %esi,%eax
801004c2:	74 5e                	je     80100522 <consputc+0x172>
801004c4:	8d 70 ff             	lea    -0x1(%eax),%esi
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
801004c7:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
801004cd:	0f 8e 5a ff ff ff    	jle    8010042d <consputc+0x7d>
    panic("pos under/overflow");
801004d3:	83 ec 0c             	sub    $0xc,%esp
801004d6:	68 a5 64 10 80       	push   $0x801064a5
801004db:	e8 58 fe ff ff       	call   80100338 <panic>

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004e0:	50                   	push   %eax
801004e1:	68 60 0e 00 00       	push   $0xe60
801004e6:	68 a0 80 0b 80       	push   $0x800b80a0
801004eb:	68 00 80 0b 80       	push   $0x800b8000
801004f0:	e8 37 39 00 00       	call   80103e2c <memmove>
    pos -= 80;
801004f5:	8d 7e b0             	lea    -0x50(%esi),%edi
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004f8:	8d 9c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ebx
801004ff:	83 c4 0c             	add    $0xc,%esp
80100502:	b8 d0 07 00 00       	mov    $0x7d0,%eax
80100507:	29 f0                	sub    %esi,%eax
80100509:	01 c0                	add    %eax,%eax
8010050b:	50                   	push   %eax
8010050c:	6a 00                	push   $0x0
8010050e:	53                   	push   %ebx
8010050f:	e8 84 38 00 00       	call   80103d98 <memset>
80100514:	89 f9                	mov    %edi,%ecx
80100516:	83 c4 10             	add    $0x10,%esp
80100519:	c6 45 d8 07          	movb   $0x7,-0x28(%ebp)
8010051d:	e9 28 ff ff ff       	jmp    8010044a <consputc+0x9a>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
80100522:	bb 00 80 0b 80       	mov    $0x800b8000,%ebx
80100527:	31 c9                	xor    %ecx,%ecx
80100529:	c6 45 d8 00          	movb   $0x0,-0x28(%ebp)
8010052d:	e9 18 ff ff ff       	jmp    8010044a <consputc+0x9a>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
80100532:	b3 50                	mov    $0x50,%bl
80100534:	89 c8                	mov    %ecx,%eax
80100536:	99                   	cltd   
80100537:	f7 fb                	idiv   %ebx
80100539:	29 d3                	sub    %edx,%ebx
8010053b:	8d 34 0b             	lea    (%ebx,%ecx,1),%esi
8010053e:	e9 de fe ff ff       	jmp    80100421 <consputc+0x71>
80100543:	90                   	nop

80100544 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100544:	55                   	push   %ebp
80100545:	89 e5                	mov    %esp,%ebp
80100547:	57                   	push   %edi
80100548:	56                   	push   %esi
80100549:	53                   	push   %ebx
8010054a:	83 ec 1c             	sub    $0x1c,%esp
8010054d:	89 d6                	mov    %edx,%esi
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010054f:	85 c9                	test   %ecx,%ecx
80100551:	74 04                	je     80100557 <printint+0x13>
80100553:	85 c0                	test   %eax,%eax
80100555:	78 45                	js     8010059c <printint+0x58>
    x = -xx;
  else
    x = xx;
80100557:	31 ff                	xor    %edi,%edi

  i = 0;
80100559:	31 c9                	xor    %ecx,%ecx
8010055b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
8010055e:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
80100560:	41                   	inc    %ecx
80100561:	31 d2                	xor    %edx,%edx
80100563:	f7 f6                	div    %esi
80100565:	8a 92 d0 64 10 80    	mov    -0x7fef9b30(%edx),%dl
8010056b:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
8010056e:	85 c0                	test   %eax,%eax
80100570:	75 ee                	jne    80100560 <printint+0x1c>
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
80100572:	89 c8                	mov    %ecx,%eax
  }while((x /= base) != 0);

  if(sign)
80100574:	85 ff                	test   %edi,%edi
80100576:	74 06                	je     8010057e <printint+0x3a>
    buf[i++] = '-';
80100578:	40                   	inc    %eax
80100579:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
8010057e:	8d 74 05 d7          	lea    -0x29(%ebp,%eax,1),%esi
80100582:	66 90                	xchg   %ax,%ax

  while(--i >= 0)
    consputc(buf[i]);
80100584:	0f be 06             	movsbl (%esi),%eax
80100587:	e8 24 fe ff ff       	call   801003b0 <consputc>
8010058c:	4e                   	dec    %esi
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
8010058d:	39 de                	cmp    %ebx,%esi
8010058f:	75 f3                	jne    80100584 <printint+0x40>
    consputc(buf[i]);
}
80100591:	83 c4 1c             	add    $0x1c,%esp
80100594:	5b                   	pop    %ebx
80100595:	5e                   	pop    %esi
80100596:	5f                   	pop    %edi
80100597:	5d                   	pop    %ebp
80100598:	c3                   	ret    
80100599:	8d 76 00             	lea    0x0(%esi),%esi
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
8010059c:	f7 d8                	neg    %eax
8010059e:	bf 01 00 00 00       	mov    $0x1,%edi
801005a3:	eb b4                	jmp    80100559 <printint+0x15>
801005a5:	8d 76 00             	lea    0x0(%esi),%esi

801005a8 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005a8:	55                   	push   %ebp
801005a9:	89 e5                	mov    %esp,%ebp
801005ab:	57                   	push   %edi
801005ac:	56                   	push   %esi
801005ad:	53                   	push   %ebx
801005ae:	83 ec 18             	sub    $0x18,%esp
801005b1:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
801005b4:	ff 75 08             	pushl  0x8(%ebp)
801005b7:	e8 e0 0f 00 00       	call   8010159c <iunlock>
  acquire(&cons.lock);
801005bc:	c7 04 24 20 95 10 80 	movl   $0x80109520,(%esp)
801005c3:	e8 b0 36 00 00       	call   80103c78 <acquire>
  for(i = 0; i < n; i++)
801005c8:	83 c4 10             	add    $0x10,%esp
801005cb:	85 f6                	test   %esi,%esi
801005cd:	7e 16                	jle    801005e5 <consolewrite+0x3d>
801005cf:	8b 7d 0c             	mov    0xc(%ebp),%edi
801005d2:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
801005d5:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
801005d8:	0f b6 07             	movzbl (%edi),%eax
801005db:	e8 d0 fd ff ff       	call   801003b0 <consputc>
801005e0:	47                   	inc    %edi
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
801005e1:	39 df                	cmp    %ebx,%edi
801005e3:	75 f3                	jne    801005d8 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
801005e5:	83 ec 0c             	sub    $0xc,%esp
801005e8:	68 20 95 10 80       	push   $0x80109520
801005ed:	e8 5a 37 00 00       	call   80103d4c <release>
  ilock(ip);
801005f2:	58                   	pop    %eax
801005f3:	ff 75 08             	pushl  0x8(%ebp)
801005f6:	e8 d9 0e 00 00       	call   801014d4 <ilock>

  return n;
}
801005fb:	89 f0                	mov    %esi,%eax
801005fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100600:	5b                   	pop    %ebx
80100601:	5e                   	pop    %esi
80100602:	5f                   	pop    %edi
80100603:	5d                   	pop    %ebp
80100604:	c3                   	ret    
80100605:	8d 76 00             	lea    0x0(%esi),%esi

80100608 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100608:	55                   	push   %ebp
80100609:	89 e5                	mov    %esp,%ebp
8010060b:	57                   	push   %edi
8010060c:	56                   	push   %esi
8010060d:	53                   	push   %ebx
8010060e:	83 ec 1c             	sub    $0x1c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100611:	a1 54 95 10 80       	mov    0x80109554,%eax
80100616:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100619:	85 c0                	test   %eax,%eax
8010061b:	0f 85 07 01 00 00    	jne    80100728 <cprintf+0x120>
    acquire(&cons.lock);

  if (fmt == 0)
80100621:	8b 75 08             	mov    0x8(%ebp),%esi
80100624:	85 f6                	test   %esi,%esi
80100626:	0f 84 1b 01 00 00    	je     80100747 <cprintf+0x13f>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010062c:	0f b6 06             	movzbl (%esi),%eax
8010062f:	85 c0                	test   %eax,%eax
80100631:	74 5d                	je     80100690 <cprintf+0x88>
80100633:	8d 7d 0c             	lea    0xc(%ebp),%edi
80100636:	31 db                	xor    %ebx,%ebx
80100638:	eb 43                	jmp    8010067d <cprintf+0x75>
8010063a:	66 90                	xchg   %ax,%ax
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
8010063c:	43                   	inc    %ebx
8010063d:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
80100641:	85 d2                	test   %edx,%edx
80100643:	74 4b                	je     80100690 <cprintf+0x88>
      break;
    switch(c){
80100645:	83 fa 70             	cmp    $0x70,%edx
80100648:	74 70                	je     801006ba <cprintf+0xb2>
8010064a:	7f 64                	jg     801006b0 <cprintf+0xa8>
8010064c:	83 fa 25             	cmp    $0x25,%edx
8010064f:	0f 84 9b 00 00 00    	je     801006f0 <cprintf+0xe8>
80100655:	83 fa 64             	cmp    $0x64,%edx
80100658:	75 7a                	jne    801006d4 <cprintf+0xcc>
    case 'd':
      printint(*argp++, 10, 1);
8010065a:	8d 47 04             	lea    0x4(%edi),%eax
8010065d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100660:	b9 01 00 00 00       	mov    $0x1,%ecx
80100665:	ba 0a 00 00 00       	mov    $0xa,%edx
8010066a:	8b 07                	mov    (%edi),%eax
8010066c:	e8 d3 fe ff ff       	call   80100544 <printint>
80100671:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100674:	43                   	inc    %ebx
80100675:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100679:	85 c0                	test   %eax,%eax
8010067b:	74 13                	je     80100690 <cprintf+0x88>
    if(c != '%'){
8010067d:	83 f8 25             	cmp    $0x25,%eax
80100680:	74 ba                	je     8010063c <cprintf+0x34>
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100682:	e8 29 fd ff ff       	call   801003b0 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100687:	43                   	inc    %ebx
80100688:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
8010068c:	85 c0                	test   %eax,%eax
8010068e:	75 ed                	jne    8010067d <cprintf+0x75>
      consputc(c);
      break;
    }
  }

  if(locking)
80100690:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100693:	85 c0                	test   %eax,%eax
80100695:	74 10                	je     801006a7 <cprintf+0x9f>
    release(&cons.lock);
80100697:	83 ec 0c             	sub    $0xc,%esp
8010069a:	68 20 95 10 80       	push   $0x80109520
8010069f:	e8 a8 36 00 00       	call   80103d4c <release>
801006a4:	83 c4 10             	add    $0x10,%esp
}
801006a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801006aa:	5b                   	pop    %ebx
801006ab:	5e                   	pop    %esi
801006ac:	5f                   	pop    %edi
801006ad:	5d                   	pop    %ebp
801006ae:	c3                   	ret    
801006af:	90                   	nop
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
801006b0:	83 fa 73             	cmp    $0x73,%edx
801006b3:	74 47                	je     801006fc <cprintf+0xf4>
801006b5:	83 fa 78             	cmp    $0x78,%edx
801006b8:	75 1a                	jne    801006d4 <cprintf+0xcc>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
801006ba:	8d 47 04             	lea    0x4(%edi),%eax
801006bd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006c0:	31 c9                	xor    %ecx,%ecx
801006c2:	ba 10 00 00 00       	mov    $0x10,%edx
801006c7:	8b 07                	mov    (%edi),%eax
801006c9:	e8 76 fe ff ff       	call   80100544 <printint>
801006ce:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      break;
801006d1:	eb a1                	jmp    80100674 <cprintf+0x6c>
801006d3:	90                   	nop
801006d4:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
801006d7:	b8 25 00 00 00       	mov    $0x25,%eax
801006dc:	e8 cf fc ff ff       	call   801003b0 <consputc>
      consputc(c);
801006e1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801006e4:	89 d0                	mov    %edx,%eax
801006e6:	e8 c5 fc ff ff       	call   801003b0 <consputc>
      break;
801006eb:	eb 87                	jmp    80100674 <cprintf+0x6c>
801006ed:	8d 76 00             	lea    0x0(%esi),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
801006f0:	b8 25 00 00 00       	mov    $0x25,%eax
801006f5:	e8 b6 fc ff ff       	call   801003b0 <consputc>
801006fa:	eb 8b                	jmp    80100687 <cprintf+0x7f>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
801006fc:	8d 47 04             	lea    0x4(%edi),%eax
801006ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100702:	8b 3f                	mov    (%edi),%edi
80100704:	85 ff                	test   %edi,%edi
80100706:	74 38                	je     80100740 <cprintf+0x138>
        s = "(null)";
      for(; *s; s++)
80100708:	0f be 07             	movsbl (%edi),%eax
8010070b:	84 c0                	test   %al,%al
8010070d:	74 0e                	je     8010071d <cprintf+0x115>
8010070f:	90                   	nop
        consputc(*s);
80100710:	e8 9b fc ff ff       	call   801003b0 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
80100715:	47                   	inc    %edi
80100716:	0f be 07             	movsbl (%edi),%eax
80100719:	84 c0                	test   %al,%al
8010071b:	75 f3                	jne    80100710 <cprintf+0x108>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
8010071d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80100720:	e9 4f ff ff ff       	jmp    80100674 <cprintf+0x6c>
80100725:	8d 76 00             	lea    0x0(%esi),%esi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
80100728:	83 ec 0c             	sub    $0xc,%esp
8010072b:	68 20 95 10 80       	push   $0x80109520
80100730:	e8 43 35 00 00       	call   80103c78 <acquire>
80100735:	83 c4 10             	add    $0x10,%esp
80100738:	e9 e4 fe ff ff       	jmp    80100621 <cprintf+0x19>
8010073d:	8d 76 00             	lea    0x0(%esi),%esi
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
80100740:	bf b8 64 10 80       	mov    $0x801064b8,%edi
80100745:	eb c1                	jmp    80100708 <cprintf+0x100>
  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);

  if (fmt == 0)
    panic("null fmt");
80100747:	83 ec 0c             	sub    $0xc,%esp
8010074a:	68 bf 64 10 80       	push   $0x801064bf
8010074f:	e8 e4 fb ff ff       	call   80100338 <panic>

80100754 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
80100754:	55                   	push   %ebp
80100755:	89 e5                	mov    %esp,%ebp
80100757:	57                   	push   %edi
80100758:	56                   	push   %esi
80100759:	53                   	push   %ebx
8010075a:	83 ec 18             	sub    $0x18,%esp
8010075d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;

  acquire(&cons.lock);
80100760:	68 20 95 10 80       	push   $0x80109520
80100765:	e8 0e 35 00 00       	call   80103c78 <acquire>
  while((c = getc()) >= 0){
8010076a:	83 c4 10             	add    $0x10,%esp
#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;
8010076d:	31 f6                	xor    %esi,%esi
8010076f:	90                   	nop

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100770:	ff d3                	call   *%ebx
80100772:	89 c7                	mov    %eax,%edi
80100774:	85 c0                	test   %eax,%eax
80100776:	78 40                	js     801007b8 <consoleintr+0x64>
    switch(c){
80100778:	83 ff 10             	cmp    $0x10,%edi
8010077b:	0f 84 23 01 00 00    	je     801008a4 <consoleintr+0x150>
80100781:	7e 55                	jle    801007d8 <consoleintr+0x84>
80100783:	83 ff 15             	cmp    $0x15,%edi
80100786:	0f 84 d0 00 00 00    	je     8010085c <consoleintr+0x108>
8010078c:	83 ff 7f             	cmp    $0x7f,%edi
8010078f:	75 4c                	jne    801007dd <consoleintr+0x89>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100791:	a1 a8 ef 10 80       	mov    0x8010efa8,%eax
80100796:	3b 05 a4 ef 10 80    	cmp    0x8010efa4,%eax
8010079c:	74 d2                	je     80100770 <consoleintr+0x1c>
        input.e--;
8010079e:	48                   	dec    %eax
8010079f:	a3 a8 ef 10 80       	mov    %eax,0x8010efa8
        consputc(BACKSPACE);
801007a4:	b8 00 01 00 00       	mov    $0x100,%eax
801007a9:	e8 02 fc ff ff       	call   801003b0 <consputc>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
801007ae:	ff d3                	call   *%ebx
801007b0:	89 c7                	mov    %eax,%edi
801007b2:	85 c0                	test   %eax,%eax
801007b4:	79 c2                	jns    80100778 <consoleintr+0x24>
801007b6:	66 90                	xchg   %ax,%ax
        }
      }
      break;
    }
  }
  release(&cons.lock);
801007b8:	83 ec 0c             	sub    $0xc,%esp
801007bb:	68 20 95 10 80       	push   $0x80109520
801007c0:	e8 87 35 00 00       	call   80103d4c <release>
  if(doprocdump) {
801007c5:	83 c4 10             	add    $0x10,%esp
801007c8:	85 f6                	test   %esi,%esi
801007ca:	0f 85 e0 00 00 00    	jne    801008b0 <consoleintr+0x15c>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
801007d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801007d3:	5b                   	pop    %ebx
801007d4:	5e                   	pop    %esi
801007d5:	5f                   	pop    %edi
801007d6:	5d                   	pop    %ebp
801007d7:	c3                   	ret    
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
801007d8:	83 ff 08             	cmp    $0x8,%edi
801007db:	74 b4                	je     80100791 <consoleintr+0x3d>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
801007dd:	85 ff                	test   %edi,%edi
801007df:	74 8f                	je     80100770 <consoleintr+0x1c>
801007e1:	a1 a8 ef 10 80       	mov    0x8010efa8,%eax
801007e6:	89 c2                	mov    %eax,%edx
801007e8:	2b 15 a0 ef 10 80    	sub    0x8010efa0,%edx
801007ee:	83 fa 7f             	cmp    $0x7f,%edx
801007f1:	0f 87 79 ff ff ff    	ja     80100770 <consoleintr+0x1c>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
801007f7:	8d 50 01             	lea    0x1(%eax),%edx
801007fa:	89 15 a8 ef 10 80    	mov    %edx,0x8010efa8
80100800:	83 e0 7f             	and    $0x7f,%eax
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
80100803:	83 ff 0d             	cmp    $0xd,%edi
80100806:	0f 84 b0 00 00 00    	je     801008bc <consoleintr+0x168>
        input.buf[input.e++ % INPUT_BUF] = c;
8010080c:	89 f9                	mov    %edi,%ecx
8010080e:	88 88 20 ef 10 80    	mov    %cl,-0x7fef10e0(%eax)
        consputc(c);
80100814:	89 f8                	mov    %edi,%eax
80100816:	e8 95 fb ff ff       	call   801003b0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
8010081b:	83 ff 0a             	cmp    $0xa,%edi
8010081e:	0f 84 a9 00 00 00    	je     801008cd <consoleintr+0x179>
80100824:	83 ff 04             	cmp    $0x4,%edi
80100827:	0f 84 a0 00 00 00    	je     801008cd <consoleintr+0x179>
8010082d:	a1 a0 ef 10 80       	mov    0x8010efa0,%eax
80100832:	83 e8 80             	sub    $0xffffff80,%eax
80100835:	39 05 a8 ef 10 80    	cmp    %eax,0x8010efa8
8010083b:	0f 85 2f ff ff ff    	jne    80100770 <consoleintr+0x1c>
          input.w = input.e;
80100841:	a3 a4 ef 10 80       	mov    %eax,0x8010efa4
          wakeup(&input.r);
80100846:	83 ec 0c             	sub    $0xc,%esp
80100849:	68 a0 ef 10 80       	push   $0x8010efa0
8010084e:	e8 f5 30 00 00       	call   80103948 <wakeup>
80100853:	83 c4 10             	add    $0x10,%esp
80100856:	e9 15 ff ff ff       	jmp    80100770 <consoleintr+0x1c>
8010085b:	90                   	nop
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010085c:	a1 a8 ef 10 80       	mov    0x8010efa8,%eax
80100861:	3b 05 a4 ef 10 80    	cmp    0x8010efa4,%eax
80100867:	75 27                	jne    80100890 <consoleintr+0x13c>
80100869:	e9 02 ff ff ff       	jmp    80100770 <consoleintr+0x1c>
8010086e:	66 90                	xchg   %ax,%ax
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100870:	a3 a8 ef 10 80       	mov    %eax,0x8010efa8
        consputc(BACKSPACE);
80100875:	b8 00 01 00 00       	mov    $0x100,%eax
8010087a:	e8 31 fb ff ff       	call   801003b0 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010087f:	a1 a8 ef 10 80       	mov    0x8010efa8,%eax
80100884:	3b 05 a4 ef 10 80    	cmp    0x8010efa4,%eax
8010088a:	0f 84 e0 fe ff ff    	je     80100770 <consoleintr+0x1c>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100890:	48                   	dec    %eax
80100891:	89 c2                	mov    %eax,%edx
80100893:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100896:	80 ba 20 ef 10 80 0a 	cmpb   $0xa,-0x7fef10e0(%edx)
8010089d:	75 d1                	jne    80100870 <consoleintr+0x11c>
8010089f:	e9 cc fe ff ff       	jmp    80100770 <consoleintr+0x1c>
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
801008a4:	be 01 00 00 00       	mov    $0x1,%esi
801008a9:	e9 c2 fe ff ff       	jmp    80100770 <consoleintr+0x1c>
801008ae:	66 90                	xchg   %ax,%ax
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
801008b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801008b3:	5b                   	pop    %ebx
801008b4:	5e                   	pop    %esi
801008b5:	5f                   	pop    %edi
801008b6:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
801008b7:	e9 60 31 00 00       	jmp    80103a1c <procdump>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
801008bc:	c6 80 20 ef 10 80 0a 	movb   $0xa,-0x7fef10e0(%eax)
        consputc(c);
801008c3:	b8 0a 00 00 00       	mov    $0xa,%eax
801008c8:	e8 e3 fa ff ff       	call   801003b0 <consputc>
801008cd:	a1 a8 ef 10 80       	mov    0x8010efa8,%eax
801008d2:	e9 6a ff ff ff       	jmp    80100841 <consoleintr+0xed>
801008d7:	90                   	nop

801008d8 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
801008d8:	55                   	push   %ebp
801008d9:	89 e5                	mov    %esp,%ebp
801008db:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801008de:	68 c8 64 10 80       	push   $0x801064c8
801008e3:	68 20 95 10 80       	push   $0x80109520
801008e8:	e8 c7 32 00 00       	call   80103bb4 <initlock>

  devsw[CONSOLE].write = consolewrite;
801008ed:	c7 05 6c f9 10 80 a8 	movl   $0x801005a8,0x8010f96c
801008f4:	05 10 80 
  devsw[CONSOLE].read = consoleread;
801008f7:	c7 05 68 f9 10 80 44 	movl   $0x80100244,0x8010f968
801008fe:	02 10 80 
  cons.locking = 1;
80100901:	c7 05 54 95 10 80 01 	movl   $0x1,0x80109554
80100908:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
8010090b:	58                   	pop    %eax
8010090c:	5a                   	pop    %edx
8010090d:	6a 00                	push   $0x0
8010090f:	6a 01                	push   $0x1
80100911:	e8 fa 16 00 00       	call   80102010 <ioapicenable>
80100916:	83 c4 10             	add    $0x10,%esp
}
80100919:	c9                   	leave  
8010091a:	c3                   	ret    
8010091b:	90                   	nop

8010091c <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
8010091c:	55                   	push   %ebp
8010091d:	89 e5                	mov    %esp,%ebp
8010091f:	57                   	push   %edi
80100920:	56                   	push   %esi
80100921:	53                   	push   %ebx
80100922:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100928:	e8 9b 29 00 00       	call   801032c8 <myproc>
8010092d:	89 c7                	mov    %eax,%edi

  begin_op();
8010092f:	e8 34 1e 00 00       	call   80102768 <begin_op>

  if((ip = namei(path)) == 0){
80100934:	83 ec 0c             	sub    $0xc,%esp
80100937:	ff 75 08             	pushl  0x8(%ebp)
8010093a:	e8 75 13 00 00       	call   80101cb4 <namei>
8010093f:	89 c3                	mov    %eax,%ebx
80100941:	83 c4 10             	add    $0x10,%esp
80100944:	85 c0                	test   %eax,%eax
80100946:	0f 84 a0 01 00 00    	je     80100aec <exec+0x1d0>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
8010094c:	83 ec 0c             	sub    $0xc,%esp
8010094f:	50                   	push   %eax
80100950:	e8 7f 0b 00 00       	call   801014d4 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100955:	6a 34                	push   $0x34
80100957:	6a 00                	push   $0x0
80100959:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
8010095f:	50                   	push   %eax
80100960:	53                   	push   %ebx
80100961:	e8 0e 0e 00 00       	call   80101774 <readi>
80100966:	83 c4 20             	add    $0x20,%esp
80100969:	83 f8 34             	cmp    $0x34,%eax
8010096c:	74 1e                	je     8010098c <exec+0x70>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
8010096e:	83 ec 0c             	sub    $0xc,%esp
80100971:	53                   	push   %ebx
80100972:	e8 b1 0d 00 00       	call   80101728 <iunlockput>
    end_op();
80100977:	e8 54 1e 00 00       	call   801027d0 <end_op>
8010097c:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
8010097f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100984:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100987:	5b                   	pop    %ebx
80100988:	5e                   	pop    %esi
80100989:	5f                   	pop    %edi
8010098a:	5d                   	pop    %ebp
8010098b:	c3                   	ret    
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
8010098c:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100993:	45 4c 46 
80100996:	75 d6                	jne    8010096e <exec+0x52>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100998:	e8 73 58 00 00       	call   80106210 <setupkvm>
8010099d:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
801009a3:	85 c0                	test   %eax,%eax
801009a5:	74 c7                	je     8010096e <exec+0x52>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801009a7:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
801009ad:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
801009b4:	00 
801009b5:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
801009bc:	00 00 00 
801009bf:	0f 84 cb 00 00 00    	je     80100a90 <exec+0x174>
801009c5:	31 c0                	xor    %eax,%eax
801009c7:	89 bd ec fe ff ff    	mov    %edi,-0x114(%ebp)
801009cd:	89 c7                	mov    %eax,%edi
801009cf:	eb 16                	jmp    801009e7 <exec+0xcb>
801009d1:	8d 76 00             	lea    0x0(%esi),%esi
801009d4:	47                   	inc    %edi
801009d5:	83 c6 20             	add    $0x20,%esi
801009d8:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
801009df:	39 f8                	cmp    %edi,%eax
801009e1:	0f 8e a3 00 00 00    	jle    80100a8a <exec+0x16e>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
801009e7:	6a 20                	push   $0x20
801009e9:	56                   	push   %esi
801009ea:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
801009f0:	50                   	push   %eax
801009f1:	53                   	push   %ebx
801009f2:	e8 7d 0d 00 00       	call   80101774 <readi>
801009f7:	83 c4 10             	add    $0x10,%esp
801009fa:	83 f8 20             	cmp    $0x20,%eax
801009fd:	75 75                	jne    80100a74 <exec+0x158>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
801009ff:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100a06:	75 cc                	jne    801009d4 <exec+0xb8>
      continue;
    if(ph.memsz < ph.filesz)
80100a08:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100a0e:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100a14:	72 5e                	jb     80100a74 <exec+0x158>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100a16:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100a1c:	72 56                	jb     80100a74 <exec+0x158>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100a1e:	51                   	push   %ecx
80100a1f:	50                   	push   %eax
80100a20:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100a26:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100a2c:	e8 73 56 00 00       	call   801060a4 <allocuvm>
80100a31:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100a37:	83 c4 10             	add    $0x10,%esp
80100a3a:	85 c0                	test   %eax,%eax
80100a3c:	74 36                	je     80100a74 <exec+0x158>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100a3e:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100a44:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100a49:	75 29                	jne    80100a74 <exec+0x158>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100a4b:	83 ec 0c             	sub    $0xc,%esp
80100a4e:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100a54:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100a5a:	53                   	push   %ebx
80100a5b:	50                   	push   %eax
80100a5c:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100a62:	e8 8d 55 00 00       	call   80105ff4 <loaduvm>
80100a67:	83 c4 20             	add    $0x20,%esp
80100a6a:	85 c0                	test   %eax,%eax
80100a6c:	0f 89 62 ff ff ff    	jns    801009d4 <exec+0xb8>
80100a72:	66 90                	xchg   %ax,%ax
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100a74:	83 ec 0c             	sub    $0xc,%esp
80100a77:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100a7d:	e8 1e 57 00 00       	call   801061a0 <freevm>
80100a82:	83 c4 10             	add    $0x10,%esp
80100a85:	e9 e4 fe ff ff       	jmp    8010096e <exec+0x52>
80100a8a:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100a90:	83 ec 0c             	sub    $0xc,%esp
80100a93:	53                   	push   %ebx
80100a94:	e8 8f 0c 00 00       	call   80101728 <iunlockput>
  end_op();
80100a99:	e8 32 1d 00 00       	call   801027d0 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100a9e:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100aa4:	05 ff 0f 00 00       	add    $0xfff,%eax
80100aa9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100aae:	83 c4 0c             	add    $0xc,%esp
80100ab1:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100ab7:	52                   	push   %edx
80100ab8:	50                   	push   %eax
80100ab9:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100abf:	e8 e0 55 00 00       	call   801060a4 <allocuvm>
80100ac4:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100aca:	83 c4 10             	add    $0x10,%esp
80100acd:	85 c0                	test   %eax,%eax
80100acf:	75 3a                	jne    80100b0b <exec+0x1ef>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100ad1:	83 ec 0c             	sub    $0xc,%esp
80100ad4:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100ada:	e8 c1 56 00 00       	call   801061a0 <freevm>
80100adf:	83 c4 10             	add    $0x10,%esp
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100ae2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100ae7:	e9 98 fe ff ff       	jmp    80100984 <exec+0x68>
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100aec:	e8 df 1c 00 00       	call   801027d0 <end_op>
    cprintf("exec: fail\n");
80100af1:	83 ec 0c             	sub    $0xc,%esp
80100af4:	68 e1 64 10 80       	push   $0x801064e1
80100af9:	e8 0a fb ff ff       	call   80100608 <cprintf>
    return -1;
80100afe:	83 c4 10             	add    $0x10,%esp
80100b01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b06:	e9 79 fe ff ff       	jmp    80100984 <exec+0x68>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100b0b:	83 ec 08             	sub    $0x8,%esp
80100b0e:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b14:	2d 00 20 00 00       	sub    $0x2000,%eax
80100b19:	50                   	push   %eax
80100b1a:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b20:	e8 7f 57 00 00       	call   801062a4 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100b25:	8b 45 0c             	mov    0xc(%ebp),%eax
80100b28:	8b 00                	mov    (%eax),%eax
80100b2a:	83 c4 10             	add    $0x10,%esp
80100b2d:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100b33:	31 db                	xor    %ebx,%ebx
80100b35:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100b3b:	85 c0                	test   %eax,%eax
80100b3d:	74 6e                	je     80100bad <exec+0x291>
80100b3f:	89 bd ec fe ff ff    	mov    %edi,-0x114(%ebp)
80100b45:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100b4b:	eb 0c                	jmp    80100b59 <exec+0x23d>
80100b4d:	8d 76 00             	lea    0x0(%esi),%esi
    if(argc >= MAXARG)
80100b50:	83 fb 20             	cmp    $0x20,%ebx
80100b53:	0f 84 78 ff ff ff    	je     80100ad1 <exec+0x1b5>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100b59:	83 ec 0c             	sub    $0xc,%esp
80100b5c:	50                   	push   %eax
80100b5d:	e8 f6 33 00 00       	call   80103f58 <strlen>
80100b62:	f7 d0                	not    %eax
80100b64:	01 c6                	add    %eax,%esi
80100b66:	83 e6 fc             	and    $0xfffffffc,%esi
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100b69:	5a                   	pop    %edx
80100b6a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100b6d:	ff 34 98             	pushl  (%eax,%ebx,4)
80100b70:	e8 e3 33 00 00       	call   80103f58 <strlen>
80100b75:	40                   	inc    %eax
80100b76:	50                   	push   %eax
80100b77:	8b 45 0c             	mov    0xc(%ebp),%eax
80100b7a:	ff 34 98             	pushl  (%eax,%ebx,4)
80100b7d:	56                   	push   %esi
80100b7e:	57                   	push   %edi
80100b7f:	e8 5c 58 00 00       	call   801063e0 <copyout>
80100b84:	83 c4 20             	add    $0x20,%esp
80100b87:	85 c0                	test   %eax,%eax
80100b89:	0f 88 42 ff ff ff    	js     80100ad1 <exec+0x1b5>
      goto bad;
    ustack[3+argc] = sp;
80100b8f:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100b95:	89 b4 9d 64 ff ff ff 	mov    %esi,-0x9c(%ebp,%ebx,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100b9c:	43                   	inc    %ebx
80100b9d:	8b 45 0c             	mov    0xc(%ebp),%eax
80100ba0:	8b 04 98             	mov    (%eax,%ebx,4),%eax
80100ba3:	85 c0                	test   %eax,%eax
80100ba5:	75 a9                	jne    80100b50 <exec+0x234>
80100ba7:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100bad:	c7 84 9d 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%ebx,4)
80100bb4:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100bb8:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100bbf:	ff ff ff 
  ustack[1] = argc;
80100bc2:	89 9d 5c ff ff ff    	mov    %ebx,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100bc8:	8d 04 9d 04 00 00 00 	lea    0x4(,%ebx,4),%eax
80100bcf:	89 f1                	mov    %esi,%ecx
80100bd1:	29 c1                	sub    %eax,%ecx
80100bd3:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
80100bd9:	83 c0 0c             	add    $0xc,%eax
80100bdc:	29 c6                	sub    %eax,%esi
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100bde:	50                   	push   %eax
80100bdf:	52                   	push   %edx
80100be0:	56                   	push   %esi
80100be1:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100be7:	e8 f4 57 00 00       	call   801063e0 <copyout>
80100bec:	83 c4 10             	add    $0x10,%esp
80100bef:	85 c0                	test   %eax,%eax
80100bf1:	0f 88 da fe ff ff    	js     80100ad1 <exec+0x1b5>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100bf7:	8b 45 08             	mov    0x8(%ebp),%eax
80100bfa:	8a 10                	mov    (%eax),%dl
80100bfc:	84 d2                	test   %dl,%dl
80100bfe:	74 1b                	je     80100c1b <exec+0x2ff>
80100c00:	40                   	inc    %eax
80100c01:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100c04:	eb 09                	jmp    80100c0f <exec+0x2f3>
80100c06:	66 90                	xchg   %ax,%ax
80100c08:	8a 10                	mov    (%eax),%dl
80100c0a:	40                   	inc    %eax
80100c0b:	84 d2                	test   %dl,%dl
80100c0d:	74 09                	je     80100c18 <exec+0x2fc>
    if(*s == '/')
80100c0f:	80 fa 2f             	cmp    $0x2f,%dl
80100c12:	75 f4                	jne    80100c08 <exec+0x2ec>
      last = s+1;
80100c14:	89 c1                	mov    %eax,%ecx
80100c16:	eb f0                	jmp    80100c08 <exec+0x2ec>
80100c18:	89 4d 08             	mov    %ecx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100c1b:	50                   	push   %eax
80100c1c:	6a 10                	push   $0x10
80100c1e:	ff 75 08             	pushl  0x8(%ebp)
80100c21:	8d 47 6c             	lea    0x6c(%edi),%eax
80100c24:	50                   	push   %eax
80100c25:	e8 fa 32 00 00       	call   80103f24 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100c2a:	8b 5f 04             	mov    0x4(%edi),%ebx
  curproc->pgdir = pgdir;
80100c2d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100c33:	89 47 04             	mov    %eax,0x4(%edi)
  curproc->sz = sz;
80100c36:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c3c:	89 07                	mov    %eax,(%edi)
  curproc->tf->eip = elf.entry;  // main
80100c3e:	8b 47 18             	mov    0x18(%edi),%eax
80100c41:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100c47:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100c4a:	8b 47 18             	mov    0x18(%edi),%eax
80100c4d:	89 70 44             	mov    %esi,0x44(%eax)
  switchuvm(curproc);
80100c50:	89 3c 24             	mov    %edi,(%esp)
80100c53:	e8 28 52 00 00       	call   80105e80 <switchuvm>
  freevm(oldpgdir);
80100c58:	89 1c 24             	mov    %ebx,(%esp)
80100c5b:	e8 40 55 00 00       	call   801061a0 <freevm>
  return 0;
80100c60:	83 c4 10             	add    $0x10,%esp
80100c63:	31 c0                	xor    %eax,%eax
80100c65:	e9 1a fd ff ff       	jmp    80100984 <exec+0x68>
80100c6a:	66 90                	xchg   %ax,%ax

80100c6c <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100c6c:	55                   	push   %ebp
80100c6d:	89 e5                	mov    %esp,%ebp
80100c6f:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100c72:	68 ed 64 10 80       	push   $0x801064ed
80100c77:	68 c0 ef 10 80       	push   $0x8010efc0
80100c7c:	e8 33 2f 00 00       	call   80103bb4 <initlock>
80100c81:	83 c4 10             	add    $0x10,%esp
}
80100c84:	c9                   	leave  
80100c85:	c3                   	ret    
80100c86:	66 90                	xchg   %ax,%ax

80100c88 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100c88:	55                   	push   %ebp
80100c89:	89 e5                	mov    %esp,%ebp
80100c8b:	53                   	push   %ebx
80100c8c:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80100c8f:	68 c0 ef 10 80       	push   $0x8010efc0
80100c94:	e8 df 2f 00 00       	call   80103c78 <acquire>
80100c99:	83 c4 10             	add    $0x10,%esp
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100c9c:	bb f4 ef 10 80       	mov    $0x8010eff4,%ebx
80100ca1:	eb 0c                	jmp    80100caf <filealloc+0x27>
80100ca3:	90                   	nop
80100ca4:	83 c3 18             	add    $0x18,%ebx
80100ca7:	81 fb 54 f9 10 80    	cmp    $0x8010f954,%ebx
80100cad:	74 25                	je     80100cd4 <filealloc+0x4c>
    if(f->ref == 0){
80100caf:	8b 43 04             	mov    0x4(%ebx),%eax
80100cb2:	85 c0                	test   %eax,%eax
80100cb4:	75 ee                	jne    80100ca4 <filealloc+0x1c>
      f->ref = 1;
80100cb6:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100cbd:	83 ec 0c             	sub    $0xc,%esp
80100cc0:	68 c0 ef 10 80       	push   $0x8010efc0
80100cc5:	e8 82 30 00 00       	call   80103d4c <release>
      return f;
80100cca:	83 c4 10             	add    $0x10,%esp
80100ccd:	89 d8                	mov    %ebx,%eax
    }
  }
  release(&ftable.lock);
  return 0;
}
80100ccf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100cd2:	c9                   	leave  
80100cd3:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100cd4:	83 ec 0c             	sub    $0xc,%esp
80100cd7:	68 c0 ef 10 80       	push   $0x8010efc0
80100cdc:	e8 6b 30 00 00       	call   80103d4c <release>
  return 0;
80100ce1:	83 c4 10             	add    $0x10,%esp
80100ce4:	31 c0                	xor    %eax,%eax
}
80100ce6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ce9:	c9                   	leave  
80100cea:	c3                   	ret    
80100ceb:	90                   	nop

80100cec <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100cec:	55                   	push   %ebp
80100ced:	89 e5                	mov    %esp,%ebp
80100cef:	53                   	push   %ebx
80100cf0:	83 ec 10             	sub    $0x10,%esp
80100cf3:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100cf6:	68 c0 ef 10 80       	push   $0x8010efc0
80100cfb:	e8 78 2f 00 00       	call   80103c78 <acquire>
  if(f->ref < 1)
80100d00:	8b 53 04             	mov    0x4(%ebx),%edx
80100d03:	83 c4 10             	add    $0x10,%esp
80100d06:	85 d2                	test   %edx,%edx
80100d08:	7e 18                	jle    80100d22 <filedup+0x36>
    panic("filedup");
  f->ref++;
80100d0a:	42                   	inc    %edx
80100d0b:	89 53 04             	mov    %edx,0x4(%ebx)
  release(&ftable.lock);
80100d0e:	83 ec 0c             	sub    $0xc,%esp
80100d11:	68 c0 ef 10 80       	push   $0x8010efc0
80100d16:	e8 31 30 00 00       	call   80103d4c <release>
  return f;
}
80100d1b:	89 d8                	mov    %ebx,%eax
80100d1d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100d20:	c9                   	leave  
80100d21:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100d22:	83 ec 0c             	sub    $0xc,%esp
80100d25:	68 f4 64 10 80       	push   $0x801064f4
80100d2a:	e8 09 f6 ff ff       	call   80100338 <panic>
80100d2f:	90                   	nop

80100d30 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100d30:	55                   	push   %ebp
80100d31:	89 e5                	mov    %esp,%ebp
80100d33:	57                   	push   %edi
80100d34:	56                   	push   %esi
80100d35:	53                   	push   %ebx
80100d36:	83 ec 28             	sub    $0x28,%esp
80100d39:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100d3c:	68 c0 ef 10 80       	push   $0x8010efc0
80100d41:	e8 32 2f 00 00       	call   80103c78 <acquire>
  if(f->ref < 1)
80100d46:	8b 47 04             	mov    0x4(%edi),%eax
80100d49:	83 c4 10             	add    $0x10,%esp
80100d4c:	85 c0                	test   %eax,%eax
80100d4e:	0f 8e 8b 00 00 00    	jle    80100ddf <fileclose+0xaf>
    panic("fileclose");
  if(--f->ref > 0){
80100d54:	48                   	dec    %eax
80100d55:	89 47 04             	mov    %eax,0x4(%edi)
80100d58:	85 c0                	test   %eax,%eax
80100d5a:	74 14                	je     80100d70 <fileclose+0x40>
    release(&ftable.lock);
80100d5c:	c7 45 08 c0 ef 10 80 	movl   $0x8010efc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100d63:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100d66:	5b                   	pop    %ebx
80100d67:	5e                   	pop    %esi
80100d68:	5f                   	pop    %edi
80100d69:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
80100d6a:	e9 dd 2f 00 00       	jmp    80103d4c <release>
80100d6f:	90                   	nop
    return;
  }
  ff = *f;
80100d70:	8b 1f                	mov    (%edi),%ebx
80100d72:	8a 47 09             	mov    0x9(%edi),%al
80100d75:	88 45 e7             	mov    %al,-0x19(%ebp)
80100d78:	8b 77 0c             	mov    0xc(%edi),%esi
80100d7b:	8b 47 10             	mov    0x10(%edi),%eax
80100d7e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
80100d81:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
  release(&ftable.lock);
80100d87:	83 ec 0c             	sub    $0xc,%esp
80100d8a:	68 c0 ef 10 80       	push   $0x8010efc0
80100d8f:	e8 b8 2f 00 00       	call   80103d4c <release>

  if(ff.type == FD_PIPE)
80100d94:	83 c4 10             	add    $0x10,%esp
80100d97:	83 fb 01             	cmp    $0x1,%ebx
80100d9a:	74 10                	je     80100dac <fileclose+0x7c>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100d9c:	83 fb 02             	cmp    $0x2,%ebx
80100d9f:	74 1f                	je     80100dc0 <fileclose+0x90>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100da1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100da4:	5b                   	pop    %ebx
80100da5:	5e                   	pop    %esi
80100da6:	5f                   	pop    %edi
80100da7:	5d                   	pop    %ebp
80100da8:	c3                   	ret    
80100da9:	8d 76 00             	lea    0x0(%esi),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80100dac:	83 ec 08             	sub    $0x8,%esp
80100daf:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
80100db3:	50                   	push   %eax
80100db4:	56                   	push   %esi
80100db5:	e8 a6 20 00 00       	call   80102e60 <pipeclose>
80100dba:	83 c4 10             	add    $0x10,%esp
80100dbd:	eb e2                	jmp    80100da1 <fileclose+0x71>
80100dbf:	90                   	nop
  else if(ff.type == FD_INODE){
    begin_op();
80100dc0:	e8 a3 19 00 00       	call   80102768 <begin_op>
    iput(ff.ip);
80100dc5:	83 ec 0c             	sub    $0xc,%esp
80100dc8:	ff 75 e0             	pushl  -0x20(%ebp)
80100dcb:	e8 10 08 00 00       	call   801015e0 <iput>
    end_op();
80100dd0:	83 c4 10             	add    $0x10,%esp
  }
}
80100dd3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100dd6:	5b                   	pop    %ebx
80100dd7:	5e                   	pop    %esi
80100dd8:	5f                   	pop    %edi
80100dd9:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80100dda:	e9 f1 19 00 00       	jmp    801027d0 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100ddf:	83 ec 0c             	sub    $0xc,%esp
80100de2:	68 fc 64 10 80       	push   $0x801064fc
80100de7:	e8 4c f5 ff ff       	call   80100338 <panic>

80100dec <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100dec:	55                   	push   %ebp
80100ded:	89 e5                	mov    %esp,%ebp
80100def:	53                   	push   %ebx
80100df0:	53                   	push   %ebx
80100df1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100df4:	83 3b 02             	cmpl   $0x2,(%ebx)
80100df7:	75 2b                	jne    80100e24 <filestat+0x38>
    ilock(f->ip);
80100df9:	83 ec 0c             	sub    $0xc,%esp
80100dfc:	ff 73 10             	pushl  0x10(%ebx)
80100dff:	e8 d0 06 00 00       	call   801014d4 <ilock>
    stati(f->ip, st);
80100e04:	58                   	pop    %eax
80100e05:	5a                   	pop    %edx
80100e06:	ff 75 0c             	pushl  0xc(%ebp)
80100e09:	ff 73 10             	pushl  0x10(%ebx)
80100e0c:	e8 37 09 00 00       	call   80101748 <stati>
    iunlock(f->ip);
80100e11:	59                   	pop    %ecx
80100e12:	ff 73 10             	pushl  0x10(%ebx)
80100e15:	e8 82 07 00 00       	call   8010159c <iunlock>
    return 0;
80100e1a:	83 c4 10             	add    $0x10,%esp
80100e1d:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100e1f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e22:	c9                   	leave  
80100e23:	c3                   	ret    
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80100e24:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100e29:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e2c:	c9                   	leave  
80100e2d:	c3                   	ret    
80100e2e:	66 90                	xchg   %ax,%ax

80100e30 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	57                   	push   %edi
80100e34:	56                   	push   %esi
80100e35:	53                   	push   %ebx
80100e36:	83 ec 0c             	sub    $0xc,%esp
80100e39:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100e3c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100e3f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100e42:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100e46:	74 5c                	je     80100ea4 <fileread+0x74>
    return -1;
  if(f->type == FD_PIPE)
80100e48:	8b 03                	mov    (%ebx),%eax
80100e4a:	83 f8 01             	cmp    $0x1,%eax
80100e4d:	74 41                	je     80100e90 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100e4f:	83 f8 02             	cmp    $0x2,%eax
80100e52:	75 57                	jne    80100eab <fileread+0x7b>
    ilock(f->ip);
80100e54:	83 ec 0c             	sub    $0xc,%esp
80100e57:	ff 73 10             	pushl  0x10(%ebx)
80100e5a:	e8 75 06 00 00       	call   801014d4 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100e5f:	57                   	push   %edi
80100e60:	ff 73 14             	pushl  0x14(%ebx)
80100e63:	56                   	push   %esi
80100e64:	ff 73 10             	pushl  0x10(%ebx)
80100e67:	e8 08 09 00 00       	call   80101774 <readi>
80100e6c:	89 c6                	mov    %eax,%esi
80100e6e:	83 c4 20             	add    $0x20,%esp
80100e71:	85 c0                	test   %eax,%eax
80100e73:	7e 03                	jle    80100e78 <fileread+0x48>
      f->off += r;
80100e75:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100e78:	83 ec 0c             	sub    $0xc,%esp
80100e7b:	ff 73 10             	pushl  0x10(%ebx)
80100e7e:	e8 19 07 00 00       	call   8010159c <iunlock>
    return r;
80100e83:	83 c4 10             	add    $0x10,%esp
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100e86:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100e88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e8b:	5b                   	pop    %ebx
80100e8c:	5e                   	pop    %esi
80100e8d:	5f                   	pop    %edi
80100e8e:	5d                   	pop    %ebp
80100e8f:	c3                   	ret    
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100e90:	8b 43 0c             	mov    0xc(%ebx),%eax
80100e93:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100e96:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e99:	5b                   	pop    %ebx
80100e9a:	5e                   	pop    %esi
80100e9b:	5f                   	pop    %edi
80100e9c:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100e9d:	e9 4e 21 00 00       	jmp    80102ff0 <piperead>
80100ea2:	66 90                	xchg   %ax,%ax
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80100ea4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100ea9:	eb dd                	jmp    80100e88 <fileread+0x58>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80100eab:	83 ec 0c             	sub    $0xc,%esp
80100eae:	68 06 65 10 80       	push   $0x80106506
80100eb3:	e8 80 f4 ff ff       	call   80100338 <panic>

80100eb8 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100eb8:	55                   	push   %ebp
80100eb9:	89 e5                	mov    %esp,%ebp
80100ebb:	57                   	push   %edi
80100ebc:	56                   	push   %esi
80100ebd:	53                   	push   %ebx
80100ebe:	83 ec 1c             	sub    $0x1c,%esp
80100ec1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100ec4:	8b 45 0c             	mov    0xc(%ebp),%eax
80100ec7:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100eca:	8b 45 10             	mov    0x10(%ebp),%eax
80100ecd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
80100ed0:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
80100ed4:	0f 84 a5 00 00 00    	je     80100f7f <filewrite+0xc7>
    return -1;
  if(f->type == FD_PIPE)
80100eda:	8b 03                	mov    (%ebx),%eax
80100edc:	83 f8 01             	cmp    $0x1,%eax
80100edf:	0f 84 b6 00 00 00    	je     80100f9b <filewrite+0xe3>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100ee5:	83 f8 02             	cmp    $0x2,%eax
80100ee8:	0f 85 cc 00 00 00    	jne    80100fba <filewrite+0x102>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80100eee:	31 f6                	xor    %esi,%esi
80100ef0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100ef3:	85 c0                	test   %eax,%eax
80100ef5:	7f 30                	jg     80100f27 <filewrite+0x6f>
80100ef7:	e9 90 00 00 00       	jmp    80100f8c <filewrite+0xd4>
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80100efc:	01 43 14             	add    %eax,0x14(%ebx)
80100eff:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80100f02:	83 ec 0c             	sub    $0xc,%esp
80100f05:	ff 73 10             	pushl  0x10(%ebx)
80100f08:	e8 8f 06 00 00       	call   8010159c <iunlock>
      end_op();
80100f0d:	e8 be 18 00 00       	call   801027d0 <end_op>
80100f12:	83 c4 10             	add    $0x10,%esp
80100f15:	8b 45 e0             	mov    -0x20(%ebp),%eax

      if(r < 0)
        break;
      if(r != n1)
80100f18:	39 f8                	cmp    %edi,%eax
80100f1a:	0f 85 8d 00 00 00    	jne    80100fad <filewrite+0xf5>
        panic("short filewrite");
      i += r;
80100f20:	01 c6                	add    %eax,%esi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80100f22:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80100f25:	7e 65                	jle    80100f8c <filewrite+0xd4>
80100f27:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80100f2a:	29 f7                	sub    %esi,%edi
80100f2c:	81 ff 00 06 00 00    	cmp    $0x600,%edi
80100f32:	7e 05                	jle    80100f39 <filewrite+0x81>
80100f34:	bf 00 06 00 00       	mov    $0x600,%edi
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
80100f39:	e8 2a 18 00 00       	call   80102768 <begin_op>
      ilock(f->ip);
80100f3e:	83 ec 0c             	sub    $0xc,%esp
80100f41:	ff 73 10             	pushl  0x10(%ebx)
80100f44:	e8 8b 05 00 00       	call   801014d4 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80100f49:	57                   	push   %edi
80100f4a:	ff 73 14             	pushl  0x14(%ebx)
80100f4d:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100f50:	01 f0                	add    %esi,%eax
80100f52:	50                   	push   %eax
80100f53:	ff 73 10             	pushl  0x10(%ebx)
80100f56:	e8 1d 09 00 00       	call   80101878 <writei>
80100f5b:	83 c4 20             	add    $0x20,%esp
80100f5e:	85 c0                	test   %eax,%eax
80100f60:	7f 9a                	jg     80100efc <filewrite+0x44>
80100f62:	89 45 e0             	mov    %eax,-0x20(%ebp)
        f->off += r;
      iunlock(f->ip);
80100f65:	83 ec 0c             	sub    $0xc,%esp
80100f68:	ff 73 10             	pushl  0x10(%ebx)
80100f6b:	e8 2c 06 00 00       	call   8010159c <iunlock>
      end_op();
80100f70:	e8 5b 18 00 00       	call   801027d0 <end_op>

      if(r < 0)
80100f75:	83 c4 10             	add    $0x10,%esp
80100f78:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100f7b:	85 c0                	test   %eax,%eax
80100f7d:	74 99                	je     80100f18 <filewrite+0x60>
filewrite(struct file *f, char *addr, int n)
{
  int r;

  if(f->writable == 0)
    return -1;
80100f7f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80100f84:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f87:	5b                   	pop    %ebx
80100f88:	5e                   	pop    %esi
80100f89:	5f                   	pop    %edi
80100f8a:	5d                   	pop    %ebp
80100f8b:	c3                   	ret    
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
80100f8c:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
80100f8f:	75 ee                	jne    80100f7f <filewrite+0xc7>
80100f91:	89 f0                	mov    %esi,%eax
  }
  panic("filewrite");
}
80100f93:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f96:	5b                   	pop    %ebx
80100f97:	5e                   	pop    %esi
80100f98:	5f                   	pop    %edi
80100f99:	5d                   	pop    %ebp
80100f9a:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
80100f9b:	8b 43 0c             	mov    0xc(%ebx),%eax
80100f9e:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80100fa1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fa4:	5b                   	pop    %ebx
80100fa5:	5e                   	pop    %esi
80100fa6:	5f                   	pop    %edi
80100fa7:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
80100fa8:	e9 4b 1f 00 00       	jmp    80102ef8 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
80100fad:	83 ec 0c             	sub    $0xc,%esp
80100fb0:	68 0f 65 10 80       	push   $0x8010650f
80100fb5:	e8 7e f3 ff ff       	call   80100338 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
80100fba:	83 ec 0c             	sub    $0xc,%esp
80100fbd:	68 15 65 10 80       	push   $0x80106515
80100fc2:	e8 71 f3 ff ff       	call   80100338 <panic>
80100fc7:	90                   	nop

80100fc8 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80100fc8:	55                   	push   %ebp
80100fc9:	89 e5                	mov    %esp,%ebp
80100fcb:	57                   	push   %edi
80100fcc:	56                   	push   %esi
80100fcd:	53                   	push   %ebx
80100fce:	83 ec 1c             	sub    $0x1c,%esp
80100fd1:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80100fd4:	8b 0d c0 f9 10 80    	mov    0x8010f9c0,%ecx
80100fda:	85 c9                	test   %ecx,%ecx
80100fdc:	74 7c                	je     8010105a <balloc+0x92>
80100fde:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80100fe5:	83 ec 08             	sub    $0x8,%esp
80100fe8:	8b 75 dc             	mov    -0x24(%ebp),%esi
80100feb:	89 f0                	mov    %esi,%eax
80100fed:	c1 f8 0c             	sar    $0xc,%eax
80100ff0:	03 05 d8 f9 10 80    	add    0x8010f9d8,%eax
80100ff6:	50                   	push   %eax
80100ff7:	ff 75 d8             	pushl  -0x28(%ebp)
80100ffa:	e8 b5 f0 ff ff       	call   801000b4 <bread>
80100fff:	89 c2                	mov    %eax,%edx
80101001:	a1 c0 f9 10 80       	mov    0x8010f9c0,%eax
80101006:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101009:	83 c4 10             	add    $0x10,%esp
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010100c:	31 c0                	xor    %eax,%eax
8010100e:	eb 27                	jmp    80101037 <balloc+0x6f>
      m = 1 << (bi % 8);
80101010:	89 c1                	mov    %eax,%ecx
80101012:	83 e1 07             	and    $0x7,%ecx
80101015:	bf 01 00 00 00       	mov    $0x1,%edi
8010101a:	d3 e7                	shl    %cl,%edi
8010101c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010101f:	89 c1                	mov    %eax,%ecx
80101021:	c1 f9 03             	sar    $0x3,%ecx
80101024:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101029:	85 7d e4             	test   %edi,-0x1c(%ebp)
8010102c:	74 3a                	je     80101068 <balloc+0xa0>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010102e:	40                   	inc    %eax
8010102f:	46                   	inc    %esi
80101030:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101035:	74 05                	je     8010103c <balloc+0x74>
80101037:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010103a:	72 d4                	jb     80101010 <balloc+0x48>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
8010103c:	83 ec 0c             	sub    $0xc,%esp
8010103f:	52                   	push   %edx
80101040:	e8 73 f1 ff ff       	call   801001b8 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101045:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
8010104c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010104f:	83 c4 10             	add    $0x10,%esp
80101052:	3b 05 c0 f9 10 80    	cmp    0x8010f9c0,%eax
80101058:	72 8b                	jb     80100fe5 <balloc+0x1d>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
8010105a:	83 ec 0c             	sub    $0xc,%esp
8010105d:	68 1f 65 10 80       	push   $0x8010651f
80101062:	e8 d1 f2 ff ff       	call   80100338 <panic>
80101067:	90                   	nop
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101068:	8a 45 e4             	mov    -0x1c(%ebp),%al
8010106b:	09 f8                	or     %edi,%eax
8010106d:	88 44 0a 5c          	mov    %al,0x5c(%edx,%ecx,1)
        log_write(bp);
80101071:	83 ec 0c             	sub    $0xc,%esp
80101074:	52                   	push   %edx
80101075:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101078:	e8 a7 18 00 00       	call   80102924 <log_write>
        brelse(bp);
8010107d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101080:	89 14 24             	mov    %edx,(%esp)
80101083:	e8 30 f1 ff ff       	call   801001b8 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
80101088:	58                   	pop    %eax
80101089:	5a                   	pop    %edx
8010108a:	56                   	push   %esi
8010108b:	ff 75 d8             	pushl  -0x28(%ebp)
8010108e:	e8 21 f0 ff ff       	call   801000b4 <bread>
80101093:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101095:	83 c4 0c             	add    $0xc,%esp
80101098:	68 00 02 00 00       	push   $0x200
8010109d:	6a 00                	push   $0x0
8010109f:	8d 40 5c             	lea    0x5c(%eax),%eax
801010a2:	50                   	push   %eax
801010a3:	e8 f0 2c 00 00       	call   80103d98 <memset>
  log_write(bp);
801010a8:	89 1c 24             	mov    %ebx,(%esp)
801010ab:	e8 74 18 00 00       	call   80102924 <log_write>
  brelse(bp);
801010b0:	89 1c 24             	mov    %ebx,(%esp)
801010b3:	e8 00 f1 ff ff       	call   801001b8 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
801010b8:	89 f0                	mov    %esi,%eax
801010ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010bd:	5b                   	pop    %ebx
801010be:	5e                   	pop    %esi
801010bf:	5f                   	pop    %edi
801010c0:	5d                   	pop    %ebp
801010c1:	c3                   	ret    
801010c2:	66 90                	xchg   %ax,%ax

801010c4 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801010c4:	55                   	push   %ebp
801010c5:	89 e5                	mov    %esp,%ebp
801010c7:	57                   	push   %edi
801010c8:	56                   	push   %esi
801010c9:	53                   	push   %ebx
801010ca:	83 ec 28             	sub    $0x28,%esp
801010cd:	89 c7                	mov    %eax,%edi
801010cf:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
801010d2:	68 e0 f9 10 80       	push   $0x8010f9e0
801010d7:	e8 9c 2b 00 00       	call   80103c78 <acquire>
801010dc:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
801010df:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801010e1:	b9 14 fa 10 80       	mov    $0x8010fa14,%ecx
801010e6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801010e9:	eb 13                	jmp    801010fe <iget+0x3a>
801010eb:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801010ec:	85 f6                	test   %esi,%esi
801010ee:	74 40                	je     80101130 <iget+0x6c>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801010f0:	81 c1 90 00 00 00    	add    $0x90,%ecx
801010f6:	81 f9 34 16 11 80    	cmp    $0x80111634,%ecx
801010fc:	74 46                	je     80101144 <iget+0x80>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801010fe:	8b 59 08             	mov    0x8(%ecx),%ebx
80101101:	85 db                	test   %ebx,%ebx
80101103:	7e e7                	jle    801010ec <iget+0x28>
80101105:	39 39                	cmp    %edi,(%ecx)
80101107:	75 e3                	jne    801010ec <iget+0x28>
80101109:	39 51 04             	cmp    %edx,0x4(%ecx)
8010110c:	75 de                	jne    801010ec <iget+0x28>
8010110e:	89 ce                	mov    %ecx,%esi
      ip->ref++;
80101110:	43                   	inc    %ebx
80101111:	89 59 08             	mov    %ebx,0x8(%ecx)
      release(&icache.lock);
80101114:	83 ec 0c             	sub    $0xc,%esp
80101117:	68 e0 f9 10 80       	push   $0x8010f9e0
8010111c:	e8 2b 2c 00 00       	call   80103d4c <release>
      return ip;
80101121:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
80101124:	89 f0                	mov    %esi,%eax
80101126:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101129:	5b                   	pop    %ebx
8010112a:	5e                   	pop    %esi
8010112b:	5f                   	pop    %edi
8010112c:	5d                   	pop    %ebp
8010112d:	c3                   	ret    
8010112e:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101130:	85 db                	test   %ebx,%ebx
80101132:	75 bc                	jne    801010f0 <iget+0x2c>
80101134:	89 ce                	mov    %ecx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101136:	81 c1 90 00 00 00    	add    $0x90,%ecx
8010113c:	81 f9 34 16 11 80    	cmp    $0x80111634,%ecx
80101142:	75 ba                	jne    801010fe <iget+0x3a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101144:	85 f6                	test   %esi,%esi
80101146:	74 2d                	je     80101175 <iget+0xb1>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
80101148:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
8010114a:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010114d:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101154:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010115b:	83 ec 0c             	sub    $0xc,%esp
8010115e:	68 e0 f9 10 80       	push   $0x8010f9e0
80101163:	e8 e4 2b 00 00       	call   80103d4c <release>

  return ip;
80101168:	83 c4 10             	add    $0x10,%esp
}
8010116b:	89 f0                	mov    %esi,%eax
8010116d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101170:	5b                   	pop    %ebx
80101171:	5e                   	pop    %esi
80101172:	5f                   	pop    %edi
80101173:	5d                   	pop    %ebp
80101174:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
80101175:	83 ec 0c             	sub    $0xc,%esp
80101178:	68 35 65 10 80       	push   $0x80106535
8010117d:	e8 b6 f1 ff ff       	call   80100338 <panic>
80101182:	66 90                	xchg   %ax,%ax

80101184 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101184:	55                   	push   %ebp
80101185:	89 e5                	mov    %esp,%ebp
80101187:	57                   	push   %edi
80101188:	56                   	push   %esi
80101189:	53                   	push   %ebx
8010118a:	83 ec 1c             	sub    $0x1c,%esp
8010118d:	89 c6                	mov    %eax,%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010118f:	83 fa 0b             	cmp    $0xb,%edx
80101192:	77 14                	ja     801011a8 <bmap+0x24>
80101194:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    if((addr = ip->addrs[bn]) == 0)
80101197:	8b 53 5c             	mov    0x5c(%ebx),%edx
8010119a:	85 d2                	test   %edx,%edx
8010119c:	74 6a                	je     80101208 <bmap+0x84>
8010119e:	89 d0                	mov    %edx,%eax
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801011a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011a3:	5b                   	pop    %ebx
801011a4:	5e                   	pop    %esi
801011a5:	5f                   	pop    %edi
801011a6:	5d                   	pop    %ebp
801011a7:	c3                   	ret    
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801011a8:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801011ab:	83 fb 7f             	cmp    $0x7f,%ebx
801011ae:	77 7b                	ja     8010122b <bmap+0xa7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801011b0:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801011b6:	85 c0                	test   %eax,%eax
801011b8:	74 62                	je     8010121c <bmap+0x98>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801011ba:	83 ec 08             	sub    $0x8,%esp
801011bd:	50                   	push   %eax
801011be:	ff 36                	pushl  (%esi)
801011c0:	e8 ef ee ff ff       	call   801000b4 <bread>
801011c5:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801011c7:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
801011cb:	8b 1a                	mov    (%edx),%ebx
801011cd:	83 c4 10             	add    $0x10,%esp
801011d0:	85 db                	test   %ebx,%ebx
801011d2:	75 1d                	jne    801011f1 <bmap+0x6d>
801011d4:	89 55 e4             	mov    %edx,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
801011d7:	8b 06                	mov    (%esi),%eax
801011d9:	e8 ea fd ff ff       	call   80100fc8 <balloc>
801011de:	89 c3                	mov    %eax,%ebx
801011e0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801011e3:	89 02                	mov    %eax,(%edx)
      log_write(bp);
801011e5:	83 ec 0c             	sub    $0xc,%esp
801011e8:	57                   	push   %edi
801011e9:	e8 36 17 00 00       	call   80102924 <log_write>
801011ee:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
801011f1:	83 ec 0c             	sub    $0xc,%esp
801011f4:	57                   	push   %edi
801011f5:	e8 be ef ff ff       	call   801001b8 <brelse>
801011fa:	83 c4 10             	add    $0x10,%esp
801011fd:	89 d8                	mov    %ebx,%eax
    return addr;
  }

  panic("bmap: out of range");
}
801011ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101202:	5b                   	pop    %ebx
80101203:	5e                   	pop    %esi
80101204:	5f                   	pop    %edi
80101205:	5d                   	pop    %ebp
80101206:	c3                   	ret    
80101207:	90                   	nop
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101208:	8b 00                	mov    (%eax),%eax
8010120a:	e8 b9 fd ff ff       	call   80100fc8 <balloc>
8010120f:	89 43 5c             	mov    %eax,0x5c(%ebx)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
80101212:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101215:	5b                   	pop    %ebx
80101216:	5e                   	pop    %esi
80101217:	5f                   	pop    %edi
80101218:	5d                   	pop    %ebp
80101219:	c3                   	ret    
8010121a:	66 90                	xchg   %ax,%ax
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
8010121c:	8b 06                	mov    (%esi),%eax
8010121e:	e8 a5 fd ff ff       	call   80100fc8 <balloc>
80101223:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101229:	eb 8f                	jmp    801011ba <bmap+0x36>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
8010122b:	83 ec 0c             	sub    $0xc,%esp
8010122e:	68 45 65 10 80       	push   $0x80106545
80101233:	e8 00 f1 ff ff       	call   80100338 <panic>

80101238 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101238:	55                   	push   %ebp
80101239:	89 e5                	mov    %esp,%ebp
8010123b:	56                   	push   %esi
8010123c:	53                   	push   %ebx
8010123d:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
80101240:	83 ec 08             	sub    $0x8,%esp
80101243:	6a 01                	push   $0x1
80101245:	ff 75 08             	pushl  0x8(%ebp)
80101248:	e8 67 ee ff ff       	call   801000b4 <bread>
8010124d:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010124f:	83 c4 0c             	add    $0xc,%esp
80101252:	6a 1c                	push   $0x1c
80101254:	8d 40 5c             	lea    0x5c(%eax),%eax
80101257:	50                   	push   %eax
80101258:	56                   	push   %esi
80101259:	e8 ce 2b 00 00       	call   80103e2c <memmove>
  brelse(bp);
8010125e:	83 c4 10             	add    $0x10,%esp
80101261:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101264:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101267:	5b                   	pop    %ebx
80101268:	5e                   	pop    %esi
80101269:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
8010126a:	e9 49 ef ff ff       	jmp    801001b8 <brelse>
8010126f:	90                   	nop

80101270 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101270:	55                   	push   %ebp
80101271:	89 e5                	mov    %esp,%ebp
80101273:	56                   	push   %esi
80101274:	53                   	push   %ebx
80101275:	89 c6                	mov    %eax,%esi
80101277:	89 d3                	mov    %edx,%ebx
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
80101279:	83 ec 08             	sub    $0x8,%esp
8010127c:	68 c0 f9 10 80       	push   $0x8010f9c0
80101281:	50                   	push   %eax
80101282:	e8 b1 ff ff ff       	call   80101238 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101287:	58                   	pop    %eax
80101288:	5a                   	pop    %edx
80101289:	89 da                	mov    %ebx,%edx
8010128b:	c1 ea 0c             	shr    $0xc,%edx
8010128e:	03 15 d8 f9 10 80    	add    0x8010f9d8,%edx
80101294:	52                   	push   %edx
80101295:	56                   	push   %esi
80101296:	e8 19 ee ff ff       	call   801000b4 <bread>
8010129b:	89 c6                	mov    %eax,%esi
  bi = b % BPB;
  m = 1 << (bi % 8);
8010129d:	89 d9                	mov    %ebx,%ecx
8010129f:	83 e1 07             	and    $0x7,%ecx
801012a2:	ba 01 00 00 00       	mov    $0x1,%edx
801012a7:	d3 e2                	shl    %cl,%edx
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
801012a9:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
801012af:	c1 fb 03             	sar    $0x3,%ebx
801012b2:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
801012b7:	83 c4 10             	add    $0x10,%esp
801012ba:	85 d1                	test   %edx,%ecx
801012bc:	74 25                	je     801012e3 <bfree+0x73>
801012be:	89 c8                	mov    %ecx,%eax
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
801012c0:	f7 d2                	not    %edx
801012c2:	21 d0                	and    %edx,%eax
801012c4:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
801012c8:	83 ec 0c             	sub    $0xc,%esp
801012cb:	56                   	push   %esi
801012cc:	e8 53 16 00 00       	call   80102924 <log_write>
  brelse(bp);
801012d1:	89 34 24             	mov    %esi,(%esp)
801012d4:	e8 df ee ff ff       	call   801001b8 <brelse>
801012d9:	83 c4 10             	add    $0x10,%esp
}
801012dc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801012df:	5b                   	pop    %ebx
801012e0:	5e                   	pop    %esi
801012e1:	5d                   	pop    %ebp
801012e2:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
801012e3:	83 ec 0c             	sub    $0xc,%esp
801012e6:	68 58 65 10 80       	push   $0x80106558
801012eb:	e8 48 f0 ff ff       	call   80100338 <panic>

801012f0 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
801012f0:	55                   	push   %ebp
801012f1:	89 e5                	mov    %esp,%ebp
801012f3:	53                   	push   %ebx
801012f4:	83 ec 0c             	sub    $0xc,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
801012f7:	68 6b 65 10 80       	push   $0x8010656b
801012fc:	68 e0 f9 10 80       	push   $0x8010f9e0
80101301:	e8 ae 28 00 00       	call   80103bb4 <initlock>
80101306:	bb 20 fa 10 80       	mov    $0x8010fa20,%ebx
8010130b:	83 c4 10             	add    $0x10,%esp
8010130e:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
80101310:	83 ec 08             	sub    $0x8,%esp
80101313:	68 72 65 10 80       	push   $0x80106572
80101318:	53                   	push   %ebx
80101319:	e8 aa 27 00 00       	call   80103ac8 <initsleeplock>
8010131e:	81 c3 90 00 00 00    	add    $0x90,%ebx
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
80101324:	83 c4 10             	add    $0x10,%esp
80101327:	81 fb 40 16 11 80    	cmp    $0x80111640,%ebx
8010132d:	75 e1                	jne    80101310 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
8010132f:	83 ec 08             	sub    $0x8,%esp
80101332:	68 c0 f9 10 80       	push   $0x8010f9c0
80101337:	ff 75 08             	pushl  0x8(%ebp)
8010133a:	e8 f9 fe ff ff       	call   80101238 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010133f:	ff 35 d8 f9 10 80    	pushl  0x8010f9d8
80101345:	ff 35 d4 f9 10 80    	pushl  0x8010f9d4
8010134b:	ff 35 d0 f9 10 80    	pushl  0x8010f9d0
80101351:	ff 35 cc f9 10 80    	pushl  0x8010f9cc
80101357:	ff 35 c8 f9 10 80    	pushl  0x8010f9c8
8010135d:	ff 35 c4 f9 10 80    	pushl  0x8010f9c4
80101363:	ff 35 c0 f9 10 80    	pushl  0x8010f9c0
80101369:	68 d8 65 10 80       	push   $0x801065d8
8010136e:	e8 95 f2 ff ff       	call   80100608 <cprintf>
80101373:	83 c4 30             	add    $0x30,%esp
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
80101376:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101379:	c9                   	leave  
8010137a:	c3                   	ret    
8010137b:	90                   	nop

8010137c <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
8010137c:	55                   	push   %ebp
8010137d:	89 e5                	mov    %esp,%ebp
8010137f:	57                   	push   %edi
80101380:	56                   	push   %esi
80101381:	53                   	push   %ebx
80101382:	83 ec 1c             	sub    $0x1c,%esp
80101385:	8b 75 08             	mov    0x8(%ebp),%esi
80101388:	8b 45 0c             	mov    0xc(%ebp),%eax
8010138b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010138e:	83 3d c8 f9 10 80 01 	cmpl   $0x1,0x8010f9c8
80101395:	0f 86 84 00 00 00    	jbe    8010141f <ialloc+0xa3>
8010139b:	bb 01 00 00 00       	mov    $0x1,%ebx
801013a0:	eb 17                	jmp    801013b9 <ialloc+0x3d>
801013a2:	66 90                	xchg   %ax,%ax
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
801013a4:	83 ec 0c             	sub    $0xc,%esp
801013a7:	50                   	push   %eax
801013a8:	e8 0b ee ff ff       	call   801001b8 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801013ad:	43                   	inc    %ebx
801013ae:	83 c4 10             	add    $0x10,%esp
801013b1:	3b 1d c8 f9 10 80    	cmp    0x8010f9c8,%ebx
801013b7:	73 66                	jae    8010141f <ialloc+0xa3>
    bp = bread(dev, IBLOCK(inum, sb));
801013b9:	83 ec 08             	sub    $0x8,%esp
801013bc:	89 d8                	mov    %ebx,%eax
801013be:	c1 e8 03             	shr    $0x3,%eax
801013c1:	03 05 d4 f9 10 80    	add    0x8010f9d4,%eax
801013c7:	50                   	push   %eax
801013c8:	56                   	push   %esi
801013c9:	e8 e6 ec ff ff       	call   801000b4 <bread>
801013ce:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
801013d0:	89 da                	mov    %ebx,%edx
801013d2:	83 e2 07             	and    $0x7,%edx
801013d5:	c1 e2 06             	shl    $0x6,%edx
801013d8:	8d 54 10 5c          	lea    0x5c(%eax,%edx,1),%edx
    if(dip->type == 0){  // a free inode
801013dc:	83 c4 10             	add    $0x10,%esp
801013df:	66 83 3a 00          	cmpw   $0x0,(%edx)
801013e3:	75 bf                	jne    801013a4 <ialloc+0x28>
      memset(dip, 0, sizeof(*dip));
801013e5:	50                   	push   %eax
801013e6:	6a 40                	push   $0x40
801013e8:	6a 00                	push   $0x0
801013ea:	52                   	push   %edx
801013eb:	89 55 e0             	mov    %edx,-0x20(%ebp)
801013ee:	e8 a5 29 00 00       	call   80103d98 <memset>
      dip->type = type;
801013f3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801013f6:	8b 55 e0             	mov    -0x20(%ebp),%edx
801013f9:	66 89 02             	mov    %ax,(%edx)
      log_write(bp);   // mark it allocated on the disk
801013fc:	89 3c 24             	mov    %edi,(%esp)
801013ff:	e8 20 15 00 00       	call   80102924 <log_write>
      brelse(bp);
80101404:	89 3c 24             	mov    %edi,(%esp)
80101407:	e8 ac ed ff ff       	call   801001b8 <brelse>
      return iget(dev, inum);
8010140c:	83 c4 10             	add    $0x10,%esp
8010140f:	89 da                	mov    %ebx,%edx
80101411:	89 f0                	mov    %esi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101413:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101416:	5b                   	pop    %ebx
80101417:	5e                   	pop    %esi
80101418:	5f                   	pop    %edi
80101419:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
8010141a:	e9 a5 fc ff ff       	jmp    801010c4 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
8010141f:	83 ec 0c             	sub    $0xc,%esp
80101422:	68 78 65 10 80       	push   $0x80106578
80101427:	e8 0c ef ff ff       	call   80100338 <panic>

8010142c <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
8010142c:	55                   	push   %ebp
8010142d:	89 e5                	mov    %esp,%ebp
8010142f:	56                   	push   %esi
80101430:	53                   	push   %ebx
80101431:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101434:	83 ec 08             	sub    $0x8,%esp
80101437:	8b 43 04             	mov    0x4(%ebx),%eax
8010143a:	c1 e8 03             	shr    $0x3,%eax
8010143d:	03 05 d4 f9 10 80    	add    0x8010f9d4,%eax
80101443:	50                   	push   %eax
80101444:	ff 33                	pushl  (%ebx)
80101446:	e8 69 ec ff ff       	call   801000b4 <bread>
8010144b:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010144d:	8b 43 04             	mov    0x4(%ebx),%eax
80101450:	83 e0 07             	and    $0x7,%eax
80101453:	c1 e0 06             	shl    $0x6,%eax
80101456:	8d 54 06 5c          	lea    0x5c(%esi,%eax,1),%edx
  dip->type = ip->type;
8010145a:	8b 43 50             	mov    0x50(%ebx),%eax
8010145d:	66 89 02             	mov    %ax,(%edx)
  dip->major = ip->major;
80101460:	66 8b 43 52          	mov    0x52(%ebx),%ax
80101464:	66 89 42 02          	mov    %ax,0x2(%edx)
  dip->minor = ip->minor;
80101468:	8b 43 54             	mov    0x54(%ebx),%eax
8010146b:	66 89 42 04          	mov    %ax,0x4(%edx)
  dip->nlink = ip->nlink;
8010146f:	66 8b 43 56          	mov    0x56(%ebx),%ax
80101473:	66 89 42 06          	mov    %ax,0x6(%edx)
  dip->size = ip->size;
80101477:	8b 43 58             	mov    0x58(%ebx),%eax
8010147a:	89 42 08             	mov    %eax,0x8(%edx)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010147d:	83 c4 0c             	add    $0xc,%esp
80101480:	6a 34                	push   $0x34
80101482:	83 c3 5c             	add    $0x5c,%ebx
80101485:	53                   	push   %ebx
80101486:	83 c2 0c             	add    $0xc,%edx
80101489:	52                   	push   %edx
8010148a:	e8 9d 29 00 00       	call   80103e2c <memmove>
  log_write(bp);
8010148f:	89 34 24             	mov    %esi,(%esp)
80101492:	e8 8d 14 00 00       	call   80102924 <log_write>
  brelse(bp);
80101497:	83 c4 10             	add    $0x10,%esp
8010149a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010149d:	8d 65 f8             	lea    -0x8(%ebp),%esp
801014a0:	5b                   	pop    %ebx
801014a1:	5e                   	pop    %esi
801014a2:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
801014a3:	e9 10 ed ff ff       	jmp    801001b8 <brelse>

801014a8 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
801014a8:	55                   	push   %ebp
801014a9:	89 e5                	mov    %esp,%ebp
801014ab:	53                   	push   %ebx
801014ac:	83 ec 10             	sub    $0x10,%esp
801014af:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801014b2:	68 e0 f9 10 80       	push   $0x8010f9e0
801014b7:	e8 bc 27 00 00       	call   80103c78 <acquire>
  ip->ref++;
801014bc:	ff 43 08             	incl   0x8(%ebx)
  release(&icache.lock);
801014bf:	c7 04 24 e0 f9 10 80 	movl   $0x8010f9e0,(%esp)
801014c6:	e8 81 28 00 00       	call   80103d4c <release>
  return ip;
}
801014cb:	89 d8                	mov    %ebx,%eax
801014cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801014d0:	c9                   	leave  
801014d1:	c3                   	ret    
801014d2:	66 90                	xchg   %ax,%ax

801014d4 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
801014d4:	55                   	push   %ebp
801014d5:	89 e5                	mov    %esp,%ebp
801014d7:	56                   	push   %esi
801014d8:	53                   	push   %ebx
801014d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
801014dc:	85 db                	test   %ebx,%ebx
801014de:	0f 84 a9 00 00 00    	je     8010158d <ilock+0xb9>
801014e4:	8b 53 08             	mov    0x8(%ebx),%edx
801014e7:	85 d2                	test   %edx,%edx
801014e9:	0f 8e 9e 00 00 00    	jle    8010158d <ilock+0xb9>
    panic("ilock");

  acquiresleep(&ip->lock);
801014ef:	83 ec 0c             	sub    $0xc,%esp
801014f2:	8d 43 0c             	lea    0xc(%ebx),%eax
801014f5:	50                   	push   %eax
801014f6:	e8 01 26 00 00       	call   80103afc <acquiresleep>

  if(ip->valid == 0){
801014fb:	83 c4 10             	add    $0x10,%esp
801014fe:	8b 43 4c             	mov    0x4c(%ebx),%eax
80101501:	85 c0                	test   %eax,%eax
80101503:	74 07                	je     8010150c <ilock+0x38>
    brelse(bp);
    ip->valid = 1;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
80101505:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101508:	5b                   	pop    %ebx
80101509:	5e                   	pop    %esi
8010150a:	5d                   	pop    %ebp
8010150b:	c3                   	ret    
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010150c:	83 ec 08             	sub    $0x8,%esp
8010150f:	8b 43 04             	mov    0x4(%ebx),%eax
80101512:	c1 e8 03             	shr    $0x3,%eax
80101515:	03 05 d4 f9 10 80    	add    0x8010f9d4,%eax
8010151b:	50                   	push   %eax
8010151c:	ff 33                	pushl  (%ebx)
8010151e:	e8 91 eb ff ff       	call   801000b4 <bread>
80101523:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101525:	8b 53 04             	mov    0x4(%ebx),%edx
80101528:	83 e2 07             	and    $0x7,%edx
8010152b:	c1 e2 06             	shl    $0x6,%edx
8010152e:	8d 54 10 5c          	lea    0x5c(%eax,%edx,1),%edx
    ip->type = dip->type;
80101532:	8b 02                	mov    (%edx),%eax
80101534:	66 89 43 50          	mov    %ax,0x50(%ebx)
    ip->major = dip->major;
80101538:	66 8b 42 02          	mov    0x2(%edx),%ax
8010153c:	66 89 43 52          	mov    %ax,0x52(%ebx)
    ip->minor = dip->minor;
80101540:	8b 42 04             	mov    0x4(%edx),%eax
80101543:	66 89 43 54          	mov    %ax,0x54(%ebx)
    ip->nlink = dip->nlink;
80101547:	66 8b 42 06          	mov    0x6(%edx),%ax
8010154b:	66 89 43 56          	mov    %ax,0x56(%ebx)
    ip->size = dip->size;
8010154f:	8b 42 08             	mov    0x8(%edx),%eax
80101552:	89 43 58             	mov    %eax,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101555:	83 c4 0c             	add    $0xc,%esp
80101558:	6a 34                	push   $0x34
8010155a:	83 c2 0c             	add    $0xc,%edx
8010155d:	52                   	push   %edx
8010155e:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101561:	50                   	push   %eax
80101562:	e8 c5 28 00 00       	call   80103e2c <memmove>
    brelse(bp);
80101567:	89 34 24             	mov    %esi,(%esp)
8010156a:	e8 49 ec ff ff       	call   801001b8 <brelse>
    ip->valid = 1;
8010156f:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101576:	83 c4 10             	add    $0x10,%esp
80101579:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
8010157e:	75 85                	jne    80101505 <ilock+0x31>
      panic("ilock: no type");
80101580:	83 ec 0c             	sub    $0xc,%esp
80101583:	68 90 65 10 80       	push   $0x80106590
80101588:	e8 ab ed ff ff       	call   80100338 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
8010158d:	83 ec 0c             	sub    $0xc,%esp
80101590:	68 8a 65 10 80       	push   $0x8010658a
80101595:	e8 9e ed ff ff       	call   80100338 <panic>
8010159a:	66 90                	xchg   %ax,%ax

8010159c <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
8010159c:	55                   	push   %ebp
8010159d:	89 e5                	mov    %esp,%ebp
8010159f:	56                   	push   %esi
801015a0:	53                   	push   %ebx
801015a1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801015a4:	85 db                	test   %ebx,%ebx
801015a6:	74 28                	je     801015d0 <iunlock+0x34>
801015a8:	8d 73 0c             	lea    0xc(%ebx),%esi
801015ab:	83 ec 0c             	sub    $0xc,%esp
801015ae:	56                   	push   %esi
801015af:	e8 d8 25 00 00       	call   80103b8c <holdingsleep>
801015b4:	83 c4 10             	add    $0x10,%esp
801015b7:	85 c0                	test   %eax,%eax
801015b9:	74 15                	je     801015d0 <iunlock+0x34>
801015bb:	8b 43 08             	mov    0x8(%ebx),%eax
801015be:	85 c0                	test   %eax,%eax
801015c0:	7e 0e                	jle    801015d0 <iunlock+0x34>
    panic("iunlock");

  releasesleep(&ip->lock);
801015c2:	89 75 08             	mov    %esi,0x8(%ebp)
}
801015c5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801015c8:	5b                   	pop    %ebx
801015c9:	5e                   	pop    %esi
801015ca:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
801015cb:	e9 80 25 00 00       	jmp    80103b50 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
801015d0:	83 ec 0c             	sub    $0xc,%esp
801015d3:	68 9f 65 10 80       	push   $0x8010659f
801015d8:	e8 5b ed ff ff       	call   80100338 <panic>
801015dd:	8d 76 00             	lea    0x0(%esi),%esi

801015e0 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
801015e0:	55                   	push   %ebp
801015e1:	89 e5                	mov    %esp,%ebp
801015e3:	57                   	push   %edi
801015e4:	56                   	push   %esi
801015e5:	53                   	push   %ebx
801015e6:	83 ec 28             	sub    $0x28,%esp
801015e9:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquiresleep(&ip->lock);
801015ec:	8d 77 0c             	lea    0xc(%edi),%esi
801015ef:	56                   	push   %esi
801015f0:	e8 07 25 00 00       	call   80103afc <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801015f5:	83 c4 10             	add    $0x10,%esp
801015f8:	8b 47 4c             	mov    0x4c(%edi),%eax
801015fb:	85 c0                	test   %eax,%eax
801015fd:	74 07                	je     80101606 <iput+0x26>
801015ff:	66 83 7f 56 00       	cmpw   $0x0,0x56(%edi)
80101604:	74 2e                	je     80101634 <iput+0x54>
      ip->type = 0;
      iupdate(ip);
      ip->valid = 0;
    }
  }
  releasesleep(&ip->lock);
80101606:	83 ec 0c             	sub    $0xc,%esp
80101609:	56                   	push   %esi
8010160a:	e8 41 25 00 00       	call   80103b50 <releasesleep>

  acquire(&icache.lock);
8010160f:	c7 04 24 e0 f9 10 80 	movl   $0x8010f9e0,(%esp)
80101616:	e8 5d 26 00 00       	call   80103c78 <acquire>
  ip->ref--;
8010161b:	ff 4f 08             	decl   0x8(%edi)
  release(&icache.lock);
8010161e:	83 c4 10             	add    $0x10,%esp
80101621:	c7 45 08 e0 f9 10 80 	movl   $0x8010f9e0,0x8(%ebp)
}
80101628:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010162b:	5b                   	pop    %ebx
8010162c:	5e                   	pop    %esi
8010162d:	5f                   	pop    %edi
8010162e:	5d                   	pop    %ebp
  }
  releasesleep(&ip->lock);

  acquire(&icache.lock);
  ip->ref--;
  release(&icache.lock);
8010162f:	e9 18 27 00 00       	jmp    80103d4c <release>
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
80101634:	83 ec 0c             	sub    $0xc,%esp
80101637:	68 e0 f9 10 80       	push   $0x8010f9e0
8010163c:	e8 37 26 00 00       	call   80103c78 <acquire>
    int r = ip->ref;
80101641:	8b 5f 08             	mov    0x8(%edi),%ebx
    release(&icache.lock);
80101644:	c7 04 24 e0 f9 10 80 	movl   $0x8010f9e0,(%esp)
8010164b:	e8 fc 26 00 00       	call   80103d4c <release>
    if(r == 1){
80101650:	83 c4 10             	add    $0x10,%esp
80101653:	4b                   	dec    %ebx
80101654:	75 b0                	jne    80101606 <iput+0x26>
80101656:	8d 5f 5c             	lea    0x5c(%edi),%ebx
80101659:	8d 8f 8c 00 00 00    	lea    0x8c(%edi),%ecx
8010165f:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80101662:	89 ce                	mov    %ecx,%esi
80101664:	eb 09                	jmp    8010166f <iput+0x8f>
80101666:	66 90                	xchg   %ax,%ax
80101668:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
8010166b:	39 f3                	cmp    %esi,%ebx
8010166d:	74 15                	je     80101684 <iput+0xa4>
    if(ip->addrs[i]){
8010166f:	8b 13                	mov    (%ebx),%edx
80101671:	85 d2                	test   %edx,%edx
80101673:	74 f3                	je     80101668 <iput+0x88>
      bfree(ip->dev, ip->addrs[i]);
80101675:	8b 07                	mov    (%edi),%eax
80101677:	e8 f4 fb ff ff       	call   80101270 <bfree>
      ip->addrs[i] = 0;
8010167c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80101682:	eb e4                	jmp    80101668 <iput+0x88>
80101684:	8b 75 e4             	mov    -0x1c(%ebp),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101687:	8b 87 8c 00 00 00    	mov    0x8c(%edi),%eax
8010168d:	85 c0                	test   %eax,%eax
8010168f:	75 2f                	jne    801016c0 <iput+0xe0>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
80101691:	c7 47 58 00 00 00 00 	movl   $0x0,0x58(%edi)
  iupdate(ip);
80101698:	83 ec 0c             	sub    $0xc,%esp
8010169b:	57                   	push   %edi
8010169c:	e8 8b fd ff ff       	call   8010142c <iupdate>
    int r = ip->ref;
    release(&icache.lock);
    if(r == 1){
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
      ip->type = 0;
801016a1:	66 c7 47 50 00 00    	movw   $0x0,0x50(%edi)
      iupdate(ip);
801016a7:	89 3c 24             	mov    %edi,(%esp)
801016aa:	e8 7d fd ff ff       	call   8010142c <iupdate>
      ip->valid = 0;
801016af:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
801016b6:	83 c4 10             	add    $0x10,%esp
801016b9:	e9 48 ff ff ff       	jmp    80101606 <iput+0x26>
801016be:	66 90                	xchg   %ax,%ax
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801016c0:	83 ec 08             	sub    $0x8,%esp
801016c3:	50                   	push   %eax
801016c4:	ff 37                	pushl  (%edi)
801016c6:	e8 e9 e9 ff ff       	call   801000b4 <bread>
801016cb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801016ce:	8d 58 5c             	lea    0x5c(%eax),%ebx
801016d1:	05 5c 02 00 00       	add    $0x25c,%eax
801016d6:	83 c4 10             	add    $0x10,%esp
801016d9:	89 75 e0             	mov    %esi,-0x20(%ebp)
801016dc:	89 de                	mov    %ebx,%esi
801016de:	89 c3                	mov    %eax,%ebx
801016e0:	eb 09                	jmp    801016eb <iput+0x10b>
801016e2:	66 90                	xchg   %ax,%ax
801016e4:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
801016e7:	39 de                	cmp    %ebx,%esi
801016e9:	74 0f                	je     801016fa <iput+0x11a>
      if(a[j])
801016eb:	8b 16                	mov    (%esi),%edx
801016ed:	85 d2                	test   %edx,%edx
801016ef:	74 f3                	je     801016e4 <iput+0x104>
        bfree(ip->dev, a[j]);
801016f1:	8b 07                	mov    (%edi),%eax
801016f3:	e8 78 fb ff ff       	call   80101270 <bfree>
801016f8:	eb ea                	jmp    801016e4 <iput+0x104>
801016fa:	8b 75 e0             	mov    -0x20(%ebp),%esi
    }
    brelse(bp);
801016fd:	83 ec 0c             	sub    $0xc,%esp
80101700:	ff 75 e4             	pushl  -0x1c(%ebp)
80101703:	e8 b0 ea ff ff       	call   801001b8 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101708:	8b 97 8c 00 00 00    	mov    0x8c(%edi),%edx
8010170e:	8b 07                	mov    (%edi),%eax
80101710:	e8 5b fb ff ff       	call   80101270 <bfree>
    ip->addrs[NDIRECT] = 0;
80101715:	c7 87 8c 00 00 00 00 	movl   $0x0,0x8c(%edi)
8010171c:	00 00 00 
8010171f:	83 c4 10             	add    $0x10,%esp
80101722:	e9 6a ff ff ff       	jmp    80101691 <iput+0xb1>
80101727:	90                   	nop

80101728 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101728:	55                   	push   %ebp
80101729:	89 e5                	mov    %esp,%ebp
8010172b:	53                   	push   %ebx
8010172c:	83 ec 10             	sub    $0x10,%esp
8010172f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101732:	53                   	push   %ebx
80101733:	e8 64 fe ff ff       	call   8010159c <iunlock>
  iput(ip);
80101738:	83 c4 10             	add    $0x10,%esp
8010173b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010173e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101741:	c9                   	leave  
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
80101742:	e9 99 fe ff ff       	jmp    801015e0 <iput>
80101747:	90                   	nop

80101748 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101748:	55                   	push   %ebp
80101749:	89 e5                	mov    %esp,%ebp
8010174b:	8b 55 08             	mov    0x8(%ebp),%edx
8010174e:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101751:	8b 0a                	mov    (%edx),%ecx
80101753:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101756:	8b 4a 04             	mov    0x4(%edx),%ecx
80101759:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
8010175c:	8b 4a 50             	mov    0x50(%edx),%ecx
8010175f:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101762:	66 8b 4a 56          	mov    0x56(%edx),%cx
80101766:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
8010176a:	8b 52 58             	mov    0x58(%edx),%edx
8010176d:	89 50 10             	mov    %edx,0x10(%eax)
}
80101770:	5d                   	pop    %ebp
80101771:	c3                   	ret    
80101772:	66 90                	xchg   %ax,%ax

80101774 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101774:	55                   	push   %ebp
80101775:	89 e5                	mov    %esp,%ebp
80101777:	57                   	push   %edi
80101778:	56                   	push   %esi
80101779:	53                   	push   %ebx
8010177a:	83 ec 1c             	sub    $0x1c,%esp
8010177d:	8b 45 08             	mov    0x8(%ebp),%eax
80101780:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101783:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101786:	8b 75 10             	mov    0x10(%ebp),%esi
80101789:	8b 4d 14             	mov    0x14(%ebp),%ecx
8010178c:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
8010178f:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
80101794:	0f 84 b2 00 00 00    	je     8010184c <readi+0xd8>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
8010179a:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010179d:	8b 40 58             	mov    0x58(%eax),%eax
801017a0:	39 f0                	cmp    %esi,%eax
801017a2:	0f 82 c8 00 00 00    	jb     80101870 <readi+0xfc>
801017a8:	8b 55 e0             	mov    -0x20(%ebp),%edx
801017ab:	01 f2                	add    %esi,%edx
801017ad:	0f 82 bd 00 00 00    	jb     80101870 <readi+0xfc>
    return -1;
  if(off + n > ip->size)
801017b3:	39 d0                	cmp    %edx,%eax
801017b5:	0f 82 85 00 00 00    	jb     80101840 <readi+0xcc>
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801017bb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801017c2:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801017c5:	85 db                	test   %ebx,%ebx
801017c7:	74 69                	je     80101832 <readi+0xbe>
801017c9:	8d 76 00             	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801017cc:	89 f2                	mov    %esi,%edx
801017ce:	c1 ea 09             	shr    $0x9,%edx
801017d1:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801017d4:	89 d8                	mov    %ebx,%eax
801017d6:	e8 a9 f9 ff ff       	call   80101184 <bmap>
801017db:	83 ec 08             	sub    $0x8,%esp
801017de:	50                   	push   %eax
801017df:	ff 33                	pushl  (%ebx)
801017e1:	e8 ce e8 ff ff       	call   801000b4 <bread>
801017e6:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801017e8:	89 f0                	mov    %esi,%eax
801017ea:	25 ff 01 00 00       	and    $0x1ff,%eax
801017ef:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801017f2:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
801017f5:	bb 00 02 00 00       	mov    $0x200,%ebx
801017fa:	29 c3                	sub    %eax,%ebx
801017fc:	83 c4 10             	add    $0x10,%esp
801017ff:	39 cb                	cmp    %ecx,%ebx
80101801:	76 02                	jbe    80101805 <readi+0x91>
80101803:	89 cb                	mov    %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101805:	51                   	push   %ecx
80101806:	53                   	push   %ebx
80101807:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
8010180b:	89 55 dc             	mov    %edx,-0x24(%ebp)
8010180e:	50                   	push   %eax
8010180f:	57                   	push   %edi
80101810:	e8 17 26 00 00       	call   80103e2c <memmove>
    brelse(bp);
80101815:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101818:	89 14 24             	mov    %edx,(%esp)
8010181b:	e8 98 e9 ff ff       	call   801001b8 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101820:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101823:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101826:	01 de                	add    %ebx,%esi
80101828:	01 df                	add    %ebx,%edi
8010182a:	83 c4 10             	add    $0x10,%esp
8010182d:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101830:	77 9a                	ja     801017cc <readi+0x58>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101832:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101835:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101838:	5b                   	pop    %ebx
80101839:	5e                   	pop    %esi
8010183a:	5f                   	pop    %edi
8010183b:	5d                   	pop    %ebp
8010183c:	c3                   	ret    
8010183d:	8d 76 00             	lea    0x0(%esi),%esi
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101840:	29 f0                	sub    %esi,%eax
80101842:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101845:	e9 71 ff ff ff       	jmp    801017bb <readi+0x47>
8010184a:	66 90                	xchg   %ax,%ax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
8010184c:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101850:	66 83 f8 09          	cmp    $0x9,%ax
80101854:	77 1a                	ja     80101870 <readi+0xfc>
80101856:	8b 04 c5 60 f9 10 80 	mov    -0x7fef06a0(,%eax,8),%eax
8010185d:	85 c0                	test   %eax,%eax
8010185f:	74 0f                	je     80101870 <readi+0xfc>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101861:	89 4d 10             	mov    %ecx,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
80101864:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101867:	5b                   	pop    %ebx
80101868:	5e                   	pop    %esi
80101869:	5f                   	pop    %edi
8010186a:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
8010186b:	ff e0                	jmp    *%eax
8010186d:	8d 76 00             	lea    0x0(%esi),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101870:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101875:	eb be                	jmp    80101835 <readi+0xc1>
80101877:	90                   	nop

80101878 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101878:	55                   	push   %ebp
80101879:	89 e5                	mov    %esp,%ebp
8010187b:	57                   	push   %edi
8010187c:	56                   	push   %esi
8010187d:	53                   	push   %ebx
8010187e:	83 ec 1c             	sub    $0x1c,%esp
80101881:	8b 45 08             	mov    0x8(%ebp),%eax
80101884:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101887:	8b 75 0c             	mov    0xc(%ebp),%esi
8010188a:	89 75 dc             	mov    %esi,-0x24(%ebp)
8010188d:	8b 75 10             	mov    0x10(%ebp),%esi
80101890:	8b 55 14             	mov    0x14(%ebp),%edx
80101893:	89 55 e0             	mov    %edx,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101896:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
8010189b:	0f 84 af 00 00 00    	je     80101950 <writei+0xd8>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
801018a1:	8b 45 d8             	mov    -0x28(%ebp),%eax
801018a4:	39 70 58             	cmp    %esi,0x58(%eax)
801018a7:	0f 82 db 00 00 00    	jb     80101988 <writei+0x110>
801018ad:	8b 55 e0             	mov    -0x20(%ebp),%edx
801018b0:	89 d0                	mov    %edx,%eax
801018b2:	01 f0                	add    %esi,%eax
801018b4:	0f 82 ce 00 00 00    	jb     80101988 <writei+0x110>
    return -1;
  if(off + n > MAXFILE*BSIZE)
801018ba:	3d 00 18 01 00       	cmp    $0x11800,%eax
801018bf:	0f 87 c3 00 00 00    	ja     80101988 <writei+0x110>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801018c5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801018cc:	85 d2                	test   %edx,%edx
801018ce:	74 73                	je     80101943 <writei+0xcb>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801018d0:	89 f2                	mov    %esi,%edx
801018d2:	c1 ea 09             	shr    $0x9,%edx
801018d5:	8b 7d d8             	mov    -0x28(%ebp),%edi
801018d8:	89 f8                	mov    %edi,%eax
801018da:	e8 a5 f8 ff ff       	call   80101184 <bmap>
801018df:	83 ec 08             	sub    $0x8,%esp
801018e2:	50                   	push   %eax
801018e3:	ff 37                	pushl  (%edi)
801018e5:	e8 ca e7 ff ff       	call   801000b4 <bread>
801018ea:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
801018ec:	89 f0                	mov    %esi,%eax
801018ee:	25 ff 01 00 00       	and    $0x1ff,%eax
801018f3:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801018f6:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
801018f9:	bb 00 02 00 00       	mov    $0x200,%ebx
801018fe:	29 c3                	sub    %eax,%ebx
80101900:	83 c4 10             	add    $0x10,%esp
80101903:	39 cb                	cmp    %ecx,%ebx
80101905:	76 02                	jbe    80101909 <writei+0x91>
80101907:	89 cb                	mov    %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101909:	52                   	push   %edx
8010190a:	53                   	push   %ebx
8010190b:	ff 75 dc             	pushl  -0x24(%ebp)
8010190e:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
80101912:	50                   	push   %eax
80101913:	e8 14 25 00 00       	call   80103e2c <memmove>
    log_write(bp);
80101918:	89 3c 24             	mov    %edi,(%esp)
8010191b:	e8 04 10 00 00       	call   80102924 <log_write>
    brelse(bp);
80101920:	89 3c 24             	mov    %edi,(%esp)
80101923:	e8 90 e8 ff ff       	call   801001b8 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101928:	01 5d e4             	add    %ebx,-0x1c(%ebp)
8010192b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010192e:	01 de                	add    %ebx,%esi
80101930:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101933:	83 c4 10             	add    $0x10,%esp
80101936:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101939:	77 95                	ja     801018d0 <writei+0x58>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
8010193b:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010193e:	39 70 58             	cmp    %esi,0x58(%eax)
80101941:	72 31                	jb     80101974 <writei+0xfc>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101943:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101946:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101949:	5b                   	pop    %ebx
8010194a:	5e                   	pop    %esi
8010194b:	5f                   	pop    %edi
8010194c:	5d                   	pop    %ebp
8010194d:	c3                   	ret    
8010194e:	66 90                	xchg   %ax,%ax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101950:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101954:	66 83 f8 09          	cmp    $0x9,%ax
80101958:	77 2e                	ja     80101988 <writei+0x110>
8010195a:	8b 04 c5 64 f9 10 80 	mov    -0x7fef069c(,%eax,8),%eax
80101961:	85 c0                	test   %eax,%eax
80101963:	74 23                	je     80101988 <writei+0x110>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101965:	89 55 10             	mov    %edx,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101968:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010196b:	5b                   	pop    %ebx
8010196c:	5e                   	pop    %esi
8010196d:	5f                   	pop    %edi
8010196e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
8010196f:	ff e0                	jmp    *%eax
80101971:	8d 76 00             	lea    0x0(%esi),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101974:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101977:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
8010197a:	83 ec 0c             	sub    $0xc,%esp
8010197d:	50                   	push   %eax
8010197e:	e8 a9 fa ff ff       	call   8010142c <iupdate>
80101983:	83 c4 10             	add    $0x10,%esp
80101986:	eb bb                	jmp    80101943 <writei+0xcb>
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101988:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
8010198d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101990:	5b                   	pop    %ebx
80101991:	5e                   	pop    %esi
80101992:	5f                   	pop    %edi
80101993:	5d                   	pop    %ebp
80101994:	c3                   	ret    
80101995:	8d 76 00             	lea    0x0(%esi),%esi

80101998 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101998:	55                   	push   %ebp
80101999:	89 e5                	mov    %esp,%ebp
8010199b:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
8010199e:	6a 0e                	push   $0xe
801019a0:	ff 75 0c             	pushl  0xc(%ebp)
801019a3:	ff 75 08             	pushl  0x8(%ebp)
801019a6:	e8 e1 24 00 00       	call   80103e8c <strncmp>
}
801019ab:	c9                   	leave  
801019ac:	c3                   	ret    
801019ad:	8d 76 00             	lea    0x0(%esi),%esi

801019b0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
801019b0:	55                   	push   %ebp
801019b1:	89 e5                	mov    %esp,%ebp
801019b3:	57                   	push   %edi
801019b4:	56                   	push   %esi
801019b5:	53                   	push   %ebx
801019b6:	83 ec 1c             	sub    $0x1c,%esp
801019b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
801019bc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801019c1:	0f 85 80 00 00 00    	jne    80101a47 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
801019c7:	8b 4b 58             	mov    0x58(%ebx),%ecx
801019ca:	85 c9                	test   %ecx,%ecx
801019cc:	74 62                	je     80101a30 <dirlookup+0x80>
801019ce:	31 ff                	xor    %edi,%edi
801019d0:	8d 75 d8             	lea    -0x28(%ebp),%esi
801019d3:	eb 0b                	jmp    801019e0 <dirlookup+0x30>
801019d5:	8d 76 00             	lea    0x0(%esi),%esi
801019d8:	83 c7 10             	add    $0x10,%edi
801019db:	39 7b 58             	cmp    %edi,0x58(%ebx)
801019de:	76 50                	jbe    80101a30 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801019e0:	6a 10                	push   $0x10
801019e2:	57                   	push   %edi
801019e3:	56                   	push   %esi
801019e4:	53                   	push   %ebx
801019e5:	e8 8a fd ff ff       	call   80101774 <readi>
801019ea:	83 c4 10             	add    $0x10,%esp
801019ed:	83 f8 10             	cmp    $0x10,%eax
801019f0:	75 48                	jne    80101a3a <dirlookup+0x8a>
      panic("dirlookup read");
    if(de.inum == 0)
801019f2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801019f7:	74 df                	je     801019d8 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
801019f9:	52                   	push   %edx
801019fa:	6a 0e                	push   $0xe
801019fc:	8d 45 da             	lea    -0x26(%ebp),%eax
801019ff:	50                   	push   %eax
80101a00:	ff 75 0c             	pushl  0xc(%ebp)
80101a03:	e8 84 24 00 00       	call   80103e8c <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101a08:	83 c4 10             	add    $0x10,%esp
80101a0b:	85 c0                	test   %eax,%eax
80101a0d:	75 c9                	jne    801019d8 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101a0f:	8b 45 10             	mov    0x10(%ebp),%eax
80101a12:	85 c0                	test   %eax,%eax
80101a14:	74 05                	je     80101a1b <dirlookup+0x6b>
        *poff = off;
80101a16:	8b 45 10             	mov    0x10(%ebp),%eax
80101a19:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101a1b:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101a1f:	8b 03                	mov    (%ebx),%eax
80101a21:	e8 9e f6 ff ff       	call   801010c4 <iget>
    }
  }

  return 0;
}
80101a26:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a29:	5b                   	pop    %ebx
80101a2a:	5e                   	pop    %esi
80101a2b:	5f                   	pop    %edi
80101a2c:	5d                   	pop    %ebp
80101a2d:	c3                   	ret    
80101a2e:	66 90                	xchg   %ax,%ax
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101a30:	31 c0                	xor    %eax,%eax
}
80101a32:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a35:	5b                   	pop    %ebx
80101a36:	5e                   	pop    %esi
80101a37:	5f                   	pop    %edi
80101a38:	5d                   	pop    %ebp
80101a39:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
80101a3a:	83 ec 0c             	sub    $0xc,%esp
80101a3d:	68 b9 65 10 80       	push   $0x801065b9
80101a42:	e8 f1 e8 ff ff       	call   80100338 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101a47:	83 ec 0c             	sub    $0xc,%esp
80101a4a:	68 a7 65 10 80       	push   $0x801065a7
80101a4f:	e8 e4 e8 ff ff       	call   80100338 <panic>

80101a54 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101a54:	55                   	push   %ebp
80101a55:	89 e5                	mov    %esp,%ebp
80101a57:	57                   	push   %edi
80101a58:	56                   	push   %esi
80101a59:	53                   	push   %ebx
80101a5a:	83 ec 1c             	sub    $0x1c,%esp
80101a5d:	89 c3                	mov    %eax,%ebx
80101a5f:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101a62:	89 ce                	mov    %ecx,%esi
  struct inode *ip, *next;

  if(*path == '/')
80101a64:	80 38 2f             	cmpb   $0x2f,(%eax)
80101a67:	0f 84 57 01 00 00    	je     80101bc4 <namex+0x170>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101a6d:	e8 56 18 00 00       	call   801032c8 <myproc>
80101a72:	8b 78 68             	mov    0x68(%eax),%edi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101a75:	83 ec 0c             	sub    $0xc,%esp
80101a78:	68 e0 f9 10 80       	push   $0x8010f9e0
80101a7d:	e8 f6 21 00 00       	call   80103c78 <acquire>
  ip->ref++;
80101a82:	ff 47 08             	incl   0x8(%edi)
  release(&icache.lock);
80101a85:	c7 04 24 e0 f9 10 80 	movl   $0x8010f9e0,(%esp)
80101a8c:	e8 bb 22 00 00       	call   80103d4c <release>
80101a91:	83 c4 10             	add    $0x10,%esp
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101a94:	8a 03                	mov    (%ebx),%al
80101a96:	3c 2f                	cmp    $0x2f,%al
80101a98:	75 09                	jne    80101aa3 <namex+0x4f>
80101a9a:	66 90                	xchg   %ax,%ax
    path++;
80101a9c:	43                   	inc    %ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101a9d:	8a 03                	mov    (%ebx),%al
80101a9f:	3c 2f                	cmp    $0x2f,%al
80101aa1:	74 f9                	je     80101a9c <namex+0x48>
    path++;
  if(*path == 0)
80101aa3:	84 c0                	test   %al,%al
80101aa5:	0f 84 ea 00 00 00    	je     80101b95 <namex+0x141>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101aab:	89 da                	mov    %ebx,%edx
80101aad:	80 3b 00             	cmpb   $0x0,(%ebx)
80101ab0:	0f 85 92 00 00 00    	jne    80101b48 <namex+0xf4>
80101ab6:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80101ab9:	31 c9                	xor    %ecx,%ecx
80101abb:	90                   	nop
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101abc:	52                   	push   %edx
80101abd:	51                   	push   %ecx
80101abe:	89 4d dc             	mov    %ecx,-0x24(%ebp)
80101ac1:	53                   	push   %ebx
80101ac2:	56                   	push   %esi
80101ac3:	e8 64 23 00 00       	call   80103e2c <memmove>
    name[len] = 0;
80101ac8:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80101acb:	c6 04 0e 00          	movb   $0x0,(%esi,%ecx,1)
80101acf:	83 c4 10             	add    $0x10,%esp
80101ad2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  }
  while(*path == '/')
80101ad5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101ad8:	80 38 2f             	cmpb   $0x2f,(%eax)
80101adb:	0f 84 9f 00 00 00    	je     80101b80 <namex+0x12c>
80101ae1:	8d 76 00             	lea    0x0(%esi),%esi
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101ae4:	83 ec 0c             	sub    $0xc,%esp
80101ae7:	57                   	push   %edi
80101ae8:	e8 e7 f9 ff ff       	call   801014d4 <ilock>
    if(ip->type != T_DIR){
80101aed:	83 c4 10             	add    $0x10,%esp
80101af0:	66 83 7f 50 01       	cmpw   $0x1,0x50(%edi)
80101af5:	0f 85 ab 00 00 00    	jne    80101ba6 <namex+0x152>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101afb:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101afe:	85 c0                	test   %eax,%eax
80101b00:	74 09                	je     80101b0b <namex+0xb7>
80101b02:	80 3b 00             	cmpb   $0x0,(%ebx)
80101b05:	0f 84 cf 00 00 00    	je     80101bda <namex+0x186>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101b0b:	50                   	push   %eax
80101b0c:	6a 00                	push   $0x0
80101b0e:	56                   	push   %esi
80101b0f:	57                   	push   %edi
80101b10:	e8 9b fe ff ff       	call   801019b0 <dirlookup>
80101b15:	83 c4 10             	add    $0x10,%esp
80101b18:	85 c0                	test   %eax,%eax
80101b1a:	0f 84 86 00 00 00    	je     80101ba6 <namex+0x152>
80101b20:	89 45 e4             	mov    %eax,-0x1c(%ebp)

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101b23:	83 ec 0c             	sub    $0xc,%esp
80101b26:	57                   	push   %edi
80101b27:	e8 70 fa ff ff       	call   8010159c <iunlock>
  iput(ip);
80101b2c:	89 3c 24             	mov    %edi,(%esp)
80101b2f:	e8 ac fa ff ff       	call   801015e0 <iput>
80101b34:	83 c4 10             	add    $0x10,%esp
80101b37:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b3a:	89 c7                	mov    %eax,%edi
80101b3c:	e9 53 ff ff ff       	jmp    80101a94 <namex+0x40>
80101b41:	8d 76 00             	lea    0x0(%esi),%esi
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101b44:	84 c0                	test   %al,%al
80101b46:	74 44                	je     80101b8c <namex+0x138>
    path++;
80101b48:	42                   	inc    %edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101b49:	8a 02                	mov    (%edx),%al
80101b4b:	3c 2f                	cmp    $0x2f,%al
80101b4d:	75 f5                	jne    80101b44 <namex+0xf0>
80101b4f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101b52:	89 d1                	mov    %edx,%ecx
80101b54:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101b56:	83 f9 0d             	cmp    $0xd,%ecx
80101b59:	0f 8e 5d ff ff ff    	jle    80101abc <namex+0x68>
80101b5f:	89 55 dc             	mov    %edx,-0x24(%ebp)
    memmove(name, s, DIRSIZ);
80101b62:	51                   	push   %ecx
80101b63:	6a 0e                	push   $0xe
80101b65:	53                   	push   %ebx
80101b66:	56                   	push   %esi
80101b67:	e8 c0 22 00 00       	call   80103e2c <memmove>
80101b6c:	83 c4 10             	add    $0x10,%esp
80101b6f:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101b72:	89 d3                	mov    %edx,%ebx
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101b74:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b77:	80 38 2f             	cmpb   $0x2f,(%eax)
80101b7a:	0f 85 64 ff ff ff    	jne    80101ae4 <namex+0x90>
    path++;
80101b80:	43                   	inc    %ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101b81:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101b84:	74 fa                	je     80101b80 <namex+0x12c>
80101b86:	e9 59 ff ff ff       	jmp    80101ae4 <namex+0x90>
80101b8b:	90                   	nop
80101b8c:	89 d1                	mov    %edx,%ecx
80101b8e:	29 d9                	sub    %ebx,%ecx
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101b90:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101b93:	eb c1                	jmp    80101b56 <namex+0x102>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101b95:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101b98:	85 c0                	test   %eax,%eax
80101b9a:	75 54                	jne    80101bf0 <namex+0x19c>
80101b9c:	89 f8                	mov    %edi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101b9e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ba1:	5b                   	pop    %ebx
80101ba2:	5e                   	pop    %esi
80101ba3:	5f                   	pop    %edi
80101ba4:	5d                   	pop    %ebp
80101ba5:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101ba6:	83 ec 0c             	sub    $0xc,%esp
80101ba9:	57                   	push   %edi
80101baa:	e8 ed f9 ff ff       	call   8010159c <iunlock>
  iput(ip);
80101baf:	89 3c 24             	mov    %edi,(%esp)
80101bb2:	e8 29 fa ff ff       	call   801015e0 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101bb7:	83 c4 10             	add    $0x10,%esp
80101bba:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101bbc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bbf:	5b                   	pop    %ebx
80101bc0:	5e                   	pop    %esi
80101bc1:	5f                   	pop    %edi
80101bc2:	5d                   	pop    %ebp
80101bc3:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101bc4:	ba 01 00 00 00       	mov    $0x1,%edx
80101bc9:	b8 01 00 00 00       	mov    $0x1,%eax
80101bce:	e8 f1 f4 ff ff       	call   801010c4 <iget>
80101bd3:	89 c7                	mov    %eax,%edi
80101bd5:	e9 ba fe ff ff       	jmp    80101a94 <namex+0x40>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101bda:	83 ec 0c             	sub    $0xc,%esp
80101bdd:	57                   	push   %edi
80101bde:	e8 b9 f9 ff ff       	call   8010159c <iunlock>
      return ip;
80101be3:	83 c4 10             	add    $0x10,%esp
80101be6:	89 f8                	mov    %edi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101be8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101beb:	5b                   	pop    %ebx
80101bec:	5e                   	pop    %esi
80101bed:	5f                   	pop    %edi
80101bee:	5d                   	pop    %ebp
80101bef:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101bf0:	83 ec 0c             	sub    $0xc,%esp
80101bf3:	57                   	push   %edi
80101bf4:	e8 e7 f9 ff ff       	call   801015e0 <iput>
    return 0;
80101bf9:	83 c4 10             	add    $0x10,%esp
80101bfc:	31 c0                	xor    %eax,%eax
80101bfe:	eb 9e                	jmp    80101b9e <namex+0x14a>

80101c00 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101c00:	55                   	push   %ebp
80101c01:	89 e5                	mov    %esp,%ebp
80101c03:	57                   	push   %edi
80101c04:	56                   	push   %esi
80101c05:	53                   	push   %ebx
80101c06:	83 ec 20             	sub    $0x20,%esp
80101c09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101c0c:	6a 00                	push   $0x0
80101c0e:	ff 75 0c             	pushl  0xc(%ebp)
80101c11:	53                   	push   %ebx
80101c12:	e8 99 fd ff ff       	call   801019b0 <dirlookup>
80101c17:	83 c4 10             	add    $0x10,%esp
80101c1a:	85 c0                	test   %eax,%eax
80101c1c:	75 67                	jne    80101c85 <dirlink+0x85>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101c1e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101c21:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101c24:	85 ff                	test   %edi,%edi
80101c26:	74 2b                	je     80101c53 <dirlink+0x53>
80101c28:	31 ff                	xor    %edi,%edi
80101c2a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101c2d:	eb 0b                	jmp    80101c3a <dirlink+0x3a>
80101c2f:	90                   	nop
80101c30:	8d 57 10             	lea    0x10(%edi),%edx
80101c33:	89 d7                	mov    %edx,%edi
80101c35:	39 53 58             	cmp    %edx,0x58(%ebx)
80101c38:	76 19                	jbe    80101c53 <dirlink+0x53>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101c3a:	6a 10                	push   $0x10
80101c3c:	57                   	push   %edi
80101c3d:	56                   	push   %esi
80101c3e:	53                   	push   %ebx
80101c3f:	e8 30 fb ff ff       	call   80101774 <readi>
80101c44:	83 c4 10             	add    $0x10,%esp
80101c47:	83 f8 10             	cmp    $0x10,%eax
80101c4a:	75 4c                	jne    80101c98 <dirlink+0x98>
      panic("dirlink read");
    if(de.inum == 0)
80101c4c:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101c51:	75 dd                	jne    80101c30 <dirlink+0x30>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101c53:	50                   	push   %eax
80101c54:	6a 0e                	push   $0xe
80101c56:	ff 75 0c             	pushl  0xc(%ebp)
80101c59:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c5c:	50                   	push   %eax
80101c5d:	e8 86 22 00 00       	call   80103ee8 <strncpy>
  de.inum = inum;
80101c62:	8b 45 10             	mov    0x10(%ebp),%eax
80101c65:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101c69:	6a 10                	push   $0x10
80101c6b:	57                   	push   %edi
80101c6c:	56                   	push   %esi
80101c6d:	53                   	push   %ebx
80101c6e:	e8 05 fc ff ff       	call   80101878 <writei>
80101c73:	83 c4 20             	add    $0x20,%esp
80101c76:	83 f8 10             	cmp    $0x10,%eax
80101c79:	75 2a                	jne    80101ca5 <dirlink+0xa5>
    panic("dirlink");

  return 0;
80101c7b:	31 c0                	xor    %eax,%eax
}
80101c7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c80:	5b                   	pop    %ebx
80101c81:	5e                   	pop    %esi
80101c82:	5f                   	pop    %edi
80101c83:	5d                   	pop    %ebp
80101c84:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80101c85:	83 ec 0c             	sub    $0xc,%esp
80101c88:	50                   	push   %eax
80101c89:	e8 52 f9 ff ff       	call   801015e0 <iput>
    return -1;
80101c8e:	83 c4 10             	add    $0x10,%esp
80101c91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c96:	eb e5                	jmp    80101c7d <dirlink+0x7d>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101c98:	83 ec 0c             	sub    $0xc,%esp
80101c9b:	68 c8 65 10 80       	push   $0x801065c8
80101ca0:	e8 93 e6 ff ff       	call   80100338 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101ca5:	83 ec 0c             	sub    $0xc,%esp
80101ca8:	68 e2 6b 10 80       	push   $0x80106be2
80101cad:	e8 86 e6 ff ff       	call   80100338 <panic>
80101cb2:	66 90                	xchg   %ax,%ax

80101cb4 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80101cb4:	55                   	push   %ebp
80101cb5:	89 e5                	mov    %esp,%ebp
80101cb7:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101cba:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101cbd:	31 d2                	xor    %edx,%edx
80101cbf:	8b 45 08             	mov    0x8(%ebp),%eax
80101cc2:	e8 8d fd ff ff       	call   80101a54 <namex>
}
80101cc7:	c9                   	leave  
80101cc8:	c3                   	ret    
80101cc9:	8d 76 00             	lea    0x0(%esi),%esi

80101ccc <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101ccc:	55                   	push   %ebp
80101ccd:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101ccf:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101cd2:	ba 01 00 00 00       	mov    $0x1,%edx
80101cd7:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101cda:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
80101cdb:	e9 74 fd ff ff       	jmp    80101a54 <namex>

80101ce0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101ce0:	55                   	push   %ebp
80101ce1:	89 e5                	mov    %esp,%ebp
80101ce3:	56                   	push   %esi
80101ce4:	53                   	push   %ebx
80101ce5:	89 c1                	mov    %eax,%ecx
  if(b == 0)
80101ce7:	85 c0                	test   %eax,%eax
80101ce9:	0f 84 8a 00 00 00    	je     80101d79 <idestart+0x99>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101cef:	8b 58 08             	mov    0x8(%eax),%ebx
80101cf2:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101cf8:	77 72                	ja     80101d6c <idestart+0x8c>
80101cfa:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101cff:	90                   	nop
80101d00:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101d01:	83 e0 c0             	and    $0xffffffc0,%eax
80101d04:	3c 40                	cmp    $0x40,%al
80101d06:	75 f8                	jne    80101d00 <idestart+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101d08:	31 f6                	xor    %esi,%esi
80101d0a:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101d0f:	89 f0                	mov    %esi,%eax
80101d11:	ee                   	out    %al,(%dx)
80101d12:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101d17:	b0 01                	mov    $0x1,%al
80101d19:	ee                   	out    %al,(%dx)
80101d1a:	b2 f3                	mov    $0xf3,%dl
80101d1c:	88 d8                	mov    %bl,%al
80101d1e:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101d1f:	89 d8                	mov    %ebx,%eax
80101d21:	c1 f8 08             	sar    $0x8,%eax
80101d24:	b2 f4                	mov    $0xf4,%dl
80101d26:	ee                   	out    %al,(%dx)
80101d27:	b2 f5                	mov    $0xf5,%dl
80101d29:	89 f0                	mov    %esi,%eax
80101d2b:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101d2c:	8a 41 04             	mov    0x4(%ecx),%al
80101d2f:	83 e0 01             	and    $0x1,%eax
80101d32:	c1 e0 04             	shl    $0x4,%eax
80101d35:	83 c8 e0             	or     $0xffffffe0,%eax
80101d38:	b2 f6                	mov    $0xf6,%dl
80101d3a:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101d3b:	f6 01 04             	testb  $0x4,(%ecx)
80101d3e:	75 10                	jne    80101d50 <idestart+0x70>
80101d40:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101d45:	b0 20                	mov    $0x20,%al
80101d47:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101d48:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101d4b:	5b                   	pop    %ebx
80101d4c:	5e                   	pop    %esi
80101d4d:	5d                   	pop    %ebp
80101d4e:	c3                   	ret    
80101d4f:	90                   	nop
80101d50:	b2 f7                	mov    $0xf7,%dl
80101d52:	b0 30                	mov    $0x30,%al
80101d54:	ee                   	out    %al,(%dx)
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
80101d55:	8d 71 5c             	lea    0x5c(%ecx),%esi
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80101d58:	b9 80 00 00 00       	mov    $0x80,%ecx
80101d5d:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101d62:	fc                   	cld    
80101d63:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101d65:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101d68:	5b                   	pop    %ebx
80101d69:	5e                   	pop    %esi
80101d6a:	5d                   	pop    %ebp
80101d6b:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
80101d6c:	83 ec 0c             	sub    $0xc,%esp
80101d6f:	68 34 66 10 80       	push   $0x80106634
80101d74:	e8 bf e5 ff ff       	call   80100338 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
80101d79:	83 ec 0c             	sub    $0xc,%esp
80101d7c:	68 2b 66 10 80       	push   $0x8010662b
80101d81:	e8 b2 e5 ff ff       	call   80100338 <panic>
80101d86:	66 90                	xchg   %ax,%ax

80101d88 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80101d88:	55                   	push   %ebp
80101d89:	89 e5                	mov    %esp,%ebp
80101d8b:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&idelock, "ide");
80101d8e:	68 46 66 10 80       	push   $0x80106646
80101d93:	68 80 95 10 80       	push   $0x80109580
80101d98:	e8 17 1e 00 00       	call   80103bb4 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80101d9d:	58                   	pop    %eax
80101d9e:	5a                   	pop    %edx
80101d9f:	a1 00 1d 11 80       	mov    0x80111d00,%eax
80101da4:	48                   	dec    %eax
80101da5:	50                   	push   %eax
80101da6:	6a 0e                	push   $0xe
80101da8:	e8 63 02 00 00       	call   80102010 <ioapicenable>
80101dad:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101db0:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101db5:	8d 76 00             	lea    0x0(%esi),%esi
80101db8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101db9:	83 e0 c0             	and    $0xffffffc0,%eax
80101dbc:	3c 40                	cmp    $0x40,%al
80101dbe:	75 f8                	jne    80101db8 <ideinit+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101dc0:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101dc5:	b0 f0                	mov    $0xf0,%al
80101dc7:	ee                   	out    %al,(%dx)
80101dc8:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101dcd:	b2 f7                	mov    $0xf7,%dl
80101dcf:	eb 06                	jmp    80101dd7 <ideinit+0x4f>
80101dd1:	8d 76 00             	lea    0x0(%esi),%esi
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80101dd4:	49                   	dec    %ecx
80101dd5:	74 0f                	je     80101de6 <ideinit+0x5e>
80101dd7:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80101dd8:	84 c0                	test   %al,%al
80101dda:	74 f8                	je     80101dd4 <ideinit+0x4c>
      havedisk1 = 1;
80101ddc:	c7 05 60 95 10 80 01 	movl   $0x1,0x80109560
80101de3:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101de6:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101deb:	b0 e0                	mov    $0xe0,%al
80101ded:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
80101dee:	c9                   	leave  
80101def:	c3                   	ret    

80101df0 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80101df0:	55                   	push   %ebp
80101df1:	89 e5                	mov    %esp,%ebp
80101df3:	57                   	push   %edi
80101df4:	56                   	push   %esi
80101df5:	53                   	push   %ebx
80101df6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80101df9:	68 80 95 10 80       	push   $0x80109580
80101dfe:	e8 75 1e 00 00       	call   80103c78 <acquire>

  if((b = idequeue) == 0){
80101e03:	8b 1d 64 95 10 80    	mov    0x80109564,%ebx
80101e09:	83 c4 10             	add    $0x10,%esp
80101e0c:	85 db                	test   %ebx,%ebx
80101e0e:	74 34                	je     80101e44 <ideintr+0x54>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80101e10:	8b 43 58             	mov    0x58(%ebx),%eax
80101e13:	a3 64 95 10 80       	mov    %eax,0x80109564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80101e18:	8b 33                	mov    (%ebx),%esi
80101e1a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80101e20:	74 3a                	je     80101e5c <ideintr+0x6c>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80101e22:	83 e6 fb             	and    $0xfffffffb,%esi
80101e25:	83 ce 02             	or     $0x2,%esi
80101e28:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
80101e2a:	83 ec 0c             	sub    $0xc,%esp
80101e2d:	53                   	push   %ebx
80101e2e:	e8 15 1b 00 00       	call   80103948 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80101e33:	a1 64 95 10 80       	mov    0x80109564,%eax
80101e38:	83 c4 10             	add    $0x10,%esp
80101e3b:	85 c0                	test   %eax,%eax
80101e3d:	74 05                	je     80101e44 <ideintr+0x54>
    idestart(idequeue);
80101e3f:	e8 9c fe ff ff       	call   80101ce0 <idestart>

  // First queued buffer is the active request.
  acquire(&idelock);

  if((b = idequeue) == 0){
    release(&idelock);
80101e44:	83 ec 0c             	sub    $0xc,%esp
80101e47:	68 80 95 10 80       	push   $0x80109580
80101e4c:	e8 fb 1e 00 00       	call   80103d4c <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
80101e51:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e54:	5b                   	pop    %ebx
80101e55:	5e                   	pop    %esi
80101e56:	5f                   	pop    %edi
80101e57:	5d                   	pop    %ebp
80101e58:	c3                   	ret    
80101e59:	8d 76 00             	lea    0x0(%esi),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101e5c:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101e61:	8d 76 00             	lea    0x0(%esi),%esi
80101e64:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101e65:	88 c1                	mov    %al,%cl
80101e67:	83 e1 c0             	and    $0xffffffc0,%ecx
80101e6a:	80 f9 40             	cmp    $0x40,%cl
80101e6d:	75 f5                	jne    80101e64 <ideintr+0x74>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80101e6f:	a8 21                	test   $0x21,%al
80101e71:	75 af                	jne    80101e22 <ideintr+0x32>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
80101e73:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
80101e76:	b9 80 00 00 00       	mov    $0x80,%ecx
80101e7b:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101e80:	fc                   	cld    
80101e81:	f3 6d                	rep insl (%dx),%es:(%edi)
80101e83:	8b 33                	mov    (%ebx),%esi
80101e85:	eb 9b                	jmp    80101e22 <ideintr+0x32>
80101e87:	90                   	nop

80101e88 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80101e88:	55                   	push   %ebp
80101e89:	89 e5                	mov    %esp,%ebp
80101e8b:	53                   	push   %ebx
80101e8c:	83 ec 10             	sub    $0x10,%esp
80101e8f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
80101e92:	8d 43 0c             	lea    0xc(%ebx),%eax
80101e95:	50                   	push   %eax
80101e96:	e8 f1 1c 00 00       	call   80103b8c <holdingsleep>
80101e9b:	83 c4 10             	add    $0x10,%esp
80101e9e:	85 c0                	test   %eax,%eax
80101ea0:	0f 84 a1 00 00 00    	je     80101f47 <iderw+0xbf>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80101ea6:	8b 03                	mov    (%ebx),%eax
80101ea8:	83 e0 06             	and    $0x6,%eax
80101eab:	83 f8 02             	cmp    $0x2,%eax
80101eae:	0f 84 ad 00 00 00    	je     80101f61 <iderw+0xd9>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
80101eb4:	8b 53 04             	mov    0x4(%ebx),%edx
80101eb7:	85 d2                	test   %edx,%edx
80101eb9:	74 0d                	je     80101ec8 <iderw+0x40>
80101ebb:	a1 60 95 10 80       	mov    0x80109560,%eax
80101ec0:	85 c0                	test   %eax,%eax
80101ec2:	0f 84 8c 00 00 00    	je     80101f54 <iderw+0xcc>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80101ec8:	83 ec 0c             	sub    $0xc,%esp
80101ecb:	68 80 95 10 80       	push   $0x80109580
80101ed0:	e8 a3 1d 00 00       	call   80103c78 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
80101ed5:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80101edc:	a1 64 95 10 80       	mov    0x80109564,%eax
80101ee1:	83 c4 10             	add    $0x10,%esp
80101ee4:	85 c0                	test   %eax,%eax
80101ee6:	75 06                	jne    80101eee <iderw+0x66>
80101ee8:	eb 4d                	jmp    80101f37 <iderw+0xaf>
80101eea:	66 90                	xchg   %ax,%ax
80101eec:	89 d0                	mov    %edx,%eax
80101eee:	8b 50 58             	mov    0x58(%eax),%edx
80101ef1:	85 d2                	test   %edx,%edx
80101ef3:	75 f7                	jne    80101eec <iderw+0x64>
80101ef5:	83 c0 58             	add    $0x58,%eax
    ;
  *pp = b;
80101ef8:	89 18                	mov    %ebx,(%eax)

  // Start disk if necessary.
  if(idequeue == b)
80101efa:	39 1d 64 95 10 80    	cmp    %ebx,0x80109564
80101f00:	74 3c                	je     80101f3e <iderw+0xb6>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80101f02:	8b 03                	mov    (%ebx),%eax
80101f04:	83 e0 06             	and    $0x6,%eax
80101f07:	83 f8 02             	cmp    $0x2,%eax
80101f0a:	74 1b                	je     80101f27 <iderw+0x9f>
    sleep(b, &idelock);
80101f0c:	83 ec 08             	sub    $0x8,%esp
80101f0f:	68 80 95 10 80       	push   $0x80109580
80101f14:	53                   	push   %ebx
80101f15:	e8 a2 18 00 00       	call   801037bc <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80101f1a:	8b 13                	mov    (%ebx),%edx
80101f1c:	83 e2 06             	and    $0x6,%edx
80101f1f:	83 c4 10             	add    $0x10,%esp
80101f22:	83 fa 02             	cmp    $0x2,%edx
80101f25:	75 e5                	jne    80101f0c <iderw+0x84>
    sleep(b, &idelock);
  }


  release(&idelock);
80101f27:	c7 45 08 80 95 10 80 	movl   $0x80109580,0x8(%ebp)
}
80101f2e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101f31:	c9                   	leave  
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
80101f32:	e9 15 1e 00 00       	jmp    80103d4c <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80101f37:	b8 64 95 10 80       	mov    $0x80109564,%eax
80101f3c:	eb ba                	jmp    80101ef8 <iderw+0x70>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
80101f3e:	89 d8                	mov    %ebx,%eax
80101f40:	e8 9b fd ff ff       	call   80101ce0 <idestart>
80101f45:	eb bb                	jmp    80101f02 <iderw+0x7a>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
80101f47:	83 ec 0c             	sub    $0xc,%esp
80101f4a:	68 4a 66 10 80       	push   $0x8010664a
80101f4f:	e8 e4 e3 ff ff       	call   80100338 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
80101f54:	83 ec 0c             	sub    $0xc,%esp
80101f57:	68 75 66 10 80       	push   $0x80106675
80101f5c:	e8 d7 e3 ff ff       	call   80100338 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
80101f61:	83 ec 0c             	sub    $0xc,%esp
80101f64:	68 60 66 10 80       	push   $0x80106660
80101f69:	e8 ca e3 ff ff       	call   80100338 <panic>
80101f6e:	66 90                	xchg   %ax,%ax

80101f70 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80101f70:	55                   	push   %ebp
80101f71:	89 e5                	mov    %esp,%ebp
80101f73:	56                   	push   %esi
80101f74:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80101f75:	c7 05 34 16 11 80 00 	movl   $0xfec00000,0x80111634
80101f7c:	00 c0 fe 
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80101f7f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80101f86:	00 00 00 
  return ioapic->data;
80101f89:	8b 15 34 16 11 80    	mov    0x80111634,%edx
80101f8f:	8b 72 10             	mov    0x10(%edx),%esi
ioapicinit(void)
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80101f92:	89 f0                	mov    %esi,%eax
80101f94:	c1 e8 10             	shr    $0x10,%eax
80101f97:	0f b6 f0             	movzbl %al,%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80101f9a:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80101fa0:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
80101fa6:	8b 41 10             	mov    0x10(%ecx),%eax
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80101fa9:	0f b6 15 60 17 11 80 	movzbl 0x80111760,%edx
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
80101fb0:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80101fb3:	39 c2                	cmp    %eax,%edx
80101fb5:	74 16                	je     80101fcd <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80101fb7:	83 ec 0c             	sub    $0xc,%esp
80101fba:	68 94 66 10 80       	push   $0x80106694
80101fbf:	e8 44 e6 ff ff       	call   80100608 <cprintf>
80101fc4:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
80101fca:	83 c4 10             	add    $0x10,%esp
80101fcd:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
80101fd0:	ba 10 00 00 00       	mov    $0x10,%edx
80101fd5:	b8 20 00 00 00       	mov    $0x20,%eax
80101fda:	66 90                	xchg   %ax,%ax
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80101fdc:	89 c3                	mov    %eax,%ebx
80101fde:	81 cb 00 00 01 00    	or     $0x10000,%ebx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80101fe4:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80101fe6:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
80101fec:	89 59 10             	mov    %ebx,0x10(%ecx)
80101fef:	8d 5a 01             	lea    0x1(%edx),%ebx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80101ff2:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80101ff4:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
80101ffa:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
80102001:	40                   	inc    %eax
80102002:	83 c2 02             	add    $0x2,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102005:	39 f0                	cmp    %esi,%eax
80102007:	75 d3                	jne    80101fdc <ioapicinit+0x6c>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102009:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010200c:	5b                   	pop    %ebx
8010200d:	5e                   	pop    %esi
8010200e:	5d                   	pop    %ebp
8010200f:	c3                   	ret    

80102010 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102010:	55                   	push   %ebp
80102011:	89 e5                	mov    %esp,%ebp
80102013:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102016:	8d 50 20             	lea    0x20(%eax),%edx
80102019:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010201d:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
80102023:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102025:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
8010202b:	89 51 10             	mov    %edx,0x10(%ecx)
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010202e:	8b 55 0c             	mov    0xc(%ebp),%edx
80102031:	c1 e2 18             	shl    $0x18,%edx
80102034:	40                   	inc    %eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102035:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102037:	a1 34 16 11 80       	mov    0x80111634,%eax
8010203c:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
8010203f:	5d                   	pop    %ebp
80102040:	c3                   	ret    
80102041:	66 90                	xchg   %ax,%ax
80102043:	90                   	nop

80102044 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102044:	55                   	push   %ebp
80102045:	89 e5                	mov    %esp,%ebp
80102047:	53                   	push   %ebx
80102048:	53                   	push   %ebx
80102049:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010204c:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102052:	75 6e                	jne    801020c2 <kfree+0x7e>
80102054:	81 fb a8 44 11 80    	cmp    $0x801144a8,%ebx
8010205a:	72 66                	jb     801020c2 <kfree+0x7e>
8010205c:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102062:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102067:	77 59                	ja     801020c2 <kfree+0x7e>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102069:	52                   	push   %edx
8010206a:	68 00 10 00 00       	push   $0x1000
8010206f:	6a 01                	push   $0x1
80102071:	53                   	push   %ebx
80102072:	e8 21 1d 00 00       	call   80103d98 <memset>

  if(kmem.use_lock)
80102077:	83 c4 10             	add    $0x10,%esp
8010207a:	8b 0d 74 16 11 80    	mov    0x80111674,%ecx
80102080:	85 c9                	test   %ecx,%ecx
80102082:	75 2c                	jne    801020b0 <kfree+0x6c>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102084:	a1 78 16 11 80       	mov    0x80111678,%eax
80102089:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
8010208b:	89 1d 78 16 11 80    	mov    %ebx,0x80111678
  if(kmem.use_lock)
80102091:	a1 74 16 11 80       	mov    0x80111674,%eax
80102096:	85 c0                	test   %eax,%eax
80102098:	75 06                	jne    801020a0 <kfree+0x5c>
    release(&kmem.lock);
}
8010209a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010209d:	c9                   	leave  
8010209e:	c3                   	ret    
8010209f:	90                   	nop
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
801020a0:	c7 45 08 40 16 11 80 	movl   $0x80111640,0x8(%ebp)
}
801020a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801020aa:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
801020ab:	e9 9c 1c 00 00       	jmp    80103d4c <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
801020b0:	83 ec 0c             	sub    $0xc,%esp
801020b3:	68 40 16 11 80       	push   $0x80111640
801020b8:	e8 bb 1b 00 00       	call   80103c78 <acquire>
801020bd:	83 c4 10             	add    $0x10,%esp
801020c0:	eb c2                	jmp    80102084 <kfree+0x40>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
801020c2:	83 ec 0c             	sub    $0xc,%esp
801020c5:	68 c6 66 10 80       	push   $0x801066c6
801020ca:	e8 69 e2 ff ff       	call   80100338 <panic>
801020cf:	90                   	nop

801020d0 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
801020d0:	55                   	push   %ebp
801020d1:	89 e5                	mov    %esp,%ebp
801020d3:	56                   	push   %esi
801020d4:	53                   	push   %ebx
801020d5:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801020d8:	8b 45 08             	mov    0x8(%ebp),%eax
801020db:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801020e1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801020e7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801020ed:	39 de                	cmp    %ebx,%esi
801020ef:	72 1f                	jb     80102110 <freerange+0x40>
801020f1:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
801020f4:	83 ec 0c             	sub    $0xc,%esp
801020f7:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801020fd:	50                   	push   %eax
801020fe:	e8 41 ff ff ff       	call   80102044 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102103:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102109:	83 c4 10             	add    $0x10,%esp
8010210c:	39 f3                	cmp    %esi,%ebx
8010210e:	76 e4                	jbe    801020f4 <freerange+0x24>
    kfree(p);
}
80102110:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102113:	5b                   	pop    %ebx
80102114:	5e                   	pop    %esi
80102115:	5d                   	pop    %ebp
80102116:	c3                   	ret    
80102117:	90                   	nop

80102118 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102118:	55                   	push   %ebp
80102119:	89 e5                	mov    %esp,%ebp
8010211b:	56                   	push   %esi
8010211c:	53                   	push   %ebx
8010211d:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102120:	83 ec 08             	sub    $0x8,%esp
80102123:	68 cc 66 10 80       	push   $0x801066cc
80102128:	68 40 16 11 80       	push   $0x80111640
8010212d:	e8 82 1a 00 00       	call   80103bb4 <initlock>
  kmem.use_lock = 0;
80102132:	c7 05 74 16 11 80 00 	movl   $0x0,0x80111674
80102139:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010213c:	8b 45 08             	mov    0x8(%ebp),%eax
8010213f:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102145:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010214b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102151:	83 c4 10             	add    $0x10,%esp
80102154:	39 de                	cmp    %ebx,%esi
80102156:	72 1c                	jb     80102174 <kinit1+0x5c>
    kfree(p);
80102158:	83 ec 0c             	sub    $0xc,%esp
8010215b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102161:	50                   	push   %eax
80102162:	e8 dd fe ff ff       	call   80102044 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102167:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010216d:	83 c4 10             	add    $0x10,%esp
80102170:	39 de                	cmp    %ebx,%esi
80102172:	73 e4                	jae    80102158 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
80102174:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102177:	5b                   	pop    %ebx
80102178:	5e                   	pop    %esi
80102179:	5d                   	pop    %ebp
8010217a:	c3                   	ret    
8010217b:	90                   	nop

8010217c <kinit2>:

void
kinit2(void *vstart, void *vend)
{
8010217c:	55                   	push   %ebp
8010217d:	89 e5                	mov    %esp,%ebp
8010217f:	56                   	push   %esi
80102180:	53                   	push   %ebx
80102181:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102184:	8b 45 08             	mov    0x8(%ebp),%eax
80102187:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
8010218d:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102193:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102199:	39 de                	cmp    %ebx,%esi
8010219b:	72 1f                	jb     801021bc <kinit2+0x40>
8010219d:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
801021a0:	83 ec 0c             	sub    $0xc,%esp
801021a3:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801021a9:	50                   	push   %eax
801021aa:	e8 95 fe ff ff       	call   80102044 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801021af:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801021b5:	83 c4 10             	add    $0x10,%esp
801021b8:	39 de                	cmp    %ebx,%esi
801021ba:	73 e4                	jae    801021a0 <kinit2+0x24>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
801021bc:	c7 05 74 16 11 80 01 	movl   $0x1,0x80111674
801021c3:	00 00 00 
}
801021c6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801021c9:	5b                   	pop    %ebx
801021ca:	5e                   	pop    %esi
801021cb:	5d                   	pop    %ebp
801021cc:	c3                   	ret    
801021cd:	8d 76 00             	lea    0x0(%esi),%esi

801021d0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
801021d0:	55                   	push   %ebp
801021d1:	89 e5                	mov    %esp,%ebp
801021d3:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
801021d6:	8b 15 74 16 11 80    	mov    0x80111674,%edx
801021dc:	85 d2                	test   %edx,%edx
801021de:	75 30                	jne    80102210 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
801021e0:	a1 78 16 11 80       	mov    0x80111678,%eax
  if(r)
801021e5:	85 c0                	test   %eax,%eax
801021e7:	74 0c                	je     801021f5 <kalloc+0x25>
    kmem.freelist = r->next;
801021e9:	8b 08                	mov    (%eax),%ecx
801021eb:	89 0d 78 16 11 80    	mov    %ecx,0x80111678
  if(kmem.use_lock)
801021f1:	85 d2                	test   %edx,%edx
801021f3:	75 03                	jne    801021f8 <kalloc+0x28>
    release(&kmem.lock);
  return (char*)r;
}
801021f5:	c9                   	leave  
801021f6:	c3                   	ret    
801021f7:	90                   	nop
801021f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    acquire(&kmem.lock);
  r = kmem.freelist;
  if(r)
    kmem.freelist = r->next;
  if(kmem.use_lock)
    release(&kmem.lock);
801021fb:	83 ec 0c             	sub    $0xc,%esp
801021fe:	68 40 16 11 80       	push   $0x80111640
80102203:	e8 44 1b 00 00       	call   80103d4c <release>
80102208:	83 c4 10             	add    $0x10,%esp
8010220b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  return (char*)r;
}
8010220e:	c9                   	leave  
8010220f:	c3                   	ret    
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102210:	83 ec 0c             	sub    $0xc,%esp
80102213:	68 40 16 11 80       	push   $0x80111640
80102218:	e8 5b 1a 00 00       	call   80103c78 <acquire>
  r = kmem.freelist;
8010221d:	a1 78 16 11 80       	mov    0x80111678,%eax
  if(r)
80102222:	83 c4 10             	add    $0x10,%esp
80102225:	8b 15 74 16 11 80    	mov    0x80111674,%edx
8010222b:	85 c0                	test   %eax,%eax
8010222d:	75 ba                	jne    801021e9 <kalloc+0x19>
8010222f:	eb c0                	jmp    801021f1 <kalloc+0x21>
80102231:	66 90                	xchg   %ax,%ax
80102233:	90                   	nop

80102234 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102234:	55                   	push   %ebp
80102235:	89 e5                	mov    %esp,%ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102237:	ba 64 00 00 00       	mov    $0x64,%edx
8010223c:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
8010223d:	a8 01                	test   $0x1,%al
8010223f:	0f 84 9f 00 00 00    	je     801022e4 <kbdgetc+0xb0>
80102245:	b2 60                	mov    $0x60,%dl
80102247:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102248:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
8010224b:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102251:	74 75                	je     801022c8 <kbdgetc+0x94>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102253:	8b 0d b4 95 10 80    	mov    0x801095b4,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102259:	84 c0                	test   %al,%al
8010225b:	79 23                	jns    80102280 <kbdgetc+0x4c>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
8010225d:	f6 c1 40             	test   $0x40,%cl
80102260:	75 05                	jne    80102267 <kbdgetc+0x33>
80102262:	89 c2                	mov    %eax,%edx
80102264:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102267:	8a 82 00 68 10 80    	mov    -0x7fef9800(%edx),%al
8010226d:	83 c8 40             	or     $0x40,%eax
80102270:	0f b6 c0             	movzbl %al,%eax
80102273:	f7 d0                	not    %eax
80102275:	21 c8                	and    %ecx,%eax
80102277:	a3 b4 95 10 80       	mov    %eax,0x801095b4
    return 0;
8010227c:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010227e:	5d                   	pop    %ebp
8010227f:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102280:	f6 c1 40             	test   $0x40,%cl
80102283:	74 09                	je     8010228e <kbdgetc+0x5a>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102285:	83 c8 80             	or     $0xffffff80,%eax
80102288:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
8010228b:	83 e1 bf             	and    $0xffffffbf,%ecx
  }

  shift |= shiftcode[data];
8010228e:	0f b6 82 00 68 10 80 	movzbl -0x7fef9800(%edx),%eax
80102295:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
80102297:	0f b6 82 00 67 10 80 	movzbl -0x7fef9900(%edx),%eax
8010229e:	31 c1                	xor    %eax,%ecx
801022a0:	89 0d b4 95 10 80    	mov    %ecx,0x801095b4
  c = charcode[shift & (CTL | SHIFT)][data];
801022a6:	89 c8                	mov    %ecx,%eax
801022a8:	83 e0 03             	and    $0x3,%eax
801022ab:	8b 04 85 e0 66 10 80 	mov    -0x7fef9920(,%eax,4),%eax
801022b2:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801022b6:	83 e1 08             	and    $0x8,%ecx
801022b9:	74 c3                	je     8010227e <kbdgetc+0x4a>
    if('a' <= c && c <= 'z')
801022bb:	8d 50 9f             	lea    -0x61(%eax),%edx
801022be:	83 fa 19             	cmp    $0x19,%edx
801022c1:	77 11                	ja     801022d4 <kbdgetc+0xa0>
      c += 'A' - 'a';
801022c3:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801022c6:	5d                   	pop    %ebp
801022c7:	c3                   	ret    
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
801022c8:	83 0d b4 95 10 80 40 	orl    $0x40,0x801095b4
    return 0;
801022cf:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801022d1:	5d                   	pop    %ebp
801022d2:	c3                   	ret    
801022d3:	90                   	nop
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
801022d4:	8d 50 bf             	lea    -0x41(%eax),%edx
801022d7:	83 fa 19             	cmp    $0x19,%edx
801022da:	77 a2                	ja     8010227e <kbdgetc+0x4a>
      c += 'a' - 'A';
801022dc:	83 c0 20             	add    $0x20,%eax
  }
  return c;
}
801022df:	5d                   	pop    %ebp
801022e0:	c3                   	ret    
801022e1:	8d 76 00             	lea    0x0(%esi),%esi
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
801022e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801022e9:	5d                   	pop    %ebp
801022ea:	c3                   	ret    
801022eb:	90                   	nop

801022ec <kbdintr>:

void
kbdintr(void)
{
801022ec:	55                   	push   %ebp
801022ed:	89 e5                	mov    %esp,%ebp
801022ef:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801022f2:	68 34 22 10 80       	push   $0x80102234
801022f7:	e8 58 e4 ff ff       	call   80100754 <consoleintr>
801022fc:	83 c4 10             	add    $0x10,%esp
}
801022ff:	c9                   	leave  
80102300:	c3                   	ret    
80102301:	66 90                	xchg   %ax,%ax
80102303:	90                   	nop

80102304 <fill_rtcdate>:

  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
80102304:	55                   	push   %ebp
80102305:	89 e5                	mov    %esp,%ebp
80102307:	53                   	push   %ebx
80102308:	89 c3                	mov    %eax,%ebx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010230a:	ba 70 00 00 00       	mov    $0x70,%edx
8010230f:	31 c0                	xor    %eax,%eax
80102311:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102312:	b9 71 00 00 00       	mov    $0x71,%ecx
80102317:	89 ca                	mov    %ecx,%edx
80102319:	ec                   	in     (%dx),%al
static uint cmos_read(uint reg)
{
  outb(CMOS_PORT,  reg);
  microdelay(200);

  return inb(CMOS_RETURN);
8010231a:	0f b6 c0             	movzbl %al,%eax
8010231d:	89 03                	mov    %eax,(%ebx)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010231f:	b2 70                	mov    $0x70,%dl
80102321:	b0 02                	mov    $0x2,%al
80102323:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102324:	89 ca                	mov    %ecx,%edx
80102326:	ec                   	in     (%dx),%al
80102327:	0f b6 c0             	movzbl %al,%eax
8010232a:	89 43 04             	mov    %eax,0x4(%ebx)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010232d:	b2 70                	mov    $0x70,%dl
8010232f:	b0 04                	mov    $0x4,%al
80102331:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102332:	89 ca                	mov    %ecx,%edx
80102334:	ec                   	in     (%dx),%al
80102335:	0f b6 c0             	movzbl %al,%eax
80102338:	89 43 08             	mov    %eax,0x8(%ebx)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010233b:	b2 70                	mov    $0x70,%dl
8010233d:	b0 07                	mov    $0x7,%al
8010233f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102340:	89 ca                	mov    %ecx,%edx
80102342:	ec                   	in     (%dx),%al
80102343:	0f b6 c0             	movzbl %al,%eax
80102346:	89 43 0c             	mov    %eax,0xc(%ebx)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102349:	b2 70                	mov    $0x70,%dl
8010234b:	b0 08                	mov    $0x8,%al
8010234d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010234e:	89 ca                	mov    %ecx,%edx
80102350:	ec                   	in     (%dx),%al
80102351:	0f b6 c0             	movzbl %al,%eax
80102354:	89 43 10             	mov    %eax,0x10(%ebx)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102357:	b2 70                	mov    $0x70,%dl
80102359:	b0 09                	mov    $0x9,%al
8010235b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010235c:	89 ca                	mov    %ecx,%edx
8010235e:	ec                   	in     (%dx),%al
8010235f:	0f b6 c8             	movzbl %al,%ecx
80102362:	89 4b 14             	mov    %ecx,0x14(%ebx)
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
}
80102365:	5b                   	pop    %ebx
80102366:	5d                   	pop    %ebp
80102367:	c3                   	ret    

80102368 <lapicinit>:
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
80102368:	55                   	push   %ebp
80102369:	89 e5                	mov    %esp,%ebp
  if(!lapic)
8010236b:	a1 7c 16 11 80       	mov    0x8011167c,%eax
80102370:	85 c0                	test   %eax,%eax
80102372:	0f 84 c0 00 00 00    	je     80102438 <lapicinit+0xd0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102378:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
8010237f:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102382:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102385:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
8010238c:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010238f:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102392:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102399:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
8010239c:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010239f:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801023a6:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801023a9:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801023ac:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801023b3:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801023b6:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801023b9:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801023c0:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801023c3:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801023c6:	8b 50 30             	mov    0x30(%eax),%edx
801023c9:	c1 ea 10             	shr    $0x10,%edx
801023cc:	80 fa 03             	cmp    $0x3,%dl
801023cf:	77 6b                	ja     8010243c <lapicinit+0xd4>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801023d1:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801023d8:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801023db:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801023de:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801023e5:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801023e8:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801023eb:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801023f2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801023f5:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801023f8:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801023ff:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102402:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102405:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
8010240c:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010240f:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102412:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102419:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
8010241c:	8b 50 20             	mov    0x20(%eax),%edx
8010241f:	90                   	nop
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102420:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102426:	80 e6 10             	and    $0x10,%dh
80102429:	75 f5                	jne    80102420 <lapicinit+0xb8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010242b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102432:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102435:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102438:	5d                   	pop    %ebp
80102439:	c3                   	ret    
8010243a:	66 90                	xchg   %ax,%ax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010243c:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102443:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102446:	8b 50 20             	mov    0x20(%eax),%edx
80102449:	eb 86                	jmp    801023d1 <lapicinit+0x69>
8010244b:	90                   	nop

8010244c <lapicid>:
  lapicw(TPR, 0);
}

int
lapicid(void)
{
8010244c:	55                   	push   %ebp
8010244d:	89 e5                	mov    %esp,%ebp
  if (!lapic)
8010244f:	a1 7c 16 11 80       	mov    0x8011167c,%eax
80102454:	85 c0                	test   %eax,%eax
80102456:	74 08                	je     80102460 <lapicid+0x14>
    return 0;
  return lapic[ID] >> 24;
80102458:	8b 40 20             	mov    0x20(%eax),%eax
8010245b:	c1 e8 18             	shr    $0x18,%eax
}
8010245e:	5d                   	pop    %ebp
8010245f:	c3                   	ret    

int
lapicid(void)
{
  if (!lapic)
    return 0;
80102460:	31 c0                	xor    %eax,%eax
  return lapic[ID] >> 24;
}
80102462:	5d                   	pop    %ebp
80102463:	c3                   	ret    

80102464 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102464:	55                   	push   %ebp
80102465:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102467:	a1 7c 16 11 80       	mov    0x8011167c,%eax
8010246c:	85 c0                	test   %eax,%eax
8010246e:	74 0d                	je     8010247d <lapiceoi+0x19>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102470:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102477:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010247a:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
8010247d:	5d                   	pop    %ebp
8010247e:	c3                   	ret    
8010247f:	90                   	nop

80102480 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102480:	55                   	push   %ebp
80102481:	89 e5                	mov    %esp,%ebp
}
80102483:	5d                   	pop    %ebp
80102484:	c3                   	ret    
80102485:	8d 76 00             	lea    0x0(%esi),%esi

80102488 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102488:	55                   	push   %ebp
80102489:	89 e5                	mov    %esp,%ebp
8010248b:	53                   	push   %ebx
8010248c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010248f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102492:	ba 70 00 00 00       	mov    $0x70,%edx
80102497:	b0 0f                	mov    $0xf,%al
80102499:	ee                   	out    %al,(%dx)
8010249a:	b2 71                	mov    $0x71,%dl
8010249c:	b0 0a                	mov    $0xa,%al
8010249e:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
8010249f:	66 c7 05 67 04 00 80 	movw   $0x0,0x80000467
801024a6:	00 00 
  wrv[1] = addr >> 4;
801024a8:	89 c8                	mov    %ecx,%eax
801024aa:	c1 e8 04             	shr    $0x4,%eax
801024ad:	66 a3 69 04 00 80    	mov    %ax,0x80000469

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801024b3:	a1 7c 16 11 80       	mov    0x8011167c,%eax
  wrv[0] = 0;
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801024b8:	c1 e3 18             	shl    $0x18,%ebx
801024bb:	89 da                	mov    %ebx,%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801024bd:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801024c3:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801024c6:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801024cd:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801024d0:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801024d3:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801024da:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801024dd:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801024e0:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801024e6:	8b 58 20             	mov    0x20(%eax),%ebx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801024e9:	c1 e9 0c             	shr    $0xc,%ecx
801024ec:	80 cd 06             	or     $0x6,%ch

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801024ef:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801024f5:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801024f8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801024fe:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102501:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102507:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
8010250a:	5b                   	pop    %ebx
8010250b:	5d                   	pop    %ebp
8010250c:	c3                   	ret    
8010250d:	8d 76 00             	lea    0x0(%esi),%esi

80102510 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80102510:	55                   	push   %ebp
80102511:	89 e5                	mov    %esp,%ebp
80102513:	57                   	push   %edi
80102514:	56                   	push   %esi
80102515:	53                   	push   %ebx
80102516:	83 ec 4c             	sub    $0x4c,%esp
80102519:	ba 70 00 00 00       	mov    $0x70,%edx
8010251e:	b0 0b                	mov    $0xb,%al
80102520:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102521:	b2 71                	mov    $0x71,%dl
80102523:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102524:	83 e0 04             	and    $0x4,%eax
80102527:	88 45 b7             	mov    %al,-0x49(%ebp)
8010252a:	8d 75 b8             	lea    -0x48(%ebp),%esi
8010252d:	8d 7d d0             	lea    -0x30(%ebp),%edi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102530:	bb 70 00 00 00       	mov    $0x70,%ebx

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
80102535:	89 f0                	mov    %esi,%eax
80102537:	e8 c8 fd ff ff       	call   80102304 <fill_rtcdate>
8010253c:	b0 0a                	mov    $0xa,%al
8010253e:	89 da                	mov    %ebx,%edx
80102540:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102541:	ba 71 00 00 00       	mov    $0x71,%edx
80102546:	ec                   	in     (%dx),%al
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102547:	84 c0                	test   %al,%al
80102549:	78 ea                	js     80102535 <cmostime+0x25>
        continue;
    fill_rtcdate(&t2);
8010254b:	89 f8                	mov    %edi,%eax
8010254d:	e8 b2 fd ff ff       	call   80102304 <fill_rtcdate>
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102552:	50                   	push   %eax
80102553:	6a 18                	push   $0x18
80102555:	57                   	push   %edi
80102556:	56                   	push   %esi
80102557:	e8 88 18 00 00       	call   80103de4 <memcmp>
8010255c:	83 c4 10             	add    $0x10,%esp
8010255f:	85 c0                	test   %eax,%eax
80102561:	75 cd                	jne    80102530 <cmostime+0x20>
      break;
  }

  // convert
  if(bcd) {
80102563:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
80102567:	75 78                	jne    801025e1 <cmostime+0xd1>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102569:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010256c:	89 c2                	mov    %eax,%edx
8010256e:	c1 ea 04             	shr    $0x4,%edx
80102571:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102574:	83 e0 0f             	and    $0xf,%eax
80102577:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010257a:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
8010257d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102580:	89 c2                	mov    %eax,%edx
80102582:	c1 ea 04             	shr    $0x4,%edx
80102585:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102588:	83 e0 0f             	and    $0xf,%eax
8010258b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010258e:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102591:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102594:	89 c2                	mov    %eax,%edx
80102596:	c1 ea 04             	shr    $0x4,%edx
80102599:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010259c:	83 e0 0f             	and    $0xf,%eax
8010259f:	8d 04 50             	lea    (%eax,%edx,2),%eax
801025a2:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
801025a5:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801025a8:	89 c2                	mov    %eax,%edx
801025aa:	c1 ea 04             	shr    $0x4,%edx
801025ad:	8d 14 92             	lea    (%edx,%edx,4),%edx
801025b0:	83 e0 0f             	and    $0xf,%eax
801025b3:	8d 04 50             	lea    (%eax,%edx,2),%eax
801025b6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
801025b9:	8b 45 c8             	mov    -0x38(%ebp),%eax
801025bc:	89 c2                	mov    %eax,%edx
801025be:	c1 ea 04             	shr    $0x4,%edx
801025c1:	8d 14 92             	lea    (%edx,%edx,4),%edx
801025c4:	83 e0 0f             	and    $0xf,%eax
801025c7:	8d 04 50             	lea    (%eax,%edx,2),%eax
801025ca:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801025cd:	8b 45 cc             	mov    -0x34(%ebp),%eax
801025d0:	89 c2                	mov    %eax,%edx
801025d2:	c1 ea 04             	shr    $0x4,%edx
801025d5:	8d 14 92             	lea    (%edx,%edx,4),%edx
801025d8:	83 e0 0f             	and    $0xf,%eax
801025db:	8d 04 50             	lea    (%eax,%edx,2),%eax
801025de:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801025e1:	b9 06 00 00 00       	mov    $0x6,%ecx
801025e6:	8b 7d 08             	mov    0x8(%ebp),%edi
801025e9:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  r->year += 2000;
801025eb:	8b 45 08             	mov    0x8(%ebp),%eax
801025ee:	81 40 14 d0 07 00 00 	addl   $0x7d0,0x14(%eax)
}
801025f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801025f8:	5b                   	pop    %ebx
801025f9:	5e                   	pop    %esi
801025fa:	5f                   	pop    %edi
801025fb:	5d                   	pop    %ebp
801025fc:	c3                   	ret    
801025fd:	66 90                	xchg   %ax,%ax
801025ff:	90                   	nop

80102600 <install_trans>:
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102600:	55                   	push   %ebp
80102601:	89 e5                	mov    %esp,%ebp
80102603:	57                   	push   %edi
80102604:	56                   	push   %esi
80102605:	53                   	push   %ebx
80102606:	83 ec 0c             	sub    $0xc,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102609:	31 db                	xor    %ebx,%ebx
8010260b:	8b 0d c8 16 11 80    	mov    0x801116c8,%ecx
80102611:	85 c9                	test   %ecx,%ecx
80102613:	7e 6b                	jle    80102680 <install_trans+0x80>
80102615:	8d 76 00             	lea    0x0(%esi),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102618:	83 ec 08             	sub    $0x8,%esp
8010261b:	a1 b4 16 11 80       	mov    0x801116b4,%eax
80102620:	01 d8                	add    %ebx,%eax
80102622:	40                   	inc    %eax
80102623:	50                   	push   %eax
80102624:	ff 35 c4 16 11 80    	pushl  0x801116c4
8010262a:	e8 85 da ff ff       	call   801000b4 <bread>
8010262f:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102631:	58                   	pop    %eax
80102632:	5a                   	pop    %edx
80102633:	ff 34 9d cc 16 11 80 	pushl  -0x7feee934(,%ebx,4)
8010263a:	ff 35 c4 16 11 80    	pushl  0x801116c4
80102640:	e8 6f da ff ff       	call   801000b4 <bread>
80102645:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102647:	83 c4 0c             	add    $0xc,%esp
8010264a:	68 00 02 00 00       	push   $0x200
8010264f:	8d 47 5c             	lea    0x5c(%edi),%eax
80102652:	50                   	push   %eax
80102653:	8d 46 5c             	lea    0x5c(%esi),%eax
80102656:	50                   	push   %eax
80102657:	e8 d0 17 00 00       	call   80103e2c <memmove>
    bwrite(dbuf);  // write dst to disk
8010265c:	89 34 24             	mov    %esi,(%esp)
8010265f:	e8 1c db ff ff       	call   80100180 <bwrite>
    brelse(lbuf);
80102664:	89 3c 24             	mov    %edi,(%esp)
80102667:	e8 4c db ff ff       	call   801001b8 <brelse>
    brelse(dbuf);
8010266c:	89 34 24             	mov    %esi,(%esp)
8010266f:	e8 44 db ff ff       	call   801001b8 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102674:	43                   	inc    %ebx
80102675:	83 c4 10             	add    $0x10,%esp
80102678:	39 1d c8 16 11 80    	cmp    %ebx,0x801116c8
8010267e:	7f 98                	jg     80102618 <install_trans+0x18>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102680:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102683:	5b                   	pop    %ebx
80102684:	5e                   	pop    %esi
80102685:	5f                   	pop    %edi
80102686:	5d                   	pop    %ebp
80102687:	c3                   	ret    

80102688 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102688:	55                   	push   %ebp
80102689:	89 e5                	mov    %esp,%ebp
8010268b:	53                   	push   %ebx
8010268c:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
8010268f:	ff 35 b4 16 11 80    	pushl  0x801116b4
80102695:	ff 35 c4 16 11 80    	pushl  0x801116c4
8010269b:	e8 14 da ff ff       	call   801000b4 <bread>
801026a0:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
801026a2:	a1 c8 16 11 80       	mov    0x801116c8,%eax
801026a7:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
801026aa:	83 c4 10             	add    $0x10,%esp
801026ad:	31 d2                	xor    %edx,%edx
801026af:	85 c0                	test   %eax,%eax
801026b1:	7e 11                	jle    801026c4 <write_head+0x3c>
801026b3:	90                   	nop
    hb->block[i] = log.lh.block[i];
801026b4:	8b 0c 95 cc 16 11 80 	mov    -0x7feee934(,%edx,4),%ecx
801026bb:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
801026bf:	42                   	inc    %edx
801026c0:	39 c2                	cmp    %eax,%edx
801026c2:	75 f0                	jne    801026b4 <write_head+0x2c>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
801026c4:	83 ec 0c             	sub    $0xc,%esp
801026c7:	53                   	push   %ebx
801026c8:	e8 b3 da ff ff       	call   80100180 <bwrite>
  brelse(buf);
801026cd:	89 1c 24             	mov    %ebx,(%esp)
801026d0:	e8 e3 da ff ff       	call   801001b8 <brelse>
}
801026d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026d8:	c9                   	leave  
801026d9:	c3                   	ret    
801026da:	66 90                	xchg   %ax,%ax

801026dc <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
801026dc:	55                   	push   %ebp
801026dd:	89 e5                	mov    %esp,%ebp
801026df:	53                   	push   %ebx
801026e0:	83 ec 2c             	sub    $0x2c,%esp
801026e3:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
801026e6:	68 00 69 10 80       	push   $0x80106900
801026eb:	68 80 16 11 80       	push   $0x80111680
801026f0:	e8 bf 14 00 00       	call   80103bb4 <initlock>
  readsb(dev, &sb);
801026f5:	58                   	pop    %eax
801026f6:	5a                   	pop    %edx
801026f7:	8d 45 dc             	lea    -0x24(%ebp),%eax
801026fa:	50                   	push   %eax
801026fb:	53                   	push   %ebx
801026fc:	e8 37 eb ff ff       	call   80101238 <readsb>
  log.start = sb.logstart;
80102701:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102704:	a3 b4 16 11 80       	mov    %eax,0x801116b4
  log.size = sb.nlog;
80102709:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010270c:	89 15 b8 16 11 80    	mov    %edx,0x801116b8
  log.dev = dev;
80102712:	89 1d c4 16 11 80    	mov    %ebx,0x801116c4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102718:	59                   	pop    %ecx
80102719:	5a                   	pop    %edx
8010271a:	50                   	push   %eax
8010271b:	53                   	push   %ebx
8010271c:	e8 93 d9 ff ff       	call   801000b4 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102721:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102724:	89 1d c8 16 11 80    	mov    %ebx,0x801116c8
  for (i = 0; i < log.lh.n; i++) {
8010272a:	83 c4 10             	add    $0x10,%esp
8010272d:	31 d2                	xor    %edx,%edx
8010272f:	85 db                	test   %ebx,%ebx
80102731:	7e 11                	jle    80102744 <initlog+0x68>
80102733:	90                   	nop
    log.lh.block[i] = lh->block[i];
80102734:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102738:	89 0c 95 cc 16 11 80 	mov    %ecx,-0x7feee934(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
8010273f:	42                   	inc    %edx
80102740:	39 da                	cmp    %ebx,%edx
80102742:	75 f0                	jne    80102734 <initlog+0x58>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102744:	83 ec 0c             	sub    $0xc,%esp
80102747:	50                   	push   %eax
80102748:	e8 6b da ff ff       	call   801001b8 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
8010274d:	e8 ae fe ff ff       	call   80102600 <install_trans>
  log.lh.n = 0;
80102752:	c7 05 c8 16 11 80 00 	movl   $0x0,0x801116c8
80102759:	00 00 00 
  write_head(); // clear the log
8010275c:	e8 27 ff ff ff       	call   80102688 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102761:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102764:	c9                   	leave  
80102765:	c3                   	ret    
80102766:	66 90                	xchg   %ax,%ax

80102768 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102768:	55                   	push   %ebp
80102769:	89 e5                	mov    %esp,%ebp
8010276b:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
8010276e:	68 80 16 11 80       	push   $0x80111680
80102773:	e8 00 15 00 00       	call   80103c78 <acquire>
80102778:	83 c4 10             	add    $0x10,%esp
8010277b:	eb 18                	jmp    80102795 <begin_op+0x2d>
8010277d:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102780:	83 ec 08             	sub    $0x8,%esp
80102783:	68 80 16 11 80       	push   $0x80111680
80102788:	68 80 16 11 80       	push   $0x80111680
8010278d:	e8 2a 10 00 00       	call   801037bc <sleep>
80102792:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102795:	a1 c0 16 11 80       	mov    0x801116c0,%eax
8010279a:	85 c0                	test   %eax,%eax
8010279c:	75 e2                	jne    80102780 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
8010279e:	a1 bc 16 11 80       	mov    0x801116bc,%eax
801027a3:	8d 50 01             	lea    0x1(%eax),%edx
801027a6:	8d 04 92             	lea    (%edx,%edx,4),%eax
801027a9:	01 c0                	add    %eax,%eax
801027ab:	03 05 c8 16 11 80    	add    0x801116c8,%eax
801027b1:	83 f8 1e             	cmp    $0x1e,%eax
801027b4:	7f ca                	jg     80102780 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
801027b6:	89 15 bc 16 11 80    	mov    %edx,0x801116bc
      release(&log.lock);
801027bc:	83 ec 0c             	sub    $0xc,%esp
801027bf:	68 80 16 11 80       	push   $0x80111680
801027c4:	e8 83 15 00 00       	call   80103d4c <release>
801027c9:	83 c4 10             	add    $0x10,%esp
      break;
    }
  }
}
801027cc:	c9                   	leave  
801027cd:	c3                   	ret    
801027ce:	66 90                	xchg   %ax,%ax

801027d0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
801027d0:	55                   	push   %ebp
801027d1:	89 e5                	mov    %esp,%ebp
801027d3:	57                   	push   %edi
801027d4:	56                   	push   %esi
801027d5:	53                   	push   %ebx
801027d6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
801027d9:	68 80 16 11 80       	push   $0x80111680
801027de:	e8 95 14 00 00       	call   80103c78 <acquire>
  log.outstanding -= 1;
801027e3:	a1 bc 16 11 80       	mov    0x801116bc,%eax
801027e8:	48                   	dec    %eax
801027e9:	a3 bc 16 11 80       	mov    %eax,0x801116bc
  if(log.committing)
801027ee:	83 c4 10             	add    $0x10,%esp
801027f1:	8b 1d c0 16 11 80    	mov    0x801116c0,%ebx
801027f7:	85 db                	test   %ebx,%ebx
801027f9:	0f 85 15 01 00 00    	jne    80102914 <end_op+0x144>
    panic("log.committing");
  if(log.outstanding == 0){
801027ff:	85 c0                	test   %eax,%eax
80102801:	0f 85 e9 00 00 00    	jne    801028f0 <end_op+0x120>
    do_commit = 1;
    log.committing = 1;
80102807:	c7 05 c0 16 11 80 01 	movl   $0x1,0x801116c0
8010280e:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102811:	83 ec 0c             	sub    $0xc,%esp
80102814:	68 80 16 11 80       	push   $0x80111680
80102819:	e8 2e 15 00 00       	call   80103d4c <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
8010281e:	83 c4 10             	add    $0x10,%esp
80102821:	8b 0d c8 16 11 80    	mov    0x801116c8,%ecx
80102827:	85 c9                	test   %ecx,%ecx
80102829:	0f 8e 86 00 00 00    	jle    801028b5 <end_op+0xe5>
8010282f:	31 db                	xor    %ebx,%ebx
80102831:	8d 76 00             	lea    0x0(%esi),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102834:	83 ec 08             	sub    $0x8,%esp
80102837:	a1 b4 16 11 80       	mov    0x801116b4,%eax
8010283c:	01 d8                	add    %ebx,%eax
8010283e:	40                   	inc    %eax
8010283f:	50                   	push   %eax
80102840:	ff 35 c4 16 11 80    	pushl  0x801116c4
80102846:	e8 69 d8 ff ff       	call   801000b4 <bread>
8010284b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010284d:	58                   	pop    %eax
8010284e:	5a                   	pop    %edx
8010284f:	ff 34 9d cc 16 11 80 	pushl  -0x7feee934(,%ebx,4)
80102856:	ff 35 c4 16 11 80    	pushl  0x801116c4
8010285c:	e8 53 d8 ff ff       	call   801000b4 <bread>
80102861:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102863:	83 c4 0c             	add    $0xc,%esp
80102866:	68 00 02 00 00       	push   $0x200
8010286b:	8d 40 5c             	lea    0x5c(%eax),%eax
8010286e:	50                   	push   %eax
8010286f:	8d 46 5c             	lea    0x5c(%esi),%eax
80102872:	50                   	push   %eax
80102873:	e8 b4 15 00 00       	call   80103e2c <memmove>
    bwrite(to);  // write the log
80102878:	89 34 24             	mov    %esi,(%esp)
8010287b:	e8 00 d9 ff ff       	call   80100180 <bwrite>
    brelse(from);
80102880:	89 3c 24             	mov    %edi,(%esp)
80102883:	e8 30 d9 ff ff       	call   801001b8 <brelse>
    brelse(to);
80102888:	89 34 24             	mov    %esi,(%esp)
8010288b:	e8 28 d9 ff ff       	call   801001b8 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102890:	43                   	inc    %ebx
80102891:	83 c4 10             	add    $0x10,%esp
80102894:	3b 1d c8 16 11 80    	cmp    0x801116c8,%ebx
8010289a:	7c 98                	jl     80102834 <end_op+0x64>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
8010289c:	e8 e7 fd ff ff       	call   80102688 <write_head>
    install_trans(); // Now install writes to home locations
801028a1:	e8 5a fd ff ff       	call   80102600 <install_trans>
    log.lh.n = 0;
801028a6:	c7 05 c8 16 11 80 00 	movl   $0x0,0x801116c8
801028ad:	00 00 00 
    write_head();    // Erase the transaction from the log
801028b0:	e8 d3 fd ff ff       	call   80102688 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
801028b5:	83 ec 0c             	sub    $0xc,%esp
801028b8:	68 80 16 11 80       	push   $0x80111680
801028bd:	e8 b6 13 00 00       	call   80103c78 <acquire>
    log.committing = 0;
801028c2:	c7 05 c0 16 11 80 00 	movl   $0x0,0x801116c0
801028c9:	00 00 00 
    wakeup(&log);
801028cc:	c7 04 24 80 16 11 80 	movl   $0x80111680,(%esp)
801028d3:	e8 70 10 00 00       	call   80103948 <wakeup>
    release(&log.lock);
801028d8:	c7 04 24 80 16 11 80 	movl   $0x80111680,(%esp)
801028df:	e8 68 14 00 00       	call   80103d4c <release>
801028e4:	83 c4 10             	add    $0x10,%esp
  }
}
801028e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801028ea:	5b                   	pop    %ebx
801028eb:	5e                   	pop    %esi
801028ec:	5f                   	pop    %edi
801028ed:	5d                   	pop    %ebp
801028ee:	c3                   	ret    
801028ef:	90                   	nop
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
801028f0:	83 ec 0c             	sub    $0xc,%esp
801028f3:	68 80 16 11 80       	push   $0x80111680
801028f8:	e8 4b 10 00 00       	call   80103948 <wakeup>
  }
  release(&log.lock);
801028fd:	c7 04 24 80 16 11 80 	movl   $0x80111680,(%esp)
80102904:	e8 43 14 00 00       	call   80103d4c <release>
80102909:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
8010290c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010290f:	5b                   	pop    %ebx
80102910:	5e                   	pop    %esi
80102911:	5f                   	pop    %edi
80102912:	5d                   	pop    %ebp
80102913:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102914:	83 ec 0c             	sub    $0xc,%esp
80102917:	68 04 69 10 80       	push   $0x80106904
8010291c:	e8 17 da ff ff       	call   80100338 <panic>
80102921:	8d 76 00             	lea    0x0(%esi),%esi

80102924 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102924:	55                   	push   %ebp
80102925:	89 e5                	mov    %esp,%ebp
80102927:	53                   	push   %ebx
80102928:	52                   	push   %edx
80102929:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
8010292c:	8b 15 c8 16 11 80    	mov    0x801116c8,%edx
80102932:	83 fa 1d             	cmp    $0x1d,%edx
80102935:	0f 8f 85 00 00 00    	jg     801029c0 <log_write+0x9c>
8010293b:	a1 b8 16 11 80       	mov    0x801116b8,%eax
80102940:	48                   	dec    %eax
80102941:	39 c2                	cmp    %eax,%edx
80102943:	7d 7b                	jge    801029c0 <log_write+0x9c>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102945:	a1 bc 16 11 80       	mov    0x801116bc,%eax
8010294a:	85 c0                	test   %eax,%eax
8010294c:	7e 7f                	jle    801029cd <log_write+0xa9>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010294e:	83 ec 0c             	sub    $0xc,%esp
80102951:	68 80 16 11 80       	push   $0x80111680
80102956:	e8 1d 13 00 00       	call   80103c78 <acquire>
  for (i = 0; i < log.lh.n; i++) {
8010295b:	8b 15 c8 16 11 80    	mov    0x801116c8,%edx
80102961:	83 c4 10             	add    $0x10,%esp
80102964:	83 fa 00             	cmp    $0x0,%edx
80102967:	7e 48                	jle    801029b1 <log_write+0x8d>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102969:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
8010296c:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
8010296e:	39 0d cc 16 11 80    	cmp    %ecx,0x801116cc
80102974:	75 0b                	jne    80102981 <log_write+0x5d>
80102976:	eb 30                	jmp    801029a8 <log_write+0x84>
80102978:	39 0c 85 cc 16 11 80 	cmp    %ecx,-0x7feee934(,%eax,4)
8010297f:	74 27                	je     801029a8 <log_write+0x84>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102981:	40                   	inc    %eax
80102982:	39 d0                	cmp    %edx,%eax
80102984:	75 f2                	jne    80102978 <log_write+0x54>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102986:	89 0c 95 cc 16 11 80 	mov    %ecx,-0x7feee934(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
8010298d:	42                   	inc    %edx
8010298e:	89 15 c8 16 11 80    	mov    %edx,0x801116c8
  b->flags |= B_DIRTY; // prevent eviction
80102994:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102997:	c7 45 08 80 16 11 80 	movl   $0x80111680,0x8(%ebp)
}
8010299e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029a1:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
801029a2:	e9 a5 13 00 00       	jmp    80103d4c <release>
801029a7:	90                   	nop
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
801029a8:	89 0c 85 cc 16 11 80 	mov    %ecx,-0x7feee934(,%eax,4)
801029af:	eb e3                	jmp    80102994 <log_write+0x70>
801029b1:	8b 43 08             	mov    0x8(%ebx),%eax
801029b4:	a3 cc 16 11 80       	mov    %eax,0x801116cc
  if (i == log.lh.n)
801029b9:	75 d9                	jne    80102994 <log_write+0x70>
801029bb:	eb d0                	jmp    8010298d <log_write+0x69>
801029bd:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
801029c0:	83 ec 0c             	sub    $0xc,%esp
801029c3:	68 13 69 10 80       	push   $0x80106913
801029c8:	e8 6b d9 ff ff       	call   80100338 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
801029cd:	83 ec 0c             	sub    $0xc,%esp
801029d0:	68 29 69 10 80       	push   $0x80106929
801029d5:	e8 5e d9 ff ff       	call   80100338 <panic>
801029da:	66 90                	xchg   %ax,%ax

801029dc <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801029dc:	55                   	push   %ebp
801029dd:	89 e5                	mov    %esp,%ebp
801029df:	53                   	push   %ebx
801029e0:	50                   	push   %eax
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801029e1:	e8 ae 08 00 00       	call   80103294 <cpuid>
801029e6:	89 c3                	mov    %eax,%ebx
801029e8:	e8 a7 08 00 00       	call   80103294 <cpuid>
801029ed:	52                   	push   %edx
801029ee:	53                   	push   %ebx
801029ef:	50                   	push   %eax
801029f0:	68 44 69 10 80       	push   $0x80106944
801029f5:	e8 0e dc ff ff       	call   80100608 <cprintf>
  idtinit();       // load idt register
801029fa:	e8 09 24 00 00       	call   80104e08 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
801029ff:	e8 18 08 00 00       	call   8010321c <mycpu>
80102a04:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102a06:	b8 01 00 00 00       	mov    $0x1,%eax
80102a0b:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102a12:	e8 1d 0b 00 00       	call   80103534 <scheduler>
80102a17:	90                   	nop

80102a18 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102a18:	55                   	push   %ebp
80102a19:	89 e5                	mov    %esp,%ebp
80102a1b:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102a1e:	e8 49 34 00 00       	call   80105e6c <switchkvm>
  seginit();
80102a23:	e8 54 33 00 00       	call   80105d7c <seginit>
  lapicinit();
80102a28:	e8 3b f9 ff ff       	call   80102368 <lapicinit>
  mpmain();
80102a2d:	e8 aa ff ff ff       	call   801029dc <mpmain>
80102a32:	66 90                	xchg   %ax,%ax

80102a34 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102a34:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102a38:	83 e4 f0             	and    $0xfffffff0,%esp
80102a3b:	ff 71 fc             	pushl  -0x4(%ecx)
80102a3e:	55                   	push   %ebp
80102a3f:	89 e5                	mov    %esp,%ebp
80102a41:	53                   	push   %ebx
80102a42:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102a43:	83 ec 08             	sub    $0x8,%esp
80102a46:	68 00 00 40 80       	push   $0x80400000
80102a4b:	68 a8 44 11 80       	push   $0x801144a8
80102a50:	e8 c3 f6 ff ff       	call   80102118 <kinit1>
  kvmalloc();      // kernel page table
80102a55:	e8 2e 38 00 00       	call   80106288 <kvmalloc>
  mpinit();        // detect other processors
80102a5a:	e8 59 01 00 00       	call   80102bb8 <mpinit>
  lapicinit();     // interrupt controller
80102a5f:	e8 04 f9 ff ff       	call   80102368 <lapicinit>
  seginit();       // segment descriptors
80102a64:	e8 13 33 00 00       	call   80105d7c <seginit>
  picinit();       // disable pic
80102a69:	e8 ea 02 00 00       	call   80102d58 <picinit>
  ioapicinit();    // another interrupt controller
80102a6e:	e8 fd f4 ff ff       	call   80101f70 <ioapicinit>
  consoleinit();   // console hardware
80102a73:	e8 60 de ff ff       	call   801008d8 <consoleinit>
  uartinit();      // serial port
80102a78:	e8 33 26 00 00       	call   801050b0 <uartinit>
  pinit();         // process table
80102a7d:	e8 7e 07 00 00       	call   80103200 <pinit>
  tvinit();        // trap vectors
80102a82:	e8 f9 22 00 00       	call   80104d80 <tvinit>
  binit();         // buffer cache
80102a87:	e8 a8 d5 ff ff       	call   80100034 <binit>
  fileinit();      // file table
80102a8c:	e8 db e1 ff ff       	call   80100c6c <fileinit>
  ideinit();       // disk 
80102a91:	e8 f2 f2 ff ff       	call   80101d88 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102a96:	83 c4 0c             	add    $0xc,%esp
80102a99:	68 8a 00 00 00       	push   $0x8a
80102a9e:	68 8c 94 10 80       	push   $0x8010948c
80102aa3:	68 00 70 00 80       	push   $0x80007000
80102aa8:	e8 7f 13 00 00       	call   80103e2c <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102aad:	a1 00 1d 11 80       	mov    0x80111d00,%eax
80102ab2:	8d 14 80             	lea    (%eax,%eax,4),%edx
80102ab5:	01 d2                	add    %edx,%edx
80102ab7:	01 d0                	add    %edx,%eax
80102ab9:	c1 e0 04             	shl    $0x4,%eax
80102abc:	05 80 17 11 80       	add    $0x80111780,%eax
80102ac1:	83 c4 10             	add    $0x10,%esp
80102ac4:	bb 80 17 11 80       	mov    $0x80111780,%ebx
80102ac9:	39 d8                	cmp    %ebx,%eax
80102acb:	76 6b                	jbe    80102b38 <main+0x104>
80102acd:	8d 76 00             	lea    0x0(%esi),%esi
    if(c == mycpu())  // We've started already.
80102ad0:	e8 47 07 00 00       	call   8010321c <mycpu>
80102ad5:	39 d8                	cmp    %ebx,%eax
80102ad7:	74 41                	je     80102b1a <main+0xe6>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102ad9:	e8 f2 f6 ff ff       	call   801021d0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102ade:	05 00 10 00 00       	add    $0x1000,%eax
80102ae3:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void**)(code-8) = mpenter;
80102ae8:	c7 05 f8 6f 00 80 18 	movl   $0x80102a18,0x80006ff8
80102aef:	2a 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102af2:	c7 05 f4 6f 00 80 00 	movl   $0x108000,0x80006ff4
80102af9:	80 10 00 

    lapicstartap(c->apicid, V2P(code));
80102afc:	83 ec 08             	sub    $0x8,%esp
80102aff:	68 00 70 00 00       	push   $0x7000
80102b04:	0f b6 03             	movzbl (%ebx),%eax
80102b07:	50                   	push   %eax
80102b08:	e8 7b f9 ff ff       	call   80102488 <lapicstartap>
80102b0d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102b10:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102b16:	85 c0                	test   %eax,%eax
80102b18:	74 f6                	je     80102b10 <main+0xdc>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102b1a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102b20:	a1 00 1d 11 80       	mov    0x80111d00,%eax
80102b25:	8d 14 80             	lea    (%eax,%eax,4),%edx
80102b28:	01 d2                	add    %edx,%edx
80102b2a:	01 d0                	add    %edx,%eax
80102b2c:	c1 e0 04             	shl    $0x4,%eax
80102b2f:	05 80 17 11 80       	add    $0x80111780,%eax
80102b34:	39 c3                	cmp    %eax,%ebx
80102b36:	72 98                	jb     80102ad0 <main+0x9c>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102b38:	83 ec 08             	sub    $0x8,%esp
80102b3b:	68 00 00 00 8e       	push   $0x8e000000
80102b40:	68 00 00 40 80       	push   $0x80400000
80102b45:	e8 32 f6 ff ff       	call   8010217c <kinit2>
  userinit();      // first user process
80102b4a:	e8 99 07 00 00       	call   801032e8 <userinit>
  mpmain();        // finish this processor's setup
80102b4f:	e8 88 fe ff ff       	call   801029dc <mpmain>

80102b54 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102b54:	55                   	push   %ebp
80102b55:	89 e5                	mov    %esp,%ebp
80102b57:	57                   	push   %edi
80102b58:	56                   	push   %esi
80102b59:	53                   	push   %ebx
80102b5a:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
80102b5d:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
  e = addr+len;
80102b63:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
  for(p = addr; p < e; p += sizeof(struct mp))
80102b66:	39 de                	cmp    %ebx,%esi
80102b68:	72 0b                	jb     80102b75 <mpsearch1+0x21>
80102b6a:	eb 40                	jmp    80102bac <mpsearch1+0x58>
80102b6c:	8d 7e 10             	lea    0x10(%esi),%edi
80102b6f:	89 fe                	mov    %edi,%esi
80102b71:	39 fb                	cmp    %edi,%ebx
80102b73:	76 37                	jbe    80102bac <mpsearch1+0x58>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102b75:	50                   	push   %eax
80102b76:	6a 04                	push   $0x4
80102b78:	68 58 69 10 80       	push   $0x80106958
80102b7d:	56                   	push   %esi
80102b7e:	e8 61 12 00 00       	call   80103de4 <memcmp>
80102b83:	83 c4 10             	add    $0x10,%esp
80102b86:	85 c0                	test   %eax,%eax
80102b88:	75 e2                	jne    80102b6c <mpsearch1+0x18>
80102b8a:	89 f2                	mov    %esi,%edx
80102b8c:	8d 7e 10             	lea    0x10(%esi),%edi
80102b8f:	31 c9                	xor    %ecx,%ecx
80102b91:	8d 76 00             	lea    0x0(%esi),%esi
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
80102b94:	0f b6 02             	movzbl (%edx),%eax
80102b97:	01 c1                	add    %eax,%ecx
80102b99:	42                   	inc    %edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80102b9a:	39 fa                	cmp    %edi,%edx
80102b9c:	75 f6                	jne    80102b94 <mpsearch1+0x40>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102b9e:	84 c9                	test   %cl,%cl
80102ba0:	75 cd                	jne    80102b6f <mpsearch1+0x1b>
      return (struct mp*)p;
80102ba2:	89 f0                	mov    %esi,%eax
  return 0;
}
80102ba4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ba7:	5b                   	pop    %ebx
80102ba8:	5e                   	pop    %esi
80102ba9:	5f                   	pop    %edi
80102baa:	5d                   	pop    %ebp
80102bab:	c3                   	ret    
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80102bac:	31 c0                	xor    %eax,%eax
}
80102bae:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102bb1:	5b                   	pop    %ebx
80102bb2:	5e                   	pop    %esi
80102bb3:	5f                   	pop    %edi
80102bb4:	5d                   	pop    %ebp
80102bb5:	c3                   	ret    
80102bb6:	66 90                	xchg   %ax,%ax

80102bb8 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80102bb8:	55                   	push   %ebp
80102bb9:	89 e5                	mov    %esp,%ebp
80102bbb:	57                   	push   %edi
80102bbc:	56                   	push   %esi
80102bbd:	53                   	push   %ebx
80102bbe:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80102bc1:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80102bc8:	c1 e0 08             	shl    $0x8,%eax
80102bcb:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80102bd2:	09 d0                	or     %edx,%eax
80102bd4:	c1 e0 04             	shl    $0x4,%eax
80102bd7:	75 1b                	jne    80102bf4 <mpinit+0x3c>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80102bd9:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80102be0:	c1 e0 08             	shl    $0x8,%eax
80102be3:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80102bea:	09 d0                	or     %edx,%eax
80102bec:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80102bef:	2d 00 04 00 00       	sub    $0x400,%eax
80102bf4:	ba 00 04 00 00       	mov    $0x400,%edx
80102bf9:	e8 56 ff ff ff       	call   80102b54 <mpsearch1>
80102bfe:	85 c0                	test   %eax,%eax
80102c00:	0f 84 20 01 00 00    	je     80102d26 <mpinit+0x16e>
80102c06:	89 c7                	mov    %eax,%edi
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80102c08:	8b 77 04             	mov    0x4(%edi),%esi
80102c0b:	85 f6                	test   %esi,%esi
80102c0d:	0f 84 2c 01 00 00    	je     80102d3f <mpinit+0x187>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80102c13:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80102c19:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80102c1c:	52                   	push   %edx
80102c1d:	6a 04                	push   $0x4
80102c1f:	68 5d 69 10 80       	push   $0x8010695d
80102c24:	50                   	push   %eax
80102c25:	e8 ba 11 00 00       	call   80103de4 <memcmp>
80102c2a:	83 c4 10             	add    $0x10,%esp
80102c2d:	85 c0                	test   %eax,%eax
80102c2f:	0f 85 0a 01 00 00    	jne    80102d3f <mpinit+0x187>
    return 0;
  if(conf->version != 1 && conf->version != 4)
80102c35:	8a 86 06 00 00 80    	mov    -0x7ffffffa(%esi),%al
80102c3b:	3c 01                	cmp    $0x1,%al
80102c3d:	74 08                	je     80102c47 <mpinit+0x8f>
80102c3f:	3c 04                	cmp    $0x4,%al
80102c41:	0f 85 f8 00 00 00    	jne    80102d3f <mpinit+0x187>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80102c47:	0f b7 86 04 00 00 80 	movzwl -0x7ffffffc(%esi),%eax
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80102c4e:	66 85 c0             	test   %ax,%ax
80102c51:	74 1f                	je     80102c72 <mpinit+0xba>
80102c53:	89 f2                	mov    %esi,%edx
80102c55:	01 f0                	add    %esi,%eax
80102c57:	31 c9                	xor    %ecx,%ecx
80102c59:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80102c5c:	0f b6 9a 00 00 00 80 	movzbl -0x80000000(%edx),%ebx
80102c63:	01 d9                	add    %ebx,%ecx
80102c65:	42                   	inc    %edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80102c66:	39 c2                	cmp    %eax,%edx
80102c68:	75 f2                	jne    80102c5c <mpinit+0xa4>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80102c6a:	84 c9                	test   %cl,%cl
80102c6c:	0f 85 cd 00 00 00    	jne    80102d3f <mpinit+0x187>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80102c72:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102c75:	85 c0                	test   %eax,%eax
80102c77:	0f 84 c2 00 00 00    	je     80102d3f <mpinit+0x187>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80102c7d:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
80102c83:	a3 7c 16 11 80       	mov    %eax,0x8011167c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80102c88:	8d 96 2c 00 00 80    	lea    -0x7fffffd4(%esi),%edx
80102c8e:	0f b7 8e 04 00 00 80 	movzwl -0x7ffffffc(%esi),%ecx
80102c95:	03 4d e4             	add    -0x1c(%ebp),%ecx
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
80102c98:	bb 01 00 00 00       	mov    $0x1,%ebx
80102c9d:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80102ca0:	39 d1                	cmp    %edx,%ecx
80102ca2:	76 1b                	jbe    80102cbf <mpinit+0x107>
80102ca4:	0f b6 02             	movzbl (%edx),%eax
    switch(*p){
80102ca7:	3c 04                	cmp    $0x4,%al
80102ca9:	0f 87 9d 00 00 00    	ja     80102d4c <mpinit+0x194>
80102caf:	ff 24 85 9c 69 10 80 	jmp    *-0x7fef9664(,%eax,4)
80102cb6:	66 90                	xchg   %ax,%ax
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80102cb8:	83 c2 08             	add    $0x8,%edx

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80102cbb:	39 d1                	cmp    %edx,%ecx
80102cbd:	77 e5                	ja     80102ca4 <mpinit+0xec>
80102cbf:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80102cc2:	85 db                	test   %ebx,%ebx
80102cc4:	74 53                	je     80102d19 <mpinit+0x161>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80102cc6:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
80102cca:	74 0f                	je     80102cdb <mpinit+0x123>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ccc:	ba 22 00 00 00       	mov    $0x22,%edx
80102cd1:	b0 70                	mov    $0x70,%al
80102cd3:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cd4:	b2 23                	mov    $0x23,%dl
80102cd6:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80102cd7:	83 c8 01             	or     $0x1,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cda:	ee                   	out    %al,(%dx)
  }
}
80102cdb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102cde:	5b                   	pop    %ebx
80102cdf:	5e                   	pop    %esi
80102ce0:	5f                   	pop    %edi
80102ce1:	5d                   	pop    %ebp
80102ce2:	c3                   	ret    
80102ce3:	90                   	nop
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80102ce4:	a1 00 1d 11 80       	mov    0x80111d00,%eax
80102ce9:	83 f8 07             	cmp    $0x7,%eax
80102cec:	7f 19                	jg     80102d07 <mpinit+0x14f>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80102cee:	8d 34 80             	lea    (%eax,%eax,4),%esi
80102cf1:	01 f6                	add    %esi,%esi
80102cf3:	01 f0                	add    %esi,%eax
80102cf5:	c1 e0 04             	shl    $0x4,%eax
80102cf8:	8a 5a 01             	mov    0x1(%edx),%bl
80102cfb:	88 98 80 17 11 80    	mov    %bl,-0x7feee880(%eax)
        ncpu++;
80102d01:	ff 05 00 1d 11 80    	incl   0x80111d00
      }
      p += sizeof(struct mpproc);
80102d07:	83 c2 14             	add    $0x14,%edx
      continue;
80102d0a:	eb 94                	jmp    80102ca0 <mpinit+0xe8>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80102d0c:	8a 42 01             	mov    0x1(%edx),%al
80102d0f:	a2 60 17 11 80       	mov    %al,0x80111760
      p += sizeof(struct mpioapic);
80102d14:	83 c2 08             	add    $0x8,%edx
      continue;
80102d17:	eb 87                	jmp    80102ca0 <mpinit+0xe8>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
80102d19:	83 ec 0c             	sub    $0xc,%esp
80102d1c:	68 7c 69 10 80       	push   $0x8010697c
80102d21:	e8 12 d6 ff ff       	call   80100338 <panic>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
80102d26:	ba 00 00 01 00       	mov    $0x10000,%edx
80102d2b:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80102d30:	e8 1f fe ff ff       	call   80102b54 <mpsearch1>
80102d35:	89 c7                	mov    %eax,%edi
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80102d37:	85 c0                	test   %eax,%eax
80102d39:	0f 85 c9 fe ff ff    	jne    80102c08 <mpinit+0x50>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
80102d3f:	83 ec 0c             	sub    $0xc,%esp
80102d42:	68 62 69 10 80       	push   $0x80106962
80102d47:	e8 ec d5 ff ff       	call   80100338 <panic>
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
80102d4c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80102d53:	e9 4f ff ff ff       	jmp    80102ca7 <mpinit+0xef>

80102d58 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80102d58:	55                   	push   %ebp
80102d59:	89 e5                	mov    %esp,%ebp
80102d5b:	ba 21 00 00 00       	mov    $0x21,%edx
80102d60:	b0 ff                	mov    $0xff,%al
80102d62:	ee                   	out    %al,(%dx)
80102d63:	b2 a1                	mov    $0xa1,%dl
80102d65:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80102d66:	5d                   	pop    %ebp
80102d67:	c3                   	ret    

80102d68 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80102d68:	55                   	push   %ebp
80102d69:	89 e5                	mov    %esp,%ebp
80102d6b:	56                   	push   %esi
80102d6c:	53                   	push   %ebx
80102d6d:	83 ec 10             	sub    $0x10,%esp
80102d70:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102d73:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
80102d76:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80102d7c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80102d82:	e8 01 df ff ff       	call   80100c88 <filealloc>
80102d87:	89 03                	mov    %eax,(%ebx)
80102d89:	85 c0                	test   %eax,%eax
80102d8b:	0f 84 a9 00 00 00    	je     80102e3a <pipealloc+0xd2>
80102d91:	e8 f2 de ff ff       	call   80100c88 <filealloc>
80102d96:	89 06                	mov    %eax,(%esi)
80102d98:	85 c0                	test   %eax,%eax
80102d9a:	0f 84 88 00 00 00    	je     80102e28 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80102da0:	e8 2b f4 ff ff       	call   801021d0 <kalloc>
80102da5:	85 c0                	test   %eax,%eax
80102da7:	0f 84 ab 00 00 00    	je     80102e58 <pipealloc+0xf0>
    goto bad;
  p->readopen = 1;
80102dad:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80102db4:	00 00 00 
  p->writeopen = 1;
80102db7:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80102dbe:	00 00 00 
  p->nwrite = 0;
80102dc1:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80102dc8:	00 00 00 
  p->nread = 0;
80102dcb:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80102dd2:	00 00 00 
  initlock(&p->lock, "pipe");
80102dd5:	83 ec 08             	sub    $0x8,%esp
80102dd8:	68 b0 69 10 80       	push   $0x801069b0
80102ddd:	50                   	push   %eax
80102dde:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102de1:	e8 ce 0d 00 00       	call   80103bb4 <initlock>
  (*f0)->type = FD_PIPE;
80102de6:	8b 13                	mov    (%ebx),%edx
80102de8:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
  (*f0)->readable = 1;
80102dee:	8b 13                	mov    (%ebx),%edx
80102df0:	c6 42 08 01          	movb   $0x1,0x8(%edx)
  (*f0)->writable = 0;
80102df4:	8b 13                	mov    (%ebx),%edx
80102df6:	c6 42 09 00          	movb   $0x0,0x9(%edx)
  (*f0)->pipe = p;
80102dfa:	8b 13                	mov    (%ebx),%edx
80102dfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102dff:	89 42 0c             	mov    %eax,0xc(%edx)
  (*f1)->type = FD_PIPE;
80102e02:	8b 16                	mov    (%esi),%edx
80102e04:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
  (*f1)->readable = 0;
80102e0a:	8b 16                	mov    (%esi),%edx
80102e0c:	c6 42 08 00          	movb   $0x0,0x8(%edx)
  (*f1)->writable = 1;
80102e10:	8b 16                	mov    (%esi),%edx
80102e12:	c6 42 09 01          	movb   $0x1,0x9(%edx)
  (*f1)->pipe = p;
80102e16:	8b 16                	mov    (%esi),%edx
80102e18:	89 42 0c             	mov    %eax,0xc(%edx)
  return 0;
80102e1b:	83 c4 10             	add    $0x10,%esp
80102e1e:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80102e20:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102e23:	5b                   	pop    %ebx
80102e24:	5e                   	pop    %esi
80102e25:	5d                   	pop    %ebp
80102e26:	c3                   	ret    
80102e27:	90                   	nop

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80102e28:	8b 03                	mov    (%ebx),%eax
80102e2a:	85 c0                	test   %eax,%eax
80102e2c:	74 1e                	je     80102e4c <pipealloc+0xe4>
    fileclose(*f0);
80102e2e:	83 ec 0c             	sub    $0xc,%esp
80102e31:	50                   	push   %eax
80102e32:	e8 f9 de ff ff       	call   80100d30 <fileclose>
80102e37:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80102e3a:	8b 06                	mov    (%esi),%eax
80102e3c:	85 c0                	test   %eax,%eax
80102e3e:	74 0c                	je     80102e4c <pipealloc+0xe4>
    fileclose(*f1);
80102e40:	83 ec 0c             	sub    $0xc,%esp
80102e43:	50                   	push   %eax
80102e44:	e8 e7 de ff ff       	call   80100d30 <fileclose>
80102e49:	83 c4 10             	add    $0x10,%esp
  return -1;
80102e4c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102e51:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102e54:	5b                   	pop    %ebx
80102e55:	5e                   	pop    %esi
80102e56:	5d                   	pop    %ebp
80102e57:	c3                   	ret    

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80102e58:	8b 03                	mov    (%ebx),%eax
80102e5a:	85 c0                	test   %eax,%eax
80102e5c:	75 d0                	jne    80102e2e <pipealloc+0xc6>
80102e5e:	eb da                	jmp    80102e3a <pipealloc+0xd2>

80102e60 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
80102e60:	55                   	push   %ebp
80102e61:	89 e5                	mov    %esp,%ebp
80102e63:	56                   	push   %esi
80102e64:	53                   	push   %ebx
80102e65:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102e68:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
80102e6b:	83 ec 0c             	sub    $0xc,%esp
80102e6e:	53                   	push   %ebx
80102e6f:	e8 04 0e 00 00       	call   80103c78 <acquire>
  if(writable){
80102e74:	83 c4 10             	add    $0x10,%esp
80102e77:	85 f6                	test   %esi,%esi
80102e79:	74 41                	je     80102ebc <pipeclose+0x5c>
    p->writeopen = 0;
80102e7b:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80102e82:	00 00 00 
    wakeup(&p->nread);
80102e85:	83 ec 0c             	sub    $0xc,%esp
80102e88:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80102e8e:	50                   	push   %eax
80102e8f:	e8 b4 0a 00 00       	call   80103948 <wakeup>
80102e94:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80102e97:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80102e9d:	85 d2                	test   %edx,%edx
80102e9f:	75 0a                	jne    80102eab <pipeclose+0x4b>
80102ea1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80102ea7:	85 c0                	test   %eax,%eax
80102ea9:	74 31                	je     80102edc <pipeclose+0x7c>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80102eab:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80102eae:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102eb1:	5b                   	pop    %ebx
80102eb2:	5e                   	pop    %esi
80102eb3:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80102eb4:	e9 93 0e 00 00       	jmp    80103d4c <release>
80102eb9:	8d 76 00             	lea    0x0(%esi),%esi
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
80102ebc:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80102ec3:	00 00 00 
    wakeup(&p->nwrite);
80102ec6:	83 ec 0c             	sub    $0xc,%esp
80102ec9:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80102ecf:	50                   	push   %eax
80102ed0:	e8 73 0a 00 00       	call   80103948 <wakeup>
80102ed5:	83 c4 10             	add    $0x10,%esp
80102ed8:	eb bd                	jmp    80102e97 <pipeclose+0x37>
80102eda:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80102edc:	83 ec 0c             	sub    $0xc,%esp
80102edf:	53                   	push   %ebx
80102ee0:	e8 67 0e 00 00       	call   80103d4c <release>
    kfree((char*)p);
80102ee5:	83 c4 10             	add    $0x10,%esp
80102ee8:	89 5d 08             	mov    %ebx,0x8(%ebp)
  } else
    release(&p->lock);
}
80102eeb:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102eee:	5b                   	pop    %ebx
80102eef:	5e                   	pop    %esi
80102ef0:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
80102ef1:	e9 4e f1 ff ff       	jmp    80102044 <kfree>
80102ef6:	66 90                	xchg   %ax,%ax

80102ef8 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80102ef8:	55                   	push   %ebp
80102ef9:	89 e5                	mov    %esp,%ebp
80102efb:	57                   	push   %edi
80102efc:	56                   	push   %esi
80102efd:	53                   	push   %ebx
80102efe:	83 ec 28             	sub    $0x28,%esp
80102f01:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
80102f04:	53                   	push   %ebx
80102f05:	e8 6e 0d 00 00       	call   80103c78 <acquire>
  for(i = 0; i < n; i++){
80102f0a:	83 c4 10             	add    $0x10,%esp
80102f0d:	8b 45 10             	mov    0x10(%ebp),%eax
80102f10:	85 c0                	test   %eax,%eax
80102f12:	0f 8e b6 00 00 00    	jle    80102fce <pipewrite+0xd6>
80102f18:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80102f1e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102f21:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80102f24:	03 4d 10             	add    0x10(%ebp),%ecx
80102f27:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80102f2a:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80102f30:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80102f36:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80102f3c:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80102f42:	39 d0                	cmp    %edx,%eax
80102f44:	74 38                	je     80102f7e <pipewrite+0x86>
80102f46:	eb 59                	jmp    80102fa1 <pipewrite+0xa9>
      if(p->readopen == 0 || myproc()->killed){
80102f48:	e8 7b 03 00 00       	call   801032c8 <myproc>
80102f4d:	8b 48 24             	mov    0x24(%eax),%ecx
80102f50:	85 c9                	test   %ecx,%ecx
80102f52:	75 34                	jne    80102f88 <pipewrite+0x90>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80102f54:	83 ec 0c             	sub    $0xc,%esp
80102f57:	57                   	push   %edi
80102f58:	e8 eb 09 00 00       	call   80103948 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80102f5d:	58                   	pop    %eax
80102f5e:	5a                   	pop    %edx
80102f5f:	53                   	push   %ebx
80102f60:	56                   	push   %esi
80102f61:	e8 56 08 00 00       	call   801037bc <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80102f66:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80102f6c:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80102f72:	05 00 02 00 00       	add    $0x200,%eax
80102f77:	83 c4 10             	add    $0x10,%esp
80102f7a:	39 c2                	cmp    %eax,%edx
80102f7c:	75 26                	jne    80102fa4 <pipewrite+0xac>
      if(p->readopen == 0 || myproc()->killed){
80102f7e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80102f84:	85 c0                	test   %eax,%eax
80102f86:	75 c0                	jne    80102f48 <pipewrite+0x50>
        release(&p->lock);
80102f88:	83 ec 0c             	sub    $0xc,%esp
80102f8b:	53                   	push   %ebx
80102f8c:	e8 bb 0d 00 00       	call   80103d4c <release>
        return -1;
80102f91:	83 c4 10             	add    $0x10,%esp
80102f94:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80102f99:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f9c:	5b                   	pop    %ebx
80102f9d:	5e                   	pop    %esi
80102f9e:	5f                   	pop    %edi
80102f9f:	5d                   	pop    %ebp
80102fa0:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80102fa1:	89 c2                	mov    %eax,%edx
80102fa3:	90                   	nop
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80102fa4:	8d 42 01             	lea    0x1(%edx),%eax
80102fa7:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80102fad:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102fb0:	8a 09                	mov    (%ecx),%cl
80102fb2:	88 4d df             	mov    %cl,-0x21(%ebp)
80102fb5:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80102fbb:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
80102fbf:	ff 45 e4             	incl   -0x1c(%ebp)
80102fc2:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80102fc5:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
80102fc8:	0f 85 68 ff ff ff    	jne    80102f36 <pipewrite+0x3e>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80102fce:	83 ec 0c             	sub    $0xc,%esp
80102fd1:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80102fd7:	50                   	push   %eax
80102fd8:	e8 6b 09 00 00       	call   80103948 <wakeup>
  release(&p->lock);
80102fdd:	89 1c 24             	mov    %ebx,(%esp)
80102fe0:	e8 67 0d 00 00       	call   80103d4c <release>
  return n;
80102fe5:	83 c4 10             	add    $0x10,%esp
80102fe8:	8b 45 10             	mov    0x10(%ebp),%eax
80102feb:	eb ac                	jmp    80102f99 <pipewrite+0xa1>
80102fed:	8d 76 00             	lea    0x0(%esi),%esi

80102ff0 <piperead>:
}

int
piperead(struct pipe *p, char *addr, int n)
{
80102ff0:	55                   	push   %ebp
80102ff1:	89 e5                	mov    %esp,%ebp
80102ff3:	57                   	push   %edi
80102ff4:	56                   	push   %esi
80102ff5:	53                   	push   %ebx
80102ff6:	83 ec 18             	sub    $0x18,%esp
80102ff9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102ffc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80102fff:	53                   	push   %ebx
80103000:	e8 73 0c 00 00       	call   80103c78 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103005:	83 c4 10             	add    $0x10,%esp
80103008:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
8010300e:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
80103014:	0f 85 8a 00 00 00    	jne    801030a4 <piperead+0xb4>
8010301a:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
80103020:	85 f6                	test   %esi,%esi
80103022:	74 54                	je     80103078 <piperead+0x88>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103024:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
8010302a:	eb 25                	jmp    80103051 <piperead+0x61>
8010302c:	83 ec 08             	sub    $0x8,%esp
8010302f:	53                   	push   %ebx
80103030:	56                   	push   %esi
80103031:	e8 86 07 00 00       	call   801037bc <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103036:	83 c4 10             	add    $0x10,%esp
80103039:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
8010303f:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
80103045:	75 5d                	jne    801030a4 <piperead+0xb4>
80103047:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
8010304d:	85 d2                	test   %edx,%edx
8010304f:	74 27                	je     80103078 <piperead+0x88>
    if(myproc()->killed){
80103051:	e8 72 02 00 00       	call   801032c8 <myproc>
80103056:	8b 48 24             	mov    0x24(%eax),%ecx
80103059:	85 c9                	test   %ecx,%ecx
8010305b:	74 cf                	je     8010302c <piperead+0x3c>
      release(&p->lock);
8010305d:	83 ec 0c             	sub    $0xc,%esp
80103060:	53                   	push   %ebx
80103061:	e8 e6 0c 00 00       	call   80103d4c <release>
      return -1;
80103066:	83 c4 10             	add    $0x10,%esp
80103069:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
8010306e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103071:	5b                   	pop    %ebx
80103072:	5e                   	pop    %esi
80103073:	5f                   	pop    %edi
80103074:	5d                   	pop    %ebp
80103075:	c3                   	ret    
80103076:	66 90                	xchg   %ax,%ax
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103078:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010307f:	83 ec 0c             	sub    $0xc,%esp
80103082:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103088:	50                   	push   %eax
80103089:	e8 ba 08 00 00       	call   80103948 <wakeup>
  release(&p->lock);
8010308e:	89 1c 24             	mov    %ebx,(%esp)
80103091:	e8 b6 0c 00 00       	call   80103d4c <release>
  return i;
80103096:	83 c4 10             	add    $0x10,%esp
80103099:	8b 45 10             	mov    0x10(%ebp),%eax
}
8010309c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010309f:	5b                   	pop    %ebx
801030a0:	5e                   	pop    %esi
801030a1:	5f                   	pop    %edi
801030a2:	5d                   	pop    %ebp
801030a3:	c3                   	ret    
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801030a4:	8b 45 10             	mov    0x10(%ebp),%eax
801030a7:	85 c0                	test   %eax,%eax
801030a9:	7e cd                	jle    80103078 <piperead+0x88>
    if(p->nread == p->nwrite)
801030ab:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801030b1:	31 c9                	xor    %ecx,%ecx
801030b3:	90                   	nop
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801030b4:	8d 70 01             	lea    0x1(%eax),%esi
801030b7:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
801030bd:	25 ff 01 00 00       	and    $0x1ff,%eax
801030c2:	8a 44 03 34          	mov    0x34(%ebx,%eax,1),%al
801030c6:	88 04 0f             	mov    %al,(%edi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801030c9:	41                   	inc    %ecx
801030ca:	3b 4d 10             	cmp    0x10(%ebp),%ecx
801030cd:	74 b0                	je     8010307f <piperead+0x8f>
    if(p->nread == p->nwrite)
801030cf:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801030d5:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
801030db:	75 d7                	jne    801030b4 <piperead+0xc4>
801030dd:	89 4d 10             	mov    %ecx,0x10(%ebp)
801030e0:	eb 9d                	jmp    8010307f <piperead+0x8f>
801030e2:	66 90                	xchg   %ax,%ax

801030e4 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801030e4:	55                   	push   %ebp
801030e5:	89 e5                	mov    %esp,%ebp
801030e7:	53                   	push   %ebx
801030e8:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801030eb:	68 20 1d 11 80       	push   $0x80111d20
801030f0:	e8 83 0b 00 00       	call   80103c78 <acquire>
801030f5:	83 c4 10             	add    $0x10,%esp

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801030f8:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
801030fd:	eb 0c                	jmp    8010310b <allocproc+0x27>
801030ff:	90                   	nop
80103100:	83 c3 7c             	add    $0x7c,%ebx
80103103:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80103109:	74 75                	je     80103180 <allocproc+0x9c>
    if(p->state == UNUSED)
8010310b:	8b 4b 0c             	mov    0xc(%ebx),%ecx
8010310e:	85 c9                	test   %ecx,%ecx
80103110:	75 ee                	jne    80103100 <allocproc+0x1c>

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
80103112:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103119:	a1 04 90 10 80       	mov    0x80109004,%eax
8010311e:	8d 50 01             	lea    0x1(%eax),%edx
80103121:	89 15 04 90 10 80    	mov    %edx,0x80109004
80103127:	89 43 10             	mov    %eax,0x10(%ebx)

  release(&ptable.lock);
8010312a:	83 ec 0c             	sub    $0xc,%esp
8010312d:	68 20 1d 11 80       	push   $0x80111d20
80103132:	e8 15 0c 00 00       	call   80103d4c <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103137:	e8 94 f0 ff ff       	call   801021d0 <kalloc>
8010313c:	89 43 08             	mov    %eax,0x8(%ebx)
8010313f:	83 c4 10             	add    $0x10,%esp
80103142:	85 c0                	test   %eax,%eax
80103144:	74 51                	je     80103197 <allocproc+0xb3>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103146:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
8010314c:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
8010314f:	c7 80 b0 0f 00 00 75 	movl   $0x80104d75,0xfb0(%eax)
80103156:	4d 10 80 

  sp -= sizeof *p->context;
80103159:	05 9c 0f 00 00       	add    $0xf9c,%eax
  p->context = (struct context*)sp;
8010315e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103161:	52                   	push   %edx
80103162:	6a 14                	push   $0x14
80103164:	6a 00                	push   $0x0
80103166:	50                   	push   %eax
80103167:	e8 2c 0c 00 00       	call   80103d98 <memset>
  p->context->eip = (uint)forkret;
8010316c:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010316f:	c7 40 10 a0 31 10 80 	movl   $0x801031a0,0x10(%eax)

  return p;
80103176:	83 c4 10             	add    $0x10,%esp
80103179:	89 d8                	mov    %ebx,%eax
}
8010317b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010317e:	c9                   	leave  
8010317f:	c3                   	ret    

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80103180:	83 ec 0c             	sub    $0xc,%esp
80103183:	68 20 1d 11 80       	push   $0x80111d20
80103188:	e8 bf 0b 00 00       	call   80103d4c <release>
  return 0;
8010318d:	83 c4 10             	add    $0x10,%esp
80103190:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
80103192:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103195:	c9                   	leave  
80103196:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
80103197:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
8010319e:	eb db                	jmp    8010317b <allocproc+0x97>

801031a0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801031a0:	55                   	push   %ebp
801031a1:	89 e5                	mov    %esp,%ebp
801031a3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801031a6:	68 20 1d 11 80       	push   $0x80111d20
801031ab:	e8 9c 0b 00 00       	call   80103d4c <release>

  if (first) {
801031b0:	83 c4 10             	add    $0x10,%esp
801031b3:	a1 00 90 10 80       	mov    0x80109000,%eax
801031b8:	85 c0                	test   %eax,%eax
801031ba:	75 04                	jne    801031c0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801031bc:	c9                   	leave  
801031bd:	c3                   	ret    
801031be:	66 90                	xchg   %ax,%ax

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
801031c0:	c7 05 00 90 10 80 00 	movl   $0x0,0x80109000
801031c7:	00 00 00 
    iinit(ROOTDEV);
801031ca:	83 ec 0c             	sub    $0xc,%esp
801031cd:	6a 01                	push   $0x1
801031cf:	e8 1c e1 ff ff       	call   801012f0 <iinit>
    initlog(ROOTDEV);
801031d4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801031db:	e8 fc f4 ff ff       	call   801026dc <initlog>
801031e0:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
801031e3:	c9                   	leave  
801031e4:	c3                   	ret    
801031e5:	8d 76 00             	lea    0x0(%esi),%esi

801031e8 <mike>:
extern void trapret(void);

static void wakeup1(void *chan);

int 
mike (void){
801031e8:	55                   	push   %ebp
801031e9:	89 e5                	mov    %esp,%ebp
801031eb:	83 ec 14             	sub    $0x14,%esp

    //struct proc* p = myproc();
    // Perhaps do something interesting?
    // Actually..let's just print hello
    cprintf("Hello from mike syscall\n");
801031ee:	68 b5 69 10 80       	push   $0x801069b5
801031f3:	e8 10 d4 ff ff       	call   80100608 <cprintf>

    return 22; // Our system call number
}
801031f8:	b8 16 00 00 00       	mov    $0x16,%eax
801031fd:	c9                   	leave  
801031fe:	c3                   	ret    
801031ff:	90                   	nop

80103200 <pinit>:

void
pinit(void)
{
80103200:	55                   	push   %ebp
80103201:	89 e5                	mov    %esp,%ebp
80103203:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103206:	68 ce 69 10 80       	push   $0x801069ce
8010320b:	68 20 1d 11 80       	push   $0x80111d20
80103210:	e8 9f 09 00 00       	call   80103bb4 <initlock>
80103215:	83 c4 10             	add    $0x10,%esp
}
80103218:	c9                   	leave  
80103219:	c3                   	ret    
8010321a:	66 90                	xchg   %ax,%ax

8010321c <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
8010321c:	55                   	push   %ebp
8010321d:	89 e5                	mov    %esp,%ebp
8010321f:	56                   	push   %esi
80103220:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103221:	9c                   	pushf  
80103222:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
80103223:	f6 c4 02             	test   $0x2,%ah
80103226:	75 5e                	jne    80103286 <mycpu+0x6a>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
80103228:	e8 1f f2 ff ff       	call   8010244c <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
8010322d:	8b 35 00 1d 11 80    	mov    0x80111d00,%esi
80103233:	85 f6                	test   %esi,%esi
80103235:	7e 42                	jle    80103279 <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103237:	0f b6 15 80 17 11 80 	movzbl 0x80111780,%edx
8010323e:	39 c2                	cmp    %eax,%edx
80103240:	74 33                	je     80103275 <mycpu+0x59>
80103242:	b9 30 18 11 80       	mov    $0x80111830,%ecx
80103247:	31 d2                	xor    %edx,%edx
80103249:	8d 76 00             	lea    0x0(%esi),%esi
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
8010324c:	42                   	inc    %edx
8010324d:	39 f2                	cmp    %esi,%edx
8010324f:	74 28                	je     80103279 <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103251:	0f b6 19             	movzbl (%ecx),%ebx
80103254:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
8010325a:	39 c3                	cmp    %eax,%ebx
8010325c:	75 ee                	jne    8010324c <mycpu+0x30>
      return &cpus[i];
8010325e:	8d 04 92             	lea    (%edx,%edx,4),%eax
80103261:	01 c0                	add    %eax,%eax
80103263:	01 d0                	add    %edx,%eax
80103265:	c1 e0 04             	shl    $0x4,%eax
80103268:	8d 80 80 17 11 80    	lea    -0x7feee880(%eax),%eax
  }
  panic("unknown apicid\n");
}
8010326e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103271:	5b                   	pop    %ebx
80103272:	5e                   	pop    %esi
80103273:	5d                   	pop    %ebp
80103274:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103275:	31 d2                	xor    %edx,%edx
80103277:	eb e5                	jmp    8010325e <mycpu+0x42>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
80103279:	83 ec 0c             	sub    $0xc,%esp
8010327c:	68 d5 69 10 80       	push   $0x801069d5
80103281:	e8 b2 d0 ff ff       	call   80100338 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
80103286:	83 ec 0c             	sub    $0xc,%esp
80103289:	68 b0 6a 10 80       	push   $0x80106ab0
8010328e:	e8 a5 d0 ff ff       	call   80100338 <panic>
80103293:	90                   	nop

80103294 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
80103294:	55                   	push   %ebp
80103295:	89 e5                	mov    %esp,%ebp
80103297:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
8010329a:	e8 7d ff ff ff       	call   8010321c <mycpu>
8010329f:	2d 80 17 11 80       	sub    $0x80111780,%eax
801032a4:	c1 f8 04             	sar    $0x4,%eax
801032a7:	8d 0c c0             	lea    (%eax,%eax,8),%ecx
801032aa:	89 ca                	mov    %ecx,%edx
801032ac:	c1 e2 05             	shl    $0x5,%edx
801032af:	29 ca                	sub    %ecx,%edx
801032b1:	8d 14 90             	lea    (%eax,%edx,4),%edx
801032b4:	8d 0c d0             	lea    (%eax,%edx,8),%ecx
801032b7:	89 ca                	mov    %ecx,%edx
801032b9:	c1 e2 0f             	shl    $0xf,%edx
801032bc:	29 ca                	sub    %ecx,%edx
801032be:	8d 04 90             	lea    (%eax,%edx,4),%eax
801032c1:	f7 d8                	neg    %eax
}
801032c3:	c9                   	leave  
801032c4:	c3                   	ret    
801032c5:	8d 76 00             	lea    0x0(%esi),%esi

801032c8 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
801032c8:	55                   	push   %ebp
801032c9:	89 e5                	mov    %esp,%ebp
801032cb:	53                   	push   %ebx
801032cc:	50                   	push   %eax
  struct cpu *c;
  struct proc *p;
  pushcli();
801032cd:	e8 6e 09 00 00       	call   80103c40 <pushcli>
  c = mycpu();
801032d2:	e8 45 ff ff ff       	call   8010321c <mycpu>
  p = c->proc;
801032d7:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801032dd:	e8 06 0a 00 00       	call   80103ce8 <popcli>
  return p;
}
801032e2:	89 d8                	mov    %ebx,%eax
801032e4:	5a                   	pop    %edx
801032e5:	5b                   	pop    %ebx
801032e6:	5d                   	pop    %ebp
801032e7:	c3                   	ret    

801032e8 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
801032e8:	55                   	push   %ebp
801032e9:	89 e5                	mov    %esp,%ebp
801032eb:	53                   	push   %ebx
801032ec:	51                   	push   %ecx
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
801032ed:	e8 f2 fd ff ff       	call   801030e4 <allocproc>
801032f2:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
801032f4:	a3 b8 95 10 80       	mov    %eax,0x801095b8
  if((p->pgdir = setupkvm()) == 0)
801032f9:	e8 12 2f 00 00       	call   80106210 <setupkvm>
801032fe:	89 43 04             	mov    %eax,0x4(%ebx)
80103301:	85 c0                	test   %eax,%eax
80103303:	0f 84 b3 00 00 00    	je     801033bc <userinit+0xd4>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103309:	52                   	push   %edx
8010330a:	68 2c 00 00 00       	push   $0x2c
8010330f:	68 60 94 10 80       	push   $0x80109460
80103314:	50                   	push   %eax
80103315:	e8 66 2c 00 00       	call   80105f80 <inituvm>
  p->sz = PGSIZE;
8010331a:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103320:	83 c4 0c             	add    $0xc,%esp
80103323:	6a 4c                	push   $0x4c
80103325:	6a 00                	push   $0x0
80103327:	ff 73 18             	pushl  0x18(%ebx)
8010332a:	e8 69 0a 00 00       	call   80103d98 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010332f:	8b 43 18             	mov    0x18(%ebx),%eax
80103332:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103338:	8b 43 18             	mov    0x18(%ebx),%eax
8010333b:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103341:	8b 43 18             	mov    0x18(%ebx),%eax
80103344:	8b 50 2c             	mov    0x2c(%eax),%edx
80103347:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
8010334b:	8b 43 18             	mov    0x18(%ebx),%eax
8010334e:	8b 50 2c             	mov    0x2c(%eax),%edx
80103351:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103355:	8b 43 18             	mov    0x18(%ebx),%eax
80103358:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
8010335f:	8b 43 18             	mov    0x18(%ebx),%eax
80103362:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103369:	8b 43 18             	mov    0x18(%ebx),%eax
8010336c:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103373:	83 c4 0c             	add    $0xc,%esp
80103376:	6a 10                	push   $0x10
80103378:	68 fe 69 10 80       	push   $0x801069fe
8010337d:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103380:	50                   	push   %eax
80103381:	e8 9e 0b 00 00       	call   80103f24 <safestrcpy>
  p->cwd = namei("/");
80103386:	c7 04 24 07 6a 10 80 	movl   $0x80106a07,(%esp)
8010338d:	e8 22 e9 ff ff       	call   80101cb4 <namei>
80103392:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80103395:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
8010339c:	e8 d7 08 00 00       	call   80103c78 <acquire>

  p->state = RUNNABLE;
801033a1:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
801033a8:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801033af:	e8 98 09 00 00       	call   80103d4c <release>
801033b4:	83 c4 10             	add    $0x10,%esp
}
801033b7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801033ba:	c9                   	leave  
801033bb:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
801033bc:	83 ec 0c             	sub    $0xc,%esp
801033bf:	68 e5 69 10 80       	push   $0x801069e5
801033c4:	e8 6f cf ff ff       	call   80100338 <panic>
801033c9:	8d 76 00             	lea    0x0(%esi),%esi

801033cc <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
801033cc:	55                   	push   %ebp
801033cd:	89 e5                	mov    %esp,%ebp
801033cf:	53                   	push   %ebx
801033d0:	53                   	push   %ebx
  uint sz;
  struct proc *curproc = myproc();
801033d1:	e8 f2 fe ff ff       	call   801032c8 <myproc>
801033d6:	89 c3                	mov    %eax,%ebx

  sz = curproc->sz;
801033d8:	8b 00                	mov    (%eax),%eax
  if(n > 0){
801033da:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801033de:	7e 2c                	jle    8010340c <growproc+0x40>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801033e0:	51                   	push   %ecx
801033e1:	8b 55 08             	mov    0x8(%ebp),%edx
801033e4:	01 c2                	add    %eax,%edx
801033e6:	52                   	push   %edx
801033e7:	50                   	push   %eax
801033e8:	ff 73 04             	pushl  0x4(%ebx)
801033eb:	e8 b4 2c 00 00       	call   801060a4 <allocuvm>
801033f0:	83 c4 10             	add    $0x10,%esp
801033f3:	85 c0                	test   %eax,%eax
801033f5:	74 31                	je     80103428 <growproc+0x5c>
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
801033f7:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801033f9:	83 ec 0c             	sub    $0xc,%esp
801033fc:	53                   	push   %ebx
801033fd:	e8 7e 2a 00 00       	call   80105e80 <switchuvm>
  return 0;
80103402:	83 c4 10             	add    $0x10,%esp
80103405:	31 c0                	xor    %eax,%eax
}
80103407:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010340a:	c9                   	leave  
8010340b:	c3                   	ret    

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
8010340c:	74 e9                	je     801033f7 <growproc+0x2b>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
8010340e:	52                   	push   %edx
8010340f:	8b 55 08             	mov    0x8(%ebp),%edx
80103412:	01 c2                	add    %eax,%edx
80103414:	52                   	push   %edx
80103415:	50                   	push   %eax
80103416:	ff 73 04             	pushl  0x4(%ebx)
80103419:	e8 66 2d 00 00       	call   80106184 <deallocuvm>
8010341e:	83 c4 10             	add    $0x10,%esp
80103421:	85 c0                	test   %eax,%eax
80103423:	75 d2                	jne    801033f7 <growproc+0x2b>
80103425:	8d 76 00             	lea    0x0(%esi),%esi
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
80103428:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010342d:	eb d8                	jmp    80103407 <growproc+0x3b>
8010342f:	90                   	nop

80103430 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103430:	55                   	push   %ebp
80103431:	89 e5                	mov    %esp,%ebp
80103433:	57                   	push   %edi
80103434:	56                   	push   %esi
80103435:	53                   	push   %ebx
80103436:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();
80103439:	e8 8a fe ff ff       	call   801032c8 <myproc>
8010343e:	89 c3                	mov    %eax,%ebx

  // Allocate process.
  if((np = allocproc()) == 0){
80103440:	e8 9f fc ff ff       	call   801030e4 <allocproc>
80103445:	89 c7                	mov    %eax,%edi
80103447:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010344a:	85 c0                	test   %eax,%eax
8010344c:	0f 84 b5 00 00 00    	je     80103507 <fork+0xd7>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103452:	83 ec 08             	sub    $0x8,%esp
80103455:	ff 33                	pushl  (%ebx)
80103457:	ff 73 04             	pushl  0x4(%ebx)
8010345a:	e8 71 2e 00 00       	call   801062d0 <copyuvm>
8010345f:	89 47 04             	mov    %eax,0x4(%edi)
80103462:	83 c4 10             	add    $0x10,%esp
80103465:	85 c0                	test   %eax,%eax
80103467:	0f 84 a1 00 00 00    	je     8010350e <fork+0xde>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
8010346d:	8b 03                	mov    (%ebx),%eax
8010346f:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103472:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103474:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103477:	89 c8                	mov    %ecx,%eax
80103479:	8b 79 18             	mov    0x18(%ecx),%edi
8010347c:	8b 73 18             	mov    0x18(%ebx),%esi
8010347f:	b9 13 00 00 00       	mov    $0x13,%ecx
80103484:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103486:	8b 40 18             	mov    0x18(%eax),%eax
80103489:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
80103490:	31 f6                	xor    %esi,%esi
80103492:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[i])
80103494:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103498:	85 c0                	test   %eax,%eax
8010349a:	74 13                	je     801034af <fork+0x7f>
      np->ofile[i] = filedup(curproc->ofile[i]);
8010349c:	83 ec 0c             	sub    $0xc,%esp
8010349f:	50                   	push   %eax
801034a0:	e8 47 d8 ff ff       	call   80100cec <filedup>
801034a5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801034a8:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
801034ac:	83 c4 10             	add    $0x10,%esp
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
801034af:	46                   	inc    %esi
801034b0:	83 fe 10             	cmp    $0x10,%esi
801034b3:	75 df                	jne    80103494 <fork+0x64>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
801034b5:	83 ec 0c             	sub    $0xc,%esp
801034b8:	ff 73 68             	pushl  0x68(%ebx)
801034bb:	e8 e8 df ff ff       	call   801014a8 <idup>
801034c0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801034c3:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801034c6:	83 c4 0c             	add    $0xc,%esp
801034c9:	6a 10                	push   $0x10
801034cb:	83 c3 6c             	add    $0x6c,%ebx
801034ce:	53                   	push   %ebx
801034cf:	8d 47 6c             	lea    0x6c(%edi),%eax
801034d2:	50                   	push   %eax
801034d3:	e8 4c 0a 00 00       	call   80103f24 <safestrcpy>

  pid = np->pid;
801034d8:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
801034db:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801034e2:	e8 91 07 00 00       	call   80103c78 <acquire>

  np->state = RUNNABLE;
801034e7:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
801034ee:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801034f5:	e8 52 08 00 00       	call   80103d4c <release>

  return pid;
801034fa:	83 c4 10             	add    $0x10,%esp
801034fd:	89 d8                	mov    %ebx,%eax
}
801034ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103502:	5b                   	pop    %ebx
80103503:	5e                   	pop    %esi
80103504:	5f                   	pop    %edi
80103505:	5d                   	pop    %ebp
80103506:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103507:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010350c:	eb f1                	jmp    801034ff <fork+0xcf>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
8010350e:	83 ec 0c             	sub    $0xc,%esp
80103511:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103514:	ff 77 08             	pushl  0x8(%edi)
80103517:	e8 28 eb ff ff       	call   80102044 <kfree>
    np->kstack = 0;
8010351c:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103523:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
8010352a:	83 c4 10             	add    $0x10,%esp
8010352d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103532:	eb cb                	jmp    801034ff <fork+0xcf>

80103534 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103534:	55                   	push   %ebp
80103535:	89 e5                	mov    %esp,%ebp
80103537:	57                   	push   %edi
80103538:	56                   	push   %esi
80103539:	53                   	push   %ebx
8010353a:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p;
  struct cpu *c = mycpu();
8010353d:	e8 da fc ff ff       	call   8010321c <mycpu>
80103542:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103544:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
8010354b:	00 00 00 
8010354e:	8d 78 04             	lea    0x4(%eax),%edi
80103551:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103554:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103555:	83 ec 0c             	sub    $0xc,%esp
80103558:	68 20 1d 11 80       	push   $0x80111d20
8010355d:	e8 16 07 00 00       	call   80103c78 <acquire>
80103562:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103565:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
8010356a:	eb 0b                	jmp    80103577 <scheduler+0x43>
8010356c:	83 c3 7c             	add    $0x7c,%ebx
8010356f:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80103575:	74 45                	je     801035bc <scheduler+0x88>
      if(p->state != RUNNABLE)
80103577:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
8010357b:	75 ef                	jne    8010356c <scheduler+0x38>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
8010357d:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103583:	83 ec 0c             	sub    $0xc,%esp
80103586:	53                   	push   %ebx
80103587:	e8 f4 28 00 00       	call   80105e80 <switchuvm>
      p->state = RUNNING;
8010358c:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)

      swtch(&(c->scheduler), p->context);
80103593:	58                   	pop    %eax
80103594:	5a                   	pop    %edx
80103595:	ff 73 1c             	pushl  0x1c(%ebx)
80103598:	57                   	push   %edi
80103599:	e8 d3 09 00 00       	call   80103f71 <swtch>
      switchkvm();
8010359e:	e8 c9 28 00 00       	call   80105e6c <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
801035a3:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
801035aa:	00 00 00 
801035ad:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801035b0:	83 c3 7c             	add    $0x7c,%ebx
801035b3:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
801035b9:	75 bc                	jne    80103577 <scheduler+0x43>
801035bb:	90                   	nop

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
801035bc:	83 ec 0c             	sub    $0xc,%esp
801035bf:	68 20 1d 11 80       	push   $0x80111d20
801035c4:	e8 83 07 00 00       	call   80103d4c <release>

  }
801035c9:	83 c4 10             	add    $0x10,%esp
801035cc:	eb 86                	jmp    80103554 <scheduler+0x20>
801035ce:	66 90                	xchg   %ax,%ax

801035d0 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
801035d0:	55                   	push   %ebp
801035d1:	89 e5                	mov    %esp,%ebp
801035d3:	56                   	push   %esi
801035d4:	53                   	push   %ebx
  int intena;
  struct proc *p = myproc();
801035d5:	e8 ee fc ff ff       	call   801032c8 <myproc>
801035da:	89 c3                	mov    %eax,%ebx

  if(!holding(&ptable.lock))
801035dc:	83 ec 0c             	sub    $0xc,%esp
801035df:	68 20 1d 11 80       	push   $0x80111d20
801035e4:	e8 2f 06 00 00       	call   80103c18 <holding>
801035e9:	83 c4 10             	add    $0x10,%esp
801035ec:	85 c0                	test   %eax,%eax
801035ee:	74 4f                	je     8010363f <sched+0x6f>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
801035f0:	e8 27 fc ff ff       	call   8010321c <mycpu>
801035f5:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801035fc:	75 68                	jne    80103666 <sched+0x96>
    panic("sched locks");
  if(p->state == RUNNING)
801035fe:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103602:	74 55                	je     80103659 <sched+0x89>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103604:	9c                   	pushf  
80103605:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103606:	f6 c4 02             	test   $0x2,%ah
80103609:	75 41                	jne    8010364c <sched+0x7c>
    panic("sched interruptible");
  intena = mycpu()->intena;
8010360b:	e8 0c fc ff ff       	call   8010321c <mycpu>
80103610:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103616:	e8 01 fc ff ff       	call   8010321c <mycpu>
8010361b:	83 ec 08             	sub    $0x8,%esp
8010361e:	ff 70 04             	pushl  0x4(%eax)
80103621:	83 c3 1c             	add    $0x1c,%ebx
80103624:	53                   	push   %ebx
80103625:	e8 47 09 00 00       	call   80103f71 <swtch>
  mycpu()->intena = intena;
8010362a:	e8 ed fb ff ff       	call   8010321c <mycpu>
8010362f:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
80103635:	83 c4 10             	add    $0x10,%esp
}
80103638:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010363b:	5b                   	pop    %ebx
8010363c:	5e                   	pop    %esi
8010363d:	5d                   	pop    %ebp
8010363e:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
8010363f:	83 ec 0c             	sub    $0xc,%esp
80103642:	68 09 6a 10 80       	push   $0x80106a09
80103647:	e8 ec cc ff ff       	call   80100338 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
8010364c:	83 ec 0c             	sub    $0xc,%esp
8010364f:	68 35 6a 10 80       	push   $0x80106a35
80103654:	e8 df cc ff ff       	call   80100338 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80103659:	83 ec 0c             	sub    $0xc,%esp
8010365c:	68 27 6a 10 80       	push   $0x80106a27
80103661:	e8 d2 cc ff ff       	call   80100338 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80103666:	83 ec 0c             	sub    $0xc,%esp
80103669:	68 1b 6a 10 80       	push   $0x80106a1b
8010366e:	e8 c5 cc ff ff       	call   80100338 <panic>
80103673:	90                   	nop

80103674 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103674:	55                   	push   %ebp
80103675:	89 e5                	mov    %esp,%ebp
80103677:	57                   	push   %edi
80103678:	56                   	push   %esi
80103679:	53                   	push   %ebx
8010367a:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
8010367d:	e8 46 fc ff ff       	call   801032c8 <myproc>
80103682:	89 c6                	mov    %eax,%esi
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103684:	3b 05 b8 95 10 80    	cmp    0x801095b8,%eax
8010368a:	0f 84 e8 00 00 00    	je     80103778 <exit+0x104>
80103690:	8d 58 28             	lea    0x28(%eax),%ebx
80103693:	8d 78 68             	lea    0x68(%eax),%edi
80103696:	66 90                	xchg   %ax,%ax
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80103698:	8b 03                	mov    (%ebx),%eax
8010369a:	85 c0                	test   %eax,%eax
8010369c:	74 12                	je     801036b0 <exit+0x3c>
      fileclose(curproc->ofile[fd]);
8010369e:	83 ec 0c             	sub    $0xc,%esp
801036a1:	50                   	push   %eax
801036a2:	e8 89 d6 ff ff       	call   80100d30 <fileclose>
      curproc->ofile[fd] = 0;
801036a7:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801036ad:	83 c4 10             	add    $0x10,%esp
801036b0:	83 c3 04             	add    $0x4,%ebx

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
801036b3:	39 fb                	cmp    %edi,%ebx
801036b5:	75 e1                	jne    80103698 <exit+0x24>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
801036b7:	e8 ac f0 ff ff       	call   80102768 <begin_op>
  iput(curproc->cwd);
801036bc:	83 ec 0c             	sub    $0xc,%esp
801036bf:	ff 76 68             	pushl  0x68(%esi)
801036c2:	e8 19 df ff ff       	call   801015e0 <iput>
  end_op();
801036c7:	e8 04 f1 ff ff       	call   801027d0 <end_op>
  curproc->cwd = 0;
801036cc:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)

  acquire(&ptable.lock);
801036d3:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801036da:	e8 99 05 00 00       	call   80103c78 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
801036df:	8b 46 14             	mov    0x14(%esi),%eax
801036e2:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801036e5:	ba 54 1d 11 80       	mov    $0x80111d54,%edx
801036ea:	eb 0b                	jmp    801036f7 <exit+0x83>
801036ec:	83 c2 7c             	add    $0x7c,%edx
801036ef:	81 fa 54 3c 11 80    	cmp    $0x80113c54,%edx
801036f5:	74 1d                	je     80103714 <exit+0xa0>
    if(p->state == SLEEPING && p->chan == chan)
801036f7:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
801036fb:	75 ef                	jne    801036ec <exit+0x78>
801036fd:	3b 42 20             	cmp    0x20(%edx),%eax
80103700:	75 ea                	jne    801036ec <exit+0x78>
      p->state = RUNNABLE;
80103702:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103709:	83 c2 7c             	add    $0x7c,%edx
8010370c:	81 fa 54 3c 11 80    	cmp    $0x80113c54,%edx
80103712:	75 e3                	jne    801036f7 <exit+0x83>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103714:	a1 b8 95 10 80       	mov    0x801095b8,%eax
80103719:	b9 54 1d 11 80       	mov    $0x80111d54,%ecx
8010371e:	eb 0b                	jmp    8010372b <exit+0xb7>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103720:	83 c1 7c             	add    $0x7c,%ecx
80103723:	81 f9 54 3c 11 80    	cmp    $0x80113c54,%ecx
80103729:	74 34                	je     8010375f <exit+0xeb>
    if(p->parent == curproc){
8010372b:	39 71 14             	cmp    %esi,0x14(%ecx)
8010372e:	75 f0                	jne    80103720 <exit+0xac>
      p->parent = initproc;
80103730:	89 41 14             	mov    %eax,0x14(%ecx)
      if(p->state == ZOMBIE)
80103733:	83 79 0c 05          	cmpl   $0x5,0xc(%ecx)
80103737:	75 e7                	jne    80103720 <exit+0xac>
80103739:	ba 54 1d 11 80       	mov    $0x80111d54,%edx
8010373e:	eb 0b                	jmp    8010374b <exit+0xd7>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103740:	83 c2 7c             	add    $0x7c,%edx
80103743:	81 fa 54 3c 11 80    	cmp    $0x80113c54,%edx
80103749:	74 d5                	je     80103720 <exit+0xac>
    if(p->state == SLEEPING && p->chan == chan)
8010374b:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
8010374f:	75 ef                	jne    80103740 <exit+0xcc>
80103751:	3b 42 20             	cmp    0x20(%edx),%eax
80103754:	75 ea                	jne    80103740 <exit+0xcc>
      p->state = RUNNABLE;
80103756:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
8010375d:	eb e1                	jmp    80103740 <exit+0xcc>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
8010375f:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103766:	e8 65 fe ff ff       	call   801035d0 <sched>
  panic("zombie exit");
8010376b:	83 ec 0c             	sub    $0xc,%esp
8010376e:	68 56 6a 10 80       	push   $0x80106a56
80103773:	e8 c0 cb ff ff       	call   80100338 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");
80103778:	83 ec 0c             	sub    $0xc,%esp
8010377b:	68 49 6a 10 80       	push   $0x80106a49
80103780:	e8 b3 cb ff ff       	call   80100338 <panic>
80103785:	8d 76 00             	lea    0x0(%esi),%esi

80103788 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103788:	55                   	push   %ebp
80103789:	89 e5                	mov    %esp,%ebp
8010378b:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
8010378e:	68 20 1d 11 80       	push   $0x80111d20
80103793:	e8 e0 04 00 00       	call   80103c78 <acquire>
  myproc()->state = RUNNABLE;
80103798:	e8 2b fb ff ff       	call   801032c8 <myproc>
8010379d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
801037a4:	e8 27 fe ff ff       	call   801035d0 <sched>
  release(&ptable.lock);
801037a9:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801037b0:	e8 97 05 00 00       	call   80103d4c <release>
801037b5:	83 c4 10             	add    $0x10,%esp
}
801037b8:	c9                   	leave  
801037b9:	c3                   	ret    
801037ba:	66 90                	xchg   %ax,%ax

801037bc <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
801037bc:	55                   	push   %ebp
801037bd:	89 e5                	mov    %esp,%ebp
801037bf:	57                   	push   %edi
801037c0:	56                   	push   %esi
801037c1:	53                   	push   %ebx
801037c2:	83 ec 0c             	sub    $0xc,%esp
801037c5:	8b 7d 08             	mov    0x8(%ebp),%edi
801037c8:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct proc *p = myproc();
801037cb:	e8 f8 fa ff ff       	call   801032c8 <myproc>
801037d0:	89 c3                	mov    %eax,%ebx
  
  if(p == 0)
801037d2:	85 c0                	test   %eax,%eax
801037d4:	0f 84 81 00 00 00    	je     8010385b <sleep+0x9f>
    panic("sleep");

  if(lk == 0)
801037da:	85 f6                	test   %esi,%esi
801037dc:	74 70                	je     8010384e <sleep+0x92>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
801037de:	81 fe 20 1d 11 80    	cmp    $0x80111d20,%esi
801037e4:	74 4a                	je     80103830 <sleep+0x74>
    acquire(&ptable.lock);  //DOC: sleeplock1
801037e6:	83 ec 0c             	sub    $0xc,%esp
801037e9:	68 20 1d 11 80       	push   $0x80111d20
801037ee:	e8 85 04 00 00       	call   80103c78 <acquire>
    release(lk);
801037f3:	89 34 24             	mov    %esi,(%esp)
801037f6:	e8 51 05 00 00       	call   80103d4c <release>
  }
  // Go to sleep.
  p->chan = chan;
801037fb:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801037fe:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103805:	e8 c6 fd ff ff       	call   801035d0 <sched>

  // Tidy up.
  p->chan = 0;
8010380a:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80103811:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103818:	e8 2f 05 00 00       	call   80103d4c <release>
    acquire(lk);
8010381d:	83 c4 10             	add    $0x10,%esp
80103820:	89 75 08             	mov    %esi,0x8(%ebp)
  }
}
80103823:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103826:	5b                   	pop    %ebx
80103827:	5e                   	pop    %esi
80103828:	5f                   	pop    %edi
80103829:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
8010382a:	e9 49 04 00 00       	jmp    80103c78 <acquire>
8010382f:	90                   	nop
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
80103830:	89 78 20             	mov    %edi,0x20(%eax)
  p->state = SLEEPING;
80103833:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)

  sched();
8010383a:	e8 91 fd ff ff       	call   801035d0 <sched>

  // Tidy up.
  p->chan = 0;
8010383f:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80103846:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103849:	5b                   	pop    %ebx
8010384a:	5e                   	pop    %esi
8010384b:	5f                   	pop    %edi
8010384c:	5d                   	pop    %ebp
8010384d:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
8010384e:	83 ec 0c             	sub    $0xc,%esp
80103851:	68 68 6a 10 80       	push   $0x80106a68
80103856:	e8 dd ca ff ff       	call   80100338 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
8010385b:	83 ec 0c             	sub    $0xc,%esp
8010385e:	68 62 6a 10 80       	push   $0x80106a62
80103863:	e8 d0 ca ff ff       	call   80100338 <panic>

80103868 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80103868:	55                   	push   %ebp
80103869:	89 e5                	mov    %esp,%ebp
8010386b:	56                   	push   %esi
8010386c:	53                   	push   %ebx
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
8010386d:	e8 56 fa ff ff       	call   801032c8 <myproc>
80103872:	89 c6                	mov    %eax,%esi
  
  acquire(&ptable.lock);
80103874:	83 ec 0c             	sub    $0xc,%esp
80103877:	68 20 1d 11 80       	push   $0x80111d20
8010387c:	e8 f7 03 00 00       	call   80103c78 <acquire>
80103881:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80103884:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103886:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
8010388b:	eb 0e                	jmp    8010389b <wait+0x33>
8010388d:	8d 76 00             	lea    0x0(%esi),%esi
80103890:	83 c3 7c             	add    $0x7c,%ebx
80103893:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80103899:	74 1d                	je     801038b8 <wait+0x50>
      if(p->parent != curproc)
8010389b:	39 73 14             	cmp    %esi,0x14(%ebx)
8010389e:	75 f0                	jne    80103890 <wait+0x28>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
801038a0:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801038a4:	74 30                	je     801038d6 <wait+0x6e>
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != curproc)
        continue;
      havekids = 1;
801038a6:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801038ab:	83 c3 7c             	add    $0x7c,%ebx
801038ae:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
801038b4:	75 e5                	jne    8010389b <wait+0x33>
801038b6:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
801038b8:	85 c0                	test   %eax,%eax
801038ba:	74 70                	je     8010392c <wait+0xc4>
801038bc:	8b 46 24             	mov    0x24(%esi),%eax
801038bf:	85 c0                	test   %eax,%eax
801038c1:	75 69                	jne    8010392c <wait+0xc4>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
801038c3:	83 ec 08             	sub    $0x8,%esp
801038c6:	68 20 1d 11 80       	push   $0x80111d20
801038cb:	56                   	push   %esi
801038cc:	e8 eb fe ff ff       	call   801037bc <sleep>
  }
801038d1:	83 c4 10             	add    $0x10,%esp
801038d4:	eb ae                	jmp    80103884 <wait+0x1c>
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
801038d6:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801038d9:	83 ec 0c             	sub    $0xc,%esp
801038dc:	ff 73 08             	pushl  0x8(%ebx)
801038df:	e8 60 e7 ff ff       	call   80102044 <kfree>
        p->kstack = 0;
801038e4:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801038eb:	5a                   	pop    %edx
801038ec:	ff 73 04             	pushl  0x4(%ebx)
801038ef:	e8 ac 28 00 00       	call   801061a0 <freevm>
        p->pid = 0;
801038f4:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801038fb:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103902:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103906:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
8010390d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103914:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
8010391b:	e8 2c 04 00 00       	call   80103d4c <release>
        return pid;
80103920:	83 c4 10             	add    $0x10,%esp
80103923:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103925:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103928:	5b                   	pop    %ebx
80103929:	5e                   	pop    %esi
8010392a:	5d                   	pop    %ebp
8010392b:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
8010392c:	83 ec 0c             	sub    $0xc,%esp
8010392f:	68 20 1d 11 80       	push   $0x80111d20
80103934:	e8 13 04 00 00       	call   80103d4c <release>
      return -1;
80103939:	83 c4 10             	add    $0x10,%esp
8010393c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103941:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103944:	5b                   	pop    %ebx
80103945:	5e                   	pop    %esi
80103946:	5d                   	pop    %ebp
80103947:	c3                   	ret    

80103948 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103948:	55                   	push   %ebp
80103949:	89 e5                	mov    %esp,%ebp
8010394b:	53                   	push   %ebx
8010394c:	83 ec 10             	sub    $0x10,%esp
8010394f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103952:	68 20 1d 11 80       	push   $0x80111d20
80103957:	e8 1c 03 00 00       	call   80103c78 <acquire>
8010395c:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010395f:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
80103964:	eb 0c                	jmp    80103972 <wakeup+0x2a>
80103966:	66 90                	xchg   %ax,%ax
80103968:	83 c0 7c             	add    $0x7c,%eax
8010396b:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103970:	74 1e                	je     80103990 <wakeup+0x48>
    if(p->state == SLEEPING && p->chan == chan)
80103972:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103976:	75 f0                	jne    80103968 <wakeup+0x20>
80103978:	3b 58 20             	cmp    0x20(%eax),%ebx
8010397b:	75 eb                	jne    80103968 <wakeup+0x20>
      p->state = RUNNABLE;
8010397d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103984:	83 c0 7c             	add    $0x7c,%eax
80103987:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
8010398c:	75 e4                	jne    80103972 <wakeup+0x2a>
8010398e:	66 90                	xchg   %ax,%ax
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80103990:	c7 45 08 20 1d 11 80 	movl   $0x80111d20,0x8(%ebp)
}
80103997:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010399a:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
8010399b:	e9 ac 03 00 00       	jmp    80103d4c <release>

801039a0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801039a0:	55                   	push   %ebp
801039a1:	89 e5                	mov    %esp,%ebp
801039a3:	53                   	push   %ebx
801039a4:	83 ec 10             	sub    $0x10,%esp
801039a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801039aa:	68 20 1d 11 80       	push   $0x80111d20
801039af:	e8 c4 02 00 00       	call   80103c78 <acquire>
801039b4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801039b7:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
801039bc:	eb 0c                	jmp    801039ca <kill+0x2a>
801039be:	66 90                	xchg   %ax,%ax
801039c0:	83 c0 7c             	add    $0x7c,%eax
801039c3:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
801039c8:	74 36                	je     80103a00 <kill+0x60>
    if(p->pid == pid){
801039ca:	39 58 10             	cmp    %ebx,0x10(%eax)
801039cd:	75 f1                	jne    801039c0 <kill+0x20>
      p->killed = 1;
801039cf:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801039d6:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801039da:	74 18                	je     801039f4 <kill+0x54>
        p->state = RUNNABLE;
      release(&ptable.lock);
801039dc:	83 ec 0c             	sub    $0xc,%esp
801039df:	68 20 1d 11 80       	push   $0x80111d20
801039e4:	e8 63 03 00 00       	call   80103d4c <release>
      return 0;
801039e9:	83 c4 10             	add    $0x10,%esp
801039ec:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
801039ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039f1:	c9                   	leave  
801039f2:	c3                   	ret    
801039f3:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
801039f4:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801039fb:	eb df                	jmp    801039dc <kill+0x3c>
801039fd:	8d 76 00             	lea    0x0(%esi),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80103a00:	83 ec 0c             	sub    $0xc,%esp
80103a03:	68 20 1d 11 80       	push   $0x80111d20
80103a08:	e8 3f 03 00 00       	call   80103d4c <release>
  return -1;
80103a0d:	83 c4 10             	add    $0x10,%esp
80103a10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103a15:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a18:	c9                   	leave  
80103a19:	c3                   	ret    
80103a1a:	66 90                	xchg   %ax,%ax

80103a1c <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80103a1c:	55                   	push   %ebp
80103a1d:	89 e5                	mov    %esp,%ebp
80103a1f:	57                   	push   %edi
80103a20:	56                   	push   %esi
80103a21:	53                   	push   %ebx
80103a22:	83 ec 3c             	sub    $0x3c,%esp
80103a25:	bb c0 1d 11 80       	mov    $0x80111dc0,%ebx
80103a2a:	8d 75 e8             	lea    -0x18(%ebp),%esi
80103a2d:	eb 3f                	jmp    80103a6e <procdump+0x52>
80103a2f:	90                   	nop
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103a30:	8b 04 85 d8 6a 10 80 	mov    -0x7fef9528(,%eax,4),%eax
80103a37:	85 c0                	test   %eax,%eax
80103a39:	74 3f                	je     80103a7a <procdump+0x5e>
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
80103a3b:	53                   	push   %ebx
80103a3c:	50                   	push   %eax
80103a3d:	ff 73 a4             	pushl  -0x5c(%ebx)
80103a40:	68 7d 6a 10 80       	push   $0x80106a7d
80103a45:	e8 be cb ff ff       	call   80100608 <cprintf>
    if(p->state == SLEEPING){
80103a4a:	83 c4 10             	add    $0x10,%esp
80103a4d:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80103a51:	74 31                	je     80103a84 <procdump+0x68>
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80103a53:	83 ec 0c             	sub    $0xc,%esp
80103a56:	68 fb 6d 10 80       	push   $0x80106dfb
80103a5b:	e8 a8 cb ff ff       	call   80100608 <cprintf>
80103a60:	83 c4 10             	add    $0x10,%esp
80103a63:	83 c3 7c             	add    $0x7c,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103a66:	81 fb c0 3c 11 80    	cmp    $0x80113cc0,%ebx
80103a6c:	74 52                	je     80103ac0 <procdump+0xa4>
    if(p->state == UNUSED)
80103a6e:	8b 43 a0             	mov    -0x60(%ebx),%eax
80103a71:	85 c0                	test   %eax,%eax
80103a73:	74 ee                	je     80103a63 <procdump+0x47>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103a75:	83 f8 05             	cmp    $0x5,%eax
80103a78:	76 b6                	jbe    80103a30 <procdump+0x14>
      state = states[p->state];
    else
      state = "???";
80103a7a:	b8 79 6a 10 80       	mov    $0x80106a79,%eax
80103a7f:	eb ba                	jmp    80103a3b <procdump+0x1f>
80103a81:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
80103a84:	83 ec 08             	sub    $0x8,%esp
80103a87:	8d 45 c0             	lea    -0x40(%ebp),%eax
80103a8a:	50                   	push   %eax
80103a8b:	8b 43 b0             	mov    -0x50(%ebx),%eax
80103a8e:	8b 40 0c             	mov    0xc(%eax),%eax
80103a91:	83 c0 08             	add    $0x8,%eax
80103a94:	50                   	push   %eax
80103a95:	e8 36 01 00 00       	call   80103bd0 <getcallerpcs>
80103a9a:	8d 7d c0             	lea    -0x40(%ebp),%edi
80103a9d:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80103aa0:	8b 17                	mov    (%edi),%edx
80103aa2:	85 d2                	test   %edx,%edx
80103aa4:	74 ad                	je     80103a53 <procdump+0x37>
        cprintf(" %p", pc[i]);
80103aa6:	83 ec 08             	sub    $0x8,%esp
80103aa9:	52                   	push   %edx
80103aaa:	68 a1 64 10 80       	push   $0x801064a1
80103aaf:	e8 54 cb ff ff       	call   80100608 <cprintf>
80103ab4:	83 c7 04             	add    $0x4,%edi
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80103ab7:	83 c4 10             	add    $0x10,%esp
80103aba:	39 f7                	cmp    %esi,%edi
80103abc:	75 e2                	jne    80103aa0 <procdump+0x84>
80103abe:	eb 93                	jmp    80103a53 <procdump+0x37>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80103ac0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ac3:	5b                   	pop    %ebx
80103ac4:	5e                   	pop    %esi
80103ac5:	5f                   	pop    %edi
80103ac6:	5d                   	pop    %ebp
80103ac7:	c3                   	ret    

80103ac8 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80103ac8:	55                   	push   %ebp
80103ac9:	89 e5                	mov    %esp,%ebp
80103acb:	53                   	push   %ebx
80103acc:	83 ec 0c             	sub    $0xc,%esp
80103acf:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80103ad2:	68 f0 6a 10 80       	push   $0x80106af0
80103ad7:	8d 43 04             	lea    0x4(%ebx),%eax
80103ada:	50                   	push   %eax
80103adb:	e8 d4 00 00 00       	call   80103bb4 <initlock>
  lk->name = name;
80103ae0:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ae3:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
80103ae6:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80103aec:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
80103af3:	83 c4 10             	add    $0x10,%esp
}
80103af6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103af9:	c9                   	leave  
80103afa:	c3                   	ret    
80103afb:	90                   	nop

80103afc <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80103afc:	55                   	push   %ebp
80103afd:	89 e5                	mov    %esp,%ebp
80103aff:	56                   	push   %esi
80103b00:	53                   	push   %ebx
80103b01:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80103b04:	8d 73 04             	lea    0x4(%ebx),%esi
80103b07:	83 ec 0c             	sub    $0xc,%esp
80103b0a:	56                   	push   %esi
80103b0b:	e8 68 01 00 00       	call   80103c78 <acquire>
  while (lk->locked) {
80103b10:	83 c4 10             	add    $0x10,%esp
80103b13:	8b 13                	mov    (%ebx),%edx
80103b15:	85 d2                	test   %edx,%edx
80103b17:	74 16                	je     80103b2f <acquiresleep+0x33>
80103b19:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80103b1c:	83 ec 08             	sub    $0x8,%esp
80103b1f:	56                   	push   %esi
80103b20:	53                   	push   %ebx
80103b21:	e8 96 fc ff ff       	call   801037bc <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
80103b26:	83 c4 10             	add    $0x10,%esp
80103b29:	8b 03                	mov    (%ebx),%eax
80103b2b:	85 c0                	test   %eax,%eax
80103b2d:	75 ed                	jne    80103b1c <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80103b2f:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80103b35:	e8 8e f7 ff ff       	call   801032c8 <myproc>
80103b3a:	8b 40 10             	mov    0x10(%eax),%eax
80103b3d:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80103b40:	89 75 08             	mov    %esi,0x8(%ebp)
}
80103b43:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b46:	5b                   	pop    %ebx
80103b47:	5e                   	pop    %esi
80103b48:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
80103b49:	e9 fe 01 00 00       	jmp    80103d4c <release>
80103b4e:	66 90                	xchg   %ax,%ax

80103b50 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
80103b50:	55                   	push   %ebp
80103b51:	89 e5                	mov    %esp,%ebp
80103b53:	56                   	push   %esi
80103b54:	53                   	push   %ebx
80103b55:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80103b58:	8d 73 04             	lea    0x4(%ebx),%esi
80103b5b:	83 ec 0c             	sub    $0xc,%esp
80103b5e:	56                   	push   %esi
80103b5f:	e8 14 01 00 00       	call   80103c78 <acquire>
  lk->locked = 0;
80103b64:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80103b6a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80103b71:	89 1c 24             	mov    %ebx,(%esp)
80103b74:	e8 cf fd ff ff       	call   80103948 <wakeup>
  release(&lk->lk);
80103b79:	83 c4 10             	add    $0x10,%esp
80103b7c:	89 75 08             	mov    %esi,0x8(%ebp)
}
80103b7f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b82:	5b                   	pop    %ebx
80103b83:	5e                   	pop    %esi
80103b84:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80103b85:	e9 c2 01 00 00       	jmp    80103d4c <release>
80103b8a:	66 90                	xchg   %ax,%ax

80103b8c <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
80103b8c:	55                   	push   %ebp
80103b8d:	89 e5                	mov    %esp,%ebp
80103b8f:	56                   	push   %esi
80103b90:	53                   	push   %ebx
80103b91:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
80103b94:	8d 5e 04             	lea    0x4(%esi),%ebx
80103b97:	83 ec 0c             	sub    $0xc,%esp
80103b9a:	53                   	push   %ebx
80103b9b:	e8 d8 00 00 00       	call   80103c78 <acquire>
  r = lk->locked;
80103ba0:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
80103ba2:	89 1c 24             	mov    %ebx,(%esp)
80103ba5:	e8 a2 01 00 00       	call   80103d4c <release>
  return r;
}
80103baa:	89 f0                	mov    %esi,%eax
80103bac:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103baf:	5b                   	pop    %ebx
80103bb0:	5e                   	pop    %esi
80103bb1:	5d                   	pop    %ebp
80103bb2:	c3                   	ret    
80103bb3:	90                   	nop

80103bb4 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80103bb4:	55                   	push   %ebp
80103bb5:	89 e5                	mov    %esp,%ebp
80103bb7:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80103bba:	8b 55 0c             	mov    0xc(%ebp),%edx
80103bbd:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80103bc0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80103bc6:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80103bcd:	5d                   	pop    %ebp
80103bce:	c3                   	ret    
80103bcf:	90                   	nop

80103bd0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80103bd0:	55                   	push   %ebp
80103bd1:	89 e5                	mov    %esp,%ebp
80103bd3:	53                   	push   %ebx
80103bd4:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80103bd7:	8b 45 08             	mov    0x8(%ebp),%eax
80103bda:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80103bdd:	31 d2                	xor    %edx,%edx
80103bdf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80103be0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80103be6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80103bec:	77 12                	ja     80103c00 <getcallerpcs+0x30>
      break;
    pcs[i] = ebp[1];     // saved %eip
80103bee:	8b 58 04             	mov    0x4(%eax),%ebx
80103bf1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
    ebp = (uint*)ebp[0]; // saved %ebp
80103bf4:	8b 00                	mov    (%eax),%eax
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80103bf6:	42                   	inc    %edx
80103bf7:	83 fa 0a             	cmp    $0xa,%edx
80103bfa:	75 e4                	jne    80103be0 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80103bfc:	5b                   	pop    %ebx
80103bfd:	5d                   	pop    %ebp
80103bfe:	c3                   	ret    
80103bff:	90                   	nop
80103c00:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80103c03:	8d 51 28             	lea    0x28(%ecx),%edx
80103c06:	66 90                	xchg   %ax,%ax
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80103c08:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103c0e:	83 c0 04             	add    $0x4,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80103c11:	39 d0                	cmp    %edx,%eax
80103c13:	75 f3                	jne    80103c08 <getcallerpcs+0x38>
    pcs[i] = 0;
}
80103c15:	5b                   	pop    %ebx
80103c16:	5d                   	pop    %ebp
80103c17:	c3                   	ret    

80103c18 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80103c18:	55                   	push   %ebp
80103c19:	89 e5                	mov    %esp,%ebp
80103c1b:	53                   	push   %ebx
80103c1c:	51                   	push   %ecx
80103c1d:	8b 45 08             	mov    0x8(%ebp),%eax
  return lock->locked && lock->cpu == mycpu();
80103c20:	8b 18                	mov    (%eax),%ebx
80103c22:	85 db                	test   %ebx,%ebx
80103c24:	75 06                	jne    80103c2c <holding+0x14>
80103c26:	31 c0                	xor    %eax,%eax
}
80103c28:	5a                   	pop    %edx
80103c29:	5b                   	pop    %ebx
80103c2a:	5d                   	pop    %ebp
80103c2b:	c3                   	ret    

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80103c2c:	8b 58 08             	mov    0x8(%eax),%ebx
80103c2f:	e8 e8 f5 ff ff       	call   8010321c <mycpu>
80103c34:	39 c3                	cmp    %eax,%ebx
80103c36:	0f 94 c0             	sete   %al
80103c39:	0f b6 c0             	movzbl %al,%eax
}
80103c3c:	5a                   	pop    %edx
80103c3d:	5b                   	pop    %ebx
80103c3e:	5d                   	pop    %ebp
80103c3f:	c3                   	ret    

80103c40 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80103c40:	55                   	push   %ebp
80103c41:	89 e5                	mov    %esp,%ebp
80103c43:	53                   	push   %ebx
80103c44:	52                   	push   %edx
80103c45:	9c                   	pushf  
80103c46:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
80103c47:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80103c48:	e8 cf f5 ff ff       	call   8010321c <mycpu>
80103c4d:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80103c53:	85 c9                	test   %ecx,%ecx
80103c55:	75 11                	jne    80103c68 <pushcli+0x28>
    mycpu()->intena = eflags & FL_IF;
80103c57:	e8 c0 f5 ff ff       	call   8010321c <mycpu>
80103c5c:	81 e3 00 02 00 00    	and    $0x200,%ebx
80103c62:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
80103c68:	e8 af f5 ff ff       	call   8010321c <mycpu>
80103c6d:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
80103c73:	58                   	pop    %eax
80103c74:	5b                   	pop    %ebx
80103c75:	5d                   	pop    %ebp
80103c76:	c3                   	ret    
80103c77:	90                   	nop

80103c78 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80103c78:	55                   	push   %ebp
80103c79:	89 e5                	mov    %esp,%ebp
80103c7b:	53                   	push   %ebx
80103c7c:	50                   	push   %eax
  pushcli(); // disable interrupts to avoid deadlock.
80103c7d:	e8 be ff ff ff       	call   80103c40 <pushcli>
  if(holding(lk))
80103c82:	8b 55 08             	mov    0x8(%ebp),%edx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80103c85:	8b 0a                	mov    (%edx),%ecx
80103c87:	85 c9                	test   %ecx,%ecx
80103c89:	75 3d                	jne    80103cc8 <acquire+0x50>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103c8b:	b9 01 00 00 00       	mov    $0x1,%ecx
80103c90:	eb 05                	jmp    80103c97 <acquire+0x1f>
80103c92:	66 90                	xchg   %ax,%ax
80103c94:	8b 55 08             	mov    0x8(%ebp),%edx
80103c97:	89 c8                	mov    %ecx,%eax
80103c99:	f0 87 02             	lock xchg %eax,(%edx)
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80103c9c:	85 c0                	test   %eax,%eax
80103c9e:	75 f4                	jne    80103c94 <acquire+0x1c>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
80103ca0:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80103ca5:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103ca8:	e8 6f f5 ff ff       	call   8010321c <mycpu>
80103cad:	89 43 08             	mov    %eax,0x8(%ebx)
  getcallerpcs(&lk, lk->pcs);
80103cb0:	83 ec 08             	sub    $0x8,%esp
80103cb3:	8b 45 08             	mov    0x8(%ebp),%eax
80103cb6:	83 c0 0c             	add    $0xc,%eax
80103cb9:	50                   	push   %eax
80103cba:	8d 45 08             	lea    0x8(%ebp),%eax
80103cbd:	50                   	push   %eax
80103cbe:	e8 0d ff ff ff       	call   80103bd0 <getcallerpcs>
}
80103cc3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103cc6:	c9                   	leave  
80103cc7:	c3                   	ret    

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80103cc8:	8b 5a 08             	mov    0x8(%edx),%ebx
80103ccb:	e8 4c f5 ff ff       	call   8010321c <mycpu>
80103cd0:	39 c3                	cmp    %eax,%ebx
80103cd2:	74 05                	je     80103cd9 <acquire+0x61>
80103cd4:	8b 55 08             	mov    0x8(%ebp),%edx
80103cd7:	eb b2                	jmp    80103c8b <acquire+0x13>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80103cd9:	83 ec 0c             	sub    $0xc,%esp
80103cdc:	68 fb 6a 10 80       	push   $0x80106afb
80103ce1:	e8 52 c6 ff ff       	call   80100338 <panic>
80103ce6:	66 90                	xchg   %ax,%ax

80103ce8 <popcli>:
  mycpu()->ncli += 1;
}

void
popcli(void)
{
80103ce8:	55                   	push   %ebp
80103ce9:	89 e5                	mov    %esp,%ebp
80103ceb:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103cee:	9c                   	pushf  
80103cef:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103cf0:	f6 c4 02             	test   $0x2,%ah
80103cf3:	75 4a                	jne    80103d3f <popcli+0x57>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80103cf5:	e8 22 f5 ff ff       	call   8010321c <mycpu>
80103cfa:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80103d00:	8d 51 ff             	lea    -0x1(%ecx),%edx
80103d03:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80103d09:	85 d2                	test   %edx,%edx
80103d0b:	78 25                	js     80103d32 <popcli+0x4a>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80103d0d:	e8 0a f5 ff ff       	call   8010321c <mycpu>
80103d12:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80103d18:	85 d2                	test   %edx,%edx
80103d1a:	74 04                	je     80103d20 <popcli+0x38>
    sti();
}
80103d1c:	c9                   	leave  
80103d1d:	c3                   	ret    
80103d1e:	66 90                	xchg   %ax,%ax
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80103d20:	e8 f7 f4 ff ff       	call   8010321c <mycpu>
80103d25:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80103d2b:	85 c0                	test   %eax,%eax
80103d2d:	74 ed                	je     80103d1c <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
80103d2f:	fb                   	sti    
    sti();
}
80103d30:	c9                   	leave  
80103d31:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
80103d32:	83 ec 0c             	sub    $0xc,%esp
80103d35:	68 1a 6b 10 80       	push   $0x80106b1a
80103d3a:	e8 f9 c5 ff ff       	call   80100338 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
80103d3f:	83 ec 0c             	sub    $0xc,%esp
80103d42:	68 03 6b 10 80       	push   $0x80106b03
80103d47:	e8 ec c5 ff ff       	call   80100338 <panic>

80103d4c <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
80103d4c:	55                   	push   %ebp
80103d4d:	89 e5                	mov    %esp,%ebp
80103d4f:	56                   	push   %esi
80103d50:	53                   	push   %ebx
80103d51:	8b 5d 08             	mov    0x8(%ebp),%ebx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80103d54:	8b 03                	mov    (%ebx),%eax
80103d56:	85 c0                	test   %eax,%eax
80103d58:	75 0e                	jne    80103d68 <release+0x1c>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
80103d5a:	83 ec 0c             	sub    $0xc,%esp
80103d5d:	68 21 6b 10 80       	push   $0x80106b21
80103d62:	e8 d1 c5 ff ff       	call   80100338 <panic>
80103d67:	90                   	nop

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80103d68:	8b 73 08             	mov    0x8(%ebx),%esi
80103d6b:	e8 ac f4 ff ff       	call   8010321c <mycpu>
80103d70:	39 c6                	cmp    %eax,%esi
80103d72:	75 e6                	jne    80103d5a <release+0xe>
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");

  lk->pcs[0] = 0;
80103d74:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80103d7b:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
80103d82:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80103d87:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
80103d8d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d90:	5b                   	pop    %ebx
80103d91:	5e                   	pop    %esi
80103d92:	5d                   	pop    %ebp
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
80103d93:	e9 50 ff ff ff       	jmp    80103ce8 <popcli>

80103d98 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80103d98:	55                   	push   %ebp
80103d99:	89 e5                	mov    %esp,%ebp
80103d9b:	57                   	push   %edi
80103d9c:	53                   	push   %ebx
80103d9d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if ((int)dst%4 == 0 && n%4 == 0){
80103da0:	f6 c3 03             	test   $0x3,%bl
80103da3:	75 06                	jne    80103dab <memset+0x13>
80103da5:	f6 45 10 03          	testb  $0x3,0x10(%ebp)
80103da9:	74 11                	je     80103dbc <memset+0x24>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80103dab:	89 df                	mov    %ebx,%edi
80103dad:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103db0:	8b 45 0c             	mov    0xc(%ebp),%eax
80103db3:	fc                   	cld    
80103db4:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80103db6:	89 d8                	mov    %ebx,%eax
80103db8:	5b                   	pop    %ebx
80103db9:	5f                   	pop    %edi
80103dba:	5d                   	pop    %ebp
80103dbb:	c3                   	ret    

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80103dbc:	0f b6 55 0c          	movzbl 0xc(%ebp),%edx
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80103dc0:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103dc3:	c1 e9 02             	shr    $0x2,%ecx
80103dc6:	89 d7                	mov    %edx,%edi
80103dc8:	c1 e7 18             	shl    $0x18,%edi
80103dcb:	89 d0                	mov    %edx,%eax
80103dcd:	c1 e0 10             	shl    $0x10,%eax
80103dd0:	09 f8                	or     %edi,%eax
80103dd2:	09 d0                	or     %edx,%eax
80103dd4:	c1 e2 08             	shl    $0x8,%edx
80103dd7:	09 d0                	or     %edx,%eax
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
80103dd9:	89 df                	mov    %ebx,%edi
80103ddb:	fc                   	cld    
80103ddc:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80103dde:	89 d8                	mov    %ebx,%eax
80103de0:	5b                   	pop    %ebx
80103de1:	5f                   	pop    %edi
80103de2:	5d                   	pop    %ebp
80103de3:	c3                   	ret    

80103de4 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80103de4:	55                   	push   %ebp
80103de5:	89 e5                	mov    %esp,%ebp
80103de7:	57                   	push   %edi
80103de8:	56                   	push   %esi
80103de9:	53                   	push   %ebx
80103dea:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103ded:	8b 75 0c             	mov    0xc(%ebp),%esi
80103df0:	8b 45 10             	mov    0x10(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80103df3:	8d 78 ff             	lea    -0x1(%eax),%edi
80103df6:	85 c0                	test   %eax,%eax
80103df8:	74 1f                	je     80103e19 <memcmp+0x35>
    if(*s1 != *s2)
80103dfa:	8a 13                	mov    (%ebx),%dl
80103dfc:	0f b6 0e             	movzbl (%esi),%ecx
80103dff:	38 ca                	cmp    %cl,%dl
80103e01:	75 1d                	jne    80103e20 <memcmp+0x3c>
80103e03:	31 c0                	xor    %eax,%eax
80103e05:	eb 0e                	jmp    80103e15 <memcmp+0x31>
80103e07:	90                   	nop
80103e08:	8a 54 03 01          	mov    0x1(%ebx,%eax,1),%dl
80103e0c:	40                   	inc    %eax
80103e0d:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80103e11:	38 ca                	cmp    %cl,%dl
80103e13:	75 0b                	jne    80103e20 <memcmp+0x3c>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80103e15:	39 f8                	cmp    %edi,%eax
80103e17:	75 ef                	jne    80103e08 <memcmp+0x24>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
80103e19:	31 c0                	xor    %eax,%eax
}
80103e1b:	5b                   	pop    %ebx
80103e1c:	5e                   	pop    %esi
80103e1d:	5f                   	pop    %edi
80103e1e:	5d                   	pop    %ebp
80103e1f:	c3                   	ret    

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80103e20:	0f b6 c2             	movzbl %dl,%eax
80103e23:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
80103e25:	5b                   	pop    %ebx
80103e26:	5e                   	pop    %esi
80103e27:	5f                   	pop    %edi
80103e28:	5d                   	pop    %ebp
80103e29:	c3                   	ret    
80103e2a:	66 90                	xchg   %ax,%ax

80103e2c <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80103e2c:	55                   	push   %ebp
80103e2d:	89 e5                	mov    %esp,%ebp
80103e2f:	57                   	push   %edi
80103e30:	56                   	push   %esi
80103e31:	53                   	push   %ebx
80103e32:	8b 45 08             	mov    0x8(%ebp),%eax
80103e35:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80103e38:	8b 7d 10             	mov    0x10(%ebp),%edi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80103e3b:	39 c3                	cmp    %eax,%ebx
80103e3d:	73 29                	jae    80103e68 <memmove+0x3c>
80103e3f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80103e42:	39 f0                	cmp    %esi,%eax
80103e44:	73 22                	jae    80103e68 <memmove+0x3c>
    s += n;
    d += n;
    while(n-- > 0)
80103e46:	8d 57 ff             	lea    -0x1(%edi),%edx
80103e49:	85 ff                	test   %edi,%edi
80103e4b:	74 13                	je     80103e60 <memmove+0x34>
80103e4d:	29 fe                	sub    %edi,%esi
80103e4f:	89 f1                	mov    %esi,%ecx
80103e51:	8d 76 00             	lea    0x0(%esi),%esi
      *--d = *--s;
80103e54:	8a 1c 11             	mov    (%ecx,%edx,1),%bl
80103e57:	88 1c 10             	mov    %bl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
80103e5a:	4a                   	dec    %edx
80103e5b:	83 fa ff             	cmp    $0xffffffff,%edx
80103e5e:	75 f4                	jne    80103e54 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80103e60:	5b                   	pop    %ebx
80103e61:	5e                   	pop    %esi
80103e62:	5f                   	pop    %edi
80103e63:	5d                   	pop    %ebp
80103e64:	c3                   	ret    
80103e65:	8d 76 00             	lea    0x0(%esi),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80103e68:	31 d2                	xor    %edx,%edx
80103e6a:	85 ff                	test   %edi,%edi
80103e6c:	74 f2                	je     80103e60 <memmove+0x34>
80103e6e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80103e70:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
80103e73:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80103e76:	42                   	inc    %edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80103e77:	39 fa                	cmp    %edi,%edx
80103e79:	75 f5                	jne    80103e70 <memmove+0x44>
      *d++ = *s++;

  return dst;
}
80103e7b:	5b                   	pop    %ebx
80103e7c:	5e                   	pop    %esi
80103e7d:	5f                   	pop    %edi
80103e7e:	5d                   	pop    %ebp
80103e7f:	c3                   	ret    

80103e80 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80103e80:	55                   	push   %ebp
80103e81:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80103e83:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80103e84:	e9 a3 ff ff ff       	jmp    80103e2c <memmove>
80103e89:	8d 76 00             	lea    0x0(%esi),%esi

80103e8c <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80103e8c:	55                   	push   %ebp
80103e8d:	89 e5                	mov    %esp,%ebp
80103e8f:	57                   	push   %edi
80103e90:	56                   	push   %esi
80103e91:	53                   	push   %ebx
80103e92:	8b 7d 08             	mov    0x8(%ebp),%edi
80103e95:	8b 75 0c             	mov    0xc(%ebp),%esi
80103e98:	8b 5d 10             	mov    0x10(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
80103e9b:	85 db                	test   %ebx,%ebx
80103e9d:	74 2c                	je     80103ecb <strncmp+0x3f>
80103e9f:	8a 17                	mov    (%edi),%dl
80103ea1:	0f b6 0e             	movzbl (%esi),%ecx
80103ea4:	84 d2                	test   %dl,%dl
80103ea6:	74 3a                	je     80103ee2 <strncmp+0x56>
80103ea8:	38 ca                	cmp    %cl,%dl
80103eaa:	75 2c                	jne    80103ed8 <strncmp+0x4c>
80103eac:	8d 47 01             	lea    0x1(%edi),%eax
80103eaf:	01 df                	add    %ebx,%edi
80103eb1:	eb 11                	jmp    80103ec4 <strncmp+0x38>
80103eb3:	90                   	nop
80103eb4:	8a 10                	mov    (%eax),%dl
80103eb6:	84 d2                	test   %dl,%dl
80103eb8:	74 1a                	je     80103ed4 <strncmp+0x48>
80103eba:	0f b6 0b             	movzbl (%ebx),%ecx
80103ebd:	40                   	inc    %eax
80103ebe:	89 de                	mov    %ebx,%esi
80103ec0:	38 ca                	cmp    %cl,%dl
80103ec2:	75 14                	jne    80103ed8 <strncmp+0x4c>
    n--, p++, q++;
80103ec4:	8d 5e 01             	lea    0x1(%esi),%ebx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80103ec7:	39 f8                	cmp    %edi,%eax
80103ec9:	75 e9                	jne    80103eb4 <strncmp+0x28>
    n--, p++, q++;
  if(n == 0)
    return 0;
80103ecb:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
80103ecd:	5b                   	pop    %ebx
80103ece:	5e                   	pop    %esi
80103ecf:	5f                   	pop    %edi
80103ed0:	5d                   	pop    %ebp
80103ed1:	c3                   	ret    
80103ed2:	66 90                	xchg   %ax,%ax
80103ed4:	0f b6 4e 01          	movzbl 0x1(%esi),%ecx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80103ed8:	0f b6 c2             	movzbl %dl,%eax
80103edb:	29 c8                	sub    %ecx,%eax
}
80103edd:	5b                   	pop    %ebx
80103ede:	5e                   	pop    %esi
80103edf:	5f                   	pop    %edi
80103ee0:	5d                   	pop    %ebp
80103ee1:	c3                   	ret    
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80103ee2:	31 d2                	xor    %edx,%edx
80103ee4:	eb f2                	jmp    80103ed8 <strncmp+0x4c>
80103ee6:	66 90                	xchg   %ax,%ax

80103ee8 <strncpy>:
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
{
80103ee8:	55                   	push   %ebp
80103ee9:	89 e5                	mov    %esp,%ebp
80103eeb:	56                   	push   %esi
80103eec:	53                   	push   %ebx
80103eed:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80103ef0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80103ef3:	8b 55 08             	mov    0x8(%ebp),%edx
80103ef6:	eb 0c                	jmp    80103f04 <strncpy+0x1c>
80103ef8:	42                   	inc    %edx
80103ef9:	43                   	inc    %ebx
80103efa:	8a 43 ff             	mov    -0x1(%ebx),%al
80103efd:	88 42 ff             	mov    %al,-0x1(%edx)
80103f00:	84 c0                	test   %al,%al
80103f02:	74 08                	je     80103f0c <strncpy+0x24>
80103f04:	49                   	dec    %ecx
80103f05:	8d 71 01             	lea    0x1(%ecx),%esi
80103f08:	85 f6                	test   %esi,%esi
80103f0a:	7f ec                	jg     80103ef8 <strncpy+0x10>
80103f0c:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    ;
  while(n-- > 0)
80103f0f:	85 c9                	test   %ecx,%ecx
80103f11:	7e 0a                	jle    80103f1d <strncpy+0x35>
80103f13:	90                   	nop
    *s++ = 0;
80103f14:	42                   	inc    %edx
80103f15:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
80103f19:	39 c2                	cmp    %eax,%edx
80103f1b:	75 f7                	jne    80103f14 <strncpy+0x2c>
    *s++ = 0;
  return os;
}
80103f1d:	8b 45 08             	mov    0x8(%ebp),%eax
80103f20:	5b                   	pop    %ebx
80103f21:	5e                   	pop    %esi
80103f22:	5d                   	pop    %ebp
80103f23:	c3                   	ret    

80103f24 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80103f24:	55                   	push   %ebp
80103f25:	89 e5                	mov    %esp,%ebp
80103f27:	56                   	push   %esi
80103f28:	53                   	push   %ebx
80103f29:	8b 45 08             	mov    0x8(%ebp),%eax
80103f2c:	8b 55 0c             	mov    0xc(%ebp),%edx
80103f2f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  if(n <= 0)
80103f32:	85 c9                	test   %ecx,%ecx
80103f34:	7e 1d                	jle    80103f53 <safestrcpy+0x2f>
80103f36:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80103f3a:	89 c1                	mov    %eax,%ecx
80103f3c:	eb 0e                	jmp    80103f4c <safestrcpy+0x28>
80103f3e:	66 90                	xchg   %ax,%ax
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80103f40:	41                   	inc    %ecx
80103f41:	42                   	inc    %edx
80103f42:	8a 5a ff             	mov    -0x1(%edx),%bl
80103f45:	88 59 ff             	mov    %bl,-0x1(%ecx)
80103f48:	84 db                	test   %bl,%bl
80103f4a:	74 04                	je     80103f50 <safestrcpy+0x2c>
80103f4c:	39 f2                	cmp    %esi,%edx
80103f4e:	75 f0                	jne    80103f40 <safestrcpy+0x1c>
    ;
  *s = 0;
80103f50:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80103f53:	5b                   	pop    %ebx
80103f54:	5e                   	pop    %esi
80103f55:	5d                   	pop    %ebp
80103f56:	c3                   	ret    
80103f57:	90                   	nop

80103f58 <strlen>:

int
strlen(const char *s)
{
80103f58:	55                   	push   %ebp
80103f59:	89 e5                	mov    %esp,%ebp
80103f5b:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80103f5e:	31 c0                	xor    %eax,%eax
80103f60:	80 3a 00             	cmpb   $0x0,(%edx)
80103f63:	74 0a                	je     80103f6f <strlen+0x17>
80103f65:	8d 76 00             	lea    0x0(%esi),%esi
80103f68:	40                   	inc    %eax
80103f69:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80103f6d:	75 f9                	jne    80103f68 <strlen+0x10>
    ;
  return n;
}
80103f6f:	5d                   	pop    %ebp
80103f70:	c3                   	ret    

80103f71 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80103f71:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80103f75:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80103f79:	55                   	push   %ebp
  pushl %ebx
80103f7a:	53                   	push   %ebx
  pushl %esi
80103f7b:	56                   	push   %esi
  pushl %edi
80103f7c:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80103f7d:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80103f7f:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
80103f81:	5f                   	pop    %edi
  popl %esi
80103f82:	5e                   	pop    %esi
  popl %ebx
80103f83:	5b                   	pop    %ebx
  popl %ebp
80103f84:	5d                   	pop    %ebp
  ret
80103f85:	c3                   	ret    
80103f86:	66 90                	xchg   %ax,%ax

80103f88 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80103f88:	55                   	push   %ebp
80103f89:	89 e5                	mov    %esp,%ebp
80103f8b:	53                   	push   %ebx
80103f8c:	51                   	push   %ecx
80103f8d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80103f90:	e8 33 f3 ff ff       	call   801032c8 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80103f95:	8b 00                	mov    (%eax),%eax
80103f97:	39 d8                	cmp    %ebx,%eax
80103f99:	76 15                	jbe    80103fb0 <fetchint+0x28>
80103f9b:	8d 53 04             	lea    0x4(%ebx),%edx
80103f9e:	39 d0                	cmp    %edx,%eax
80103fa0:	72 0e                	jb     80103fb0 <fetchint+0x28>
    return -1;
  *ip = *(int*)(addr);
80103fa2:	8b 13                	mov    (%ebx),%edx
80103fa4:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fa7:	89 10                	mov    %edx,(%eax)
  return 0;
80103fa9:	31 c0                	xor    %eax,%eax
}
80103fab:	5a                   	pop    %edx
80103fac:	5b                   	pop    %ebx
80103fad:	5d                   	pop    %ebp
80103fae:	c3                   	ret    
80103faf:	90                   	nop
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80103fb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103fb5:	eb f4                	jmp    80103fab <fetchint+0x23>
80103fb7:	90                   	nop

80103fb8 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80103fb8:	55                   	push   %ebp
80103fb9:	89 e5                	mov    %esp,%ebp
80103fbb:	53                   	push   %ebx
80103fbc:	51                   	push   %ecx
80103fbd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80103fc0:	e8 03 f3 ff ff       	call   801032c8 <myproc>

  if(addr >= curproc->sz)
80103fc5:	39 18                	cmp    %ebx,(%eax)
80103fc7:	76 21                	jbe    80103fea <fetchstr+0x32>
    return -1;
  *pp = (char*)addr;
80103fc9:	89 da                	mov    %ebx,%edx
80103fcb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103fce:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80103fd0:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80103fd2:	39 c3                	cmp    %eax,%ebx
80103fd4:	73 14                	jae    80103fea <fetchstr+0x32>
    if(*s == 0)
80103fd6:	80 3b 00             	cmpb   $0x0,(%ebx)
80103fd9:	75 0a                	jne    80103fe5 <fetchstr+0x2d>
80103fdb:	eb 17                	jmp    80103ff4 <fetchstr+0x3c>
80103fdd:	8d 76 00             	lea    0x0(%esi),%esi
80103fe0:	80 3a 00             	cmpb   $0x0,(%edx)
80103fe3:	74 0f                	je     80103ff4 <fetchstr+0x3c>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
80103fe5:	42                   	inc    %edx
80103fe6:	39 d0                	cmp    %edx,%eax
80103fe8:	77 f6                	ja     80103fe0 <fetchstr+0x28>
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
80103fea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80103fef:	5a                   	pop    %edx
80103ff0:	5b                   	pop    %ebx
80103ff1:	5d                   	pop    %ebp
80103ff2:	c3                   	ret    
80103ff3:	90                   	nop
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
80103ff4:	89 d0                	mov    %edx,%eax
80103ff6:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80103ff8:	5a                   	pop    %edx
80103ff9:	5b                   	pop    %ebx
80103ffa:	5d                   	pop    %ebp
80103ffb:	c3                   	ret    

80103ffc <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80103ffc:	55                   	push   %ebp
80103ffd:	89 e5                	mov    %esp,%ebp
80103fff:	56                   	push   %esi
80104000:	53                   	push   %ebx
80104001:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104004:	8b 75 0c             	mov    0xc(%ebp),%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104007:	e8 bc f2 ff ff       	call   801032c8 <myproc>
8010400c:	89 75 0c             	mov    %esi,0xc(%ebp)
8010400f:	8b 40 18             	mov    0x18(%eax),%eax
80104012:	8b 40 44             	mov    0x44(%eax),%eax
80104015:	8d 44 98 04          	lea    0x4(%eax,%ebx,4),%eax
80104019:	89 45 08             	mov    %eax,0x8(%ebp)
}
8010401c:	5b                   	pop    %ebx
8010401d:	5e                   	pop    %esi
8010401e:	5d                   	pop    %ebp

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010401f:	e9 64 ff ff ff       	jmp    80103f88 <fetchint>

80104024 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104024:	55                   	push   %ebp
80104025:	89 e5                	mov    %esp,%ebp
80104027:	56                   	push   %esi
80104028:	53                   	push   %ebx
80104029:	83 ec 10             	sub    $0x10,%esp
8010402c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010402f:	e8 94 f2 ff ff       	call   801032c8 <myproc>
80104034:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104036:	83 ec 08             	sub    $0x8,%esp
80104039:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010403c:	50                   	push   %eax
8010403d:	ff 75 08             	pushl  0x8(%ebp)
80104040:	e8 b7 ff ff ff       	call   80103ffc <argint>
80104045:	83 c4 10             	add    $0x10,%esp
80104048:	85 c0                	test   %eax,%eax
8010404a:	78 24                	js     80104070 <argptr+0x4c>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
8010404c:	85 db                	test   %ebx,%ebx
8010404e:	78 20                	js     80104070 <argptr+0x4c>
80104050:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104053:	8b 06                	mov    (%esi),%eax
80104055:	39 c2                	cmp    %eax,%edx
80104057:	73 17                	jae    80104070 <argptr+0x4c>
80104059:	01 d3                	add    %edx,%ebx
8010405b:	39 d8                	cmp    %ebx,%eax
8010405d:	72 11                	jb     80104070 <argptr+0x4c>
    return -1;
  *pp = (char*)i;
8010405f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104062:	89 10                	mov    %edx,(%eax)
  return 0;
80104064:	31 c0                	xor    %eax,%eax
}
80104066:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104069:	5b                   	pop    %ebx
8010406a:	5e                   	pop    %esi
8010406b:	5d                   	pop    %ebp
8010406c:	c3                   	ret    
8010406d:	8d 76 00             	lea    0x0(%esi),%esi
{
  int i;
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
80104070:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
  *pp = (char*)i;
  return 0;
}
80104075:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104078:	5b                   	pop    %ebx
80104079:	5e                   	pop    %esi
8010407a:	5d                   	pop    %ebp
8010407b:	c3                   	ret    

8010407c <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
8010407c:	55                   	push   %ebp
8010407d:	89 e5                	mov    %esp,%ebp
8010407f:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104082:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104085:	50                   	push   %eax
80104086:	ff 75 08             	pushl  0x8(%ebp)
80104089:	e8 6e ff ff ff       	call   80103ffc <argint>
8010408e:	83 c4 10             	add    $0x10,%esp
80104091:	85 c0                	test   %eax,%eax
80104093:	78 13                	js     801040a8 <argstr+0x2c>
    return -1;
  return fetchstr(addr, pp);
80104095:	83 ec 08             	sub    $0x8,%esp
80104098:	ff 75 0c             	pushl  0xc(%ebp)
8010409b:	ff 75 f4             	pushl  -0xc(%ebp)
8010409e:	e8 15 ff ff ff       	call   80103fb8 <fetchstr>
801040a3:	83 c4 10             	add    $0x10,%esp
}
801040a6:	c9                   	leave  
801040a7:	c3                   	ret    
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
801040a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
801040ad:	c9                   	leave  
801040ae:	c3                   	ret    
801040af:	90                   	nop

801040b0 <syscall>:
[SYS_mike]   sys_mike,
};

void
syscall(void)
{
801040b0:	55                   	push   %ebp
801040b1:	89 e5                	mov    %esp,%ebp
801040b3:	53                   	push   %ebx
801040b4:	83 ec 14             	sub    $0x14,%esp
  int num;
  struct proc *curproc = myproc();
801040b7:	e8 0c f2 ff ff       	call   801032c8 <myproc>

  num = curproc->tf->eax;
801040bc:	8b 58 18             	mov    0x18(%eax),%ebx
801040bf:	8b 53 1c             	mov    0x1c(%ebx),%edx
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801040c2:	8d 4a ff             	lea    -0x1(%edx),%ecx
801040c5:	83 f9 15             	cmp    $0x15,%ecx
801040c8:	77 16                	ja     801040e0 <syscall+0x30>
801040ca:	8b 0c 95 60 6b 10 80 	mov    -0x7fef94a0(,%edx,4),%ecx
801040d1:	85 c9                	test   %ecx,%ecx
801040d3:	74 0b                	je     801040e0 <syscall+0x30>
    curproc->tf->eax = syscalls[num]();
801040d5:	ff d1                	call   *%ecx
801040d7:	89 43 1c             	mov    %eax,0x1c(%ebx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801040da:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040dd:	c9                   	leave  
801040de:	c3                   	ret    
801040df:	90                   	nop

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801040e0:	52                   	push   %edx
            curproc->pid, curproc->name, num);
801040e1:	8d 50 6c             	lea    0x6c(%eax),%edx

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801040e4:	52                   	push   %edx
801040e5:	ff 70 10             	pushl  0x10(%eax)
801040e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
801040eb:	68 29 6b 10 80       	push   $0x80106b29
801040f0:	e8 13 c5 ff ff       	call   80100608 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
801040f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040f8:	8b 40 18             	mov    0x18(%eax),%eax
801040fb:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
80104102:	83 c4 10             	add    $0x10,%esp
  }
}
80104105:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104108:	c9                   	leave  
80104109:	c3                   	ret    
8010410a:	66 90                	xchg   %ax,%ax

8010410c <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
8010410c:	55                   	push   %ebp
8010410d:	89 e5                	mov    %esp,%ebp
8010410f:	53                   	push   %ebx
80104110:	53                   	push   %ebx
80104111:	89 c3                	mov    %eax,%ebx
  int fd;
  struct proc *curproc = myproc();
80104113:	e8 b0 f1 ff ff       	call   801032c8 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
80104118:	31 d2                	xor    %edx,%edx
8010411a:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
8010411c:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80104120:	85 c9                	test   %ecx,%ecx
80104122:	74 10                	je     80104134 <fdalloc+0x28>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104124:	42                   	inc    %edx
80104125:	83 fa 10             	cmp    $0x10,%edx
80104128:	75 f2                	jne    8010411c <fdalloc+0x10>
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
8010412a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010412f:	5a                   	pop    %edx
80104130:	5b                   	pop    %ebx
80104131:	5d                   	pop    %ebp
80104132:	c3                   	ret    
80104133:	90                   	nop
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80104134:	89 5c 90 28          	mov    %ebx,0x28(%eax,%edx,4)
      return fd;
80104138:	89 d0                	mov    %edx,%eax
    }
  }
  return -1;
}
8010413a:	5a                   	pop    %edx
8010413b:	5b                   	pop    %ebx
8010413c:	5d                   	pop    %ebp
8010413d:	c3                   	ret    
8010413e:	66 90                	xchg   %ax,%ax

80104140 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104140:	55                   	push   %ebp
80104141:	89 e5                	mov    %esp,%ebp
80104143:	57                   	push   %edi
80104144:	56                   	push   %esi
80104145:	53                   	push   %ebx
80104146:	83 ec 44             	sub    $0x44,%esp
80104149:	89 55 c4             	mov    %edx,-0x3c(%ebp)
8010414c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
8010414f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104152:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104155:	8d 75 da             	lea    -0x26(%ebp),%esi
80104158:	56                   	push   %esi
80104159:	50                   	push   %eax
8010415a:	e8 6d db ff ff       	call   80101ccc <nameiparent>
8010415f:	89 c7                	mov    %eax,%edi
80104161:	83 c4 10             	add    $0x10,%esp
80104164:	85 c0                	test   %eax,%eax
80104166:	0f 84 d8 00 00 00    	je     80104244 <create+0x104>
    return 0;
  ilock(dp);
8010416c:	83 ec 0c             	sub    $0xc,%esp
8010416f:	50                   	push   %eax
80104170:	e8 5f d3 ff ff       	call   801014d4 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104175:	83 c4 0c             	add    $0xc,%esp
80104178:	8d 45 d4             	lea    -0x2c(%ebp),%eax
8010417b:	50                   	push   %eax
8010417c:	56                   	push   %esi
8010417d:	57                   	push   %edi
8010417e:	e8 2d d8 ff ff       	call   801019b0 <dirlookup>
80104183:	89 c3                	mov    %eax,%ebx
80104185:	83 c4 10             	add    $0x10,%esp
80104188:	85 c0                	test   %eax,%eax
8010418a:	74 44                	je     801041d0 <create+0x90>
    iunlockput(dp);
8010418c:	83 ec 0c             	sub    $0xc,%esp
8010418f:	57                   	push   %edi
80104190:	e8 93 d5 ff ff       	call   80101728 <iunlockput>
    ilock(ip);
80104195:	89 1c 24             	mov    %ebx,(%esp)
80104198:	e8 37 d3 ff ff       	call   801014d4 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010419d:	83 c4 10             	add    $0x10,%esp
801041a0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
801041a5:	75 11                	jne    801041b8 <create+0x78>
801041a7:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
801041ac:	75 0a                	jne    801041b8 <create+0x78>
801041ae:	89 d8                	mov    %ebx,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801041b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041b3:	5b                   	pop    %ebx
801041b4:	5e                   	pop    %esi
801041b5:	5f                   	pop    %edi
801041b6:	5d                   	pop    %ebp
801041b7:	c3                   	ret    
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
801041b8:	83 ec 0c             	sub    $0xc,%esp
801041bb:	53                   	push   %ebx
801041bc:	e8 67 d5 ff ff       	call   80101728 <iunlockput>
    return 0;
801041c1:	83 c4 10             	add    $0x10,%esp
801041c4:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801041c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041c9:	5b                   	pop    %ebx
801041ca:	5e                   	pop    %esi
801041cb:	5f                   	pop    %edi
801041cc:	5d                   	pop    %ebp
801041cd:	c3                   	ret    
801041ce:	66 90                	xchg   %ax,%ax
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
801041d0:	83 ec 08             	sub    $0x8,%esp
801041d3:	ff 75 c4             	pushl  -0x3c(%ebp)
801041d6:	ff 37                	pushl  (%edi)
801041d8:	e8 9f d1 ff ff       	call   8010137c <ialloc>
801041dd:	89 c3                	mov    %eax,%ebx
801041df:	83 c4 10             	add    $0x10,%esp
801041e2:	85 c0                	test   %eax,%eax
801041e4:	0f 84 b7 00 00 00    	je     801042a1 <create+0x161>
    panic("create: ialloc");

  ilock(ip);
801041ea:	83 ec 0c             	sub    $0xc,%esp
801041ed:	50                   	push   %eax
801041ee:	e8 e1 d2 ff ff       	call   801014d4 <ilock>
  ip->major = major;
801041f3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801041f6:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
801041fa:	8b 45 bc             	mov    -0x44(%ebp),%eax
801041fd:	66 89 43 54          	mov    %ax,0x54(%ebx)
  ip->nlink = 1;
80104201:	66 c7 43 56 01 00    	movw   $0x1,0x56(%ebx)
  iupdate(ip);
80104207:	89 1c 24             	mov    %ebx,(%esp)
8010420a:	e8 1d d2 ff ff       	call   8010142c <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
8010420f:	83 c4 10             	add    $0x10,%esp
80104212:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104217:	74 33                	je     8010424c <create+0x10c>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80104219:	50                   	push   %eax
8010421a:	ff 73 04             	pushl  0x4(%ebx)
8010421d:	56                   	push   %esi
8010421e:	57                   	push   %edi
8010421f:	e8 dc d9 ff ff       	call   80101c00 <dirlink>
80104224:	83 c4 10             	add    $0x10,%esp
80104227:	85 c0                	test   %eax,%eax
80104229:	78 69                	js     80104294 <create+0x154>
    panic("create: dirlink");

  iunlockput(dp);
8010422b:	83 ec 0c             	sub    $0xc,%esp
8010422e:	57                   	push   %edi
8010422f:	e8 f4 d4 ff ff       	call   80101728 <iunlockput>

  return ip;
80104234:	83 c4 10             	add    $0x10,%esp
80104237:	89 d8                	mov    %ebx,%eax
}
80104239:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010423c:	5b                   	pop    %ebx
8010423d:	5e                   	pop    %esi
8010423e:	5f                   	pop    %edi
8010423f:	5d                   	pop    %ebp
80104240:	c3                   	ret    
80104241:	8d 76 00             	lea    0x0(%esi),%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80104244:	31 c0                	xor    %eax,%eax
80104246:	e9 65 ff ff ff       	jmp    801041b0 <create+0x70>
8010424b:	90                   	nop
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
8010424c:	66 ff 47 56          	incw   0x56(%edi)
    iupdate(dp);
80104250:	83 ec 0c             	sub    $0xc,%esp
80104253:	57                   	push   %edi
80104254:	e8 d3 d1 ff ff       	call   8010142c <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104259:	83 c4 0c             	add    $0xc,%esp
8010425c:	ff 73 04             	pushl  0x4(%ebx)
8010425f:	68 d8 6b 10 80       	push   $0x80106bd8
80104264:	53                   	push   %ebx
80104265:	e8 96 d9 ff ff       	call   80101c00 <dirlink>
8010426a:	83 c4 10             	add    $0x10,%esp
8010426d:	85 c0                	test   %eax,%eax
8010426f:	78 16                	js     80104287 <create+0x147>
80104271:	52                   	push   %edx
80104272:	ff 77 04             	pushl  0x4(%edi)
80104275:	68 d7 6b 10 80       	push   $0x80106bd7
8010427a:	53                   	push   %ebx
8010427b:	e8 80 d9 ff ff       	call   80101c00 <dirlink>
80104280:	83 c4 10             	add    $0x10,%esp
80104283:	85 c0                	test   %eax,%eax
80104285:	79 92                	jns    80104219 <create+0xd9>
      panic("create dots");
80104287:	83 ec 0c             	sub    $0xc,%esp
8010428a:	68 cb 6b 10 80       	push   $0x80106bcb
8010428f:	e8 a4 c0 ff ff       	call   80100338 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
80104294:	83 ec 0c             	sub    $0xc,%esp
80104297:	68 da 6b 10 80       	push   $0x80106bda
8010429c:	e8 97 c0 ff ff       	call   80100338 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
801042a1:	83 ec 0c             	sub    $0xc,%esp
801042a4:	68 bc 6b 10 80       	push   $0x80106bbc
801042a9:	e8 8a c0 ff ff       	call   80100338 <panic>
801042ae:	66 90                	xchg   %ax,%ax

801042b0 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
801042b0:	55                   	push   %ebp
801042b1:	89 e5                	mov    %esp,%ebp
801042b3:	56                   	push   %esi
801042b4:	53                   	push   %ebx
801042b5:	83 ec 18             	sub    $0x18,%esp
801042b8:	89 c6                	mov    %eax,%esi
801042ba:	89 d3                	mov    %edx,%ebx
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
801042bc:	8d 45 f4             	lea    -0xc(%ebp),%eax
801042bf:	50                   	push   %eax
801042c0:	6a 00                	push   $0x0
801042c2:	e8 35 fd ff ff       	call   80103ffc <argint>
801042c7:	83 c4 10             	add    $0x10,%esp
801042ca:	85 c0                	test   %eax,%eax
801042cc:	78 2e                	js     801042fc <argfd.constprop.0+0x4c>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801042ce:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801042d2:	77 28                	ja     801042fc <argfd.constprop.0+0x4c>
801042d4:	e8 ef ef ff ff       	call   801032c8 <myproc>
801042d9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801042dc:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
801042e0:	85 c0                	test   %eax,%eax
801042e2:	74 18                	je     801042fc <argfd.constprop.0+0x4c>
    return -1;
  if(pfd)
801042e4:	85 f6                	test   %esi,%esi
801042e6:	74 02                	je     801042ea <argfd.constprop.0+0x3a>
    *pfd = fd;
801042e8:	89 16                	mov    %edx,(%esi)
  if(pf)
801042ea:	85 db                	test   %ebx,%ebx
801042ec:	74 1a                	je     80104308 <argfd.constprop.0+0x58>
    *pf = f;
801042ee:	89 03                	mov    %eax,(%ebx)
  return 0;
801042f0:	31 c0                	xor    %eax,%eax
}
801042f2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042f5:	5b                   	pop    %ebx
801042f6:	5e                   	pop    %esi
801042f7:	5d                   	pop    %ebp
801042f8:	c3                   	ret    
801042f9:	8d 76 00             	lea    0x0(%esi),%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
801042fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
80104301:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104304:	5b                   	pop    %ebx
80104305:	5e                   	pop    %esi
80104306:	5d                   	pop    %ebp
80104307:	c3                   	ret    
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80104308:	31 c0                	xor    %eax,%eax
8010430a:	eb e6                	jmp    801042f2 <argfd.constprop.0+0x42>

8010430c <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
8010430c:	55                   	push   %ebp
8010430d:	89 e5                	mov    %esp,%ebp
8010430f:	53                   	push   %ebx
80104310:	83 ec 14             	sub    $0x14,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104313:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104316:	31 c0                	xor    %eax,%eax
80104318:	e8 93 ff ff ff       	call   801042b0 <argfd.constprop.0>
8010431d:	85 c0                	test   %eax,%eax
8010431f:	78 23                	js     80104344 <sys_dup+0x38>
    return -1;
  if((fd=fdalloc(f)) < 0)
80104321:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104324:	e8 e3 fd ff ff       	call   8010410c <fdalloc>
80104329:	89 c3                	mov    %eax,%ebx
8010432b:	85 c0                	test   %eax,%eax
8010432d:	78 15                	js     80104344 <sys_dup+0x38>
    return -1;
  filedup(f);
8010432f:	83 ec 0c             	sub    $0xc,%esp
80104332:	ff 75 f4             	pushl  -0xc(%ebp)
80104335:	e8 b2 c9 ff ff       	call   80100cec <filedup>
  return fd;
8010433a:	83 c4 10             	add    $0x10,%esp
8010433d:	89 d8                	mov    %ebx,%eax
}
8010433f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104342:	c9                   	leave  
80104343:	c3                   	ret    
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80104344:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104349:	eb f4                	jmp    8010433f <sys_dup+0x33>
8010434b:	90                   	nop

8010434c <sys_read>:
  return fd;
}

int
sys_read(void)
{
8010434c:	55                   	push   %ebp
8010434d:	89 e5                	mov    %esp,%ebp
8010434f:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104352:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104355:	31 c0                	xor    %eax,%eax
80104357:	e8 54 ff ff ff       	call   801042b0 <argfd.constprop.0>
8010435c:	85 c0                	test   %eax,%eax
8010435e:	78 40                	js     801043a0 <sys_read+0x54>
80104360:	83 ec 08             	sub    $0x8,%esp
80104363:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104366:	50                   	push   %eax
80104367:	6a 02                	push   $0x2
80104369:	e8 8e fc ff ff       	call   80103ffc <argint>
8010436e:	83 c4 10             	add    $0x10,%esp
80104371:	85 c0                	test   %eax,%eax
80104373:	78 2b                	js     801043a0 <sys_read+0x54>
80104375:	52                   	push   %edx
80104376:	ff 75 f0             	pushl  -0x10(%ebp)
80104379:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010437c:	50                   	push   %eax
8010437d:	6a 01                	push   $0x1
8010437f:	e8 a0 fc ff ff       	call   80104024 <argptr>
80104384:	83 c4 10             	add    $0x10,%esp
80104387:	85 c0                	test   %eax,%eax
80104389:	78 15                	js     801043a0 <sys_read+0x54>
    return -1;
  return fileread(f, p, n);
8010438b:	50                   	push   %eax
8010438c:	ff 75 f0             	pushl  -0x10(%ebp)
8010438f:	ff 75 f4             	pushl  -0xc(%ebp)
80104392:	ff 75 ec             	pushl  -0x14(%ebp)
80104395:	e8 96 ca ff ff       	call   80100e30 <fileread>
8010439a:	83 c4 10             	add    $0x10,%esp
}
8010439d:	c9                   	leave  
8010439e:	c3                   	ret    
8010439f:	90                   	nop
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
801043a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
801043a5:	c9                   	leave  
801043a6:	c3                   	ret    
801043a7:	90                   	nop

801043a8 <sys_write>:

int
sys_write(void)
{
801043a8:	55                   	push   %ebp
801043a9:	89 e5                	mov    %esp,%ebp
801043ab:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801043ae:	8d 55 ec             	lea    -0x14(%ebp),%edx
801043b1:	31 c0                	xor    %eax,%eax
801043b3:	e8 f8 fe ff ff       	call   801042b0 <argfd.constprop.0>
801043b8:	85 c0                	test   %eax,%eax
801043ba:	78 40                	js     801043fc <sys_write+0x54>
801043bc:	83 ec 08             	sub    $0x8,%esp
801043bf:	8d 45 f0             	lea    -0x10(%ebp),%eax
801043c2:	50                   	push   %eax
801043c3:	6a 02                	push   $0x2
801043c5:	e8 32 fc ff ff       	call   80103ffc <argint>
801043ca:	83 c4 10             	add    $0x10,%esp
801043cd:	85 c0                	test   %eax,%eax
801043cf:	78 2b                	js     801043fc <sys_write+0x54>
801043d1:	52                   	push   %edx
801043d2:	ff 75 f0             	pushl  -0x10(%ebp)
801043d5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801043d8:	50                   	push   %eax
801043d9:	6a 01                	push   $0x1
801043db:	e8 44 fc ff ff       	call   80104024 <argptr>
801043e0:	83 c4 10             	add    $0x10,%esp
801043e3:	85 c0                	test   %eax,%eax
801043e5:	78 15                	js     801043fc <sys_write+0x54>
    return -1;
  return filewrite(f, p, n);
801043e7:	50                   	push   %eax
801043e8:	ff 75 f0             	pushl  -0x10(%ebp)
801043eb:	ff 75 f4             	pushl  -0xc(%ebp)
801043ee:	ff 75 ec             	pushl  -0x14(%ebp)
801043f1:	e8 c2 ca ff ff       	call   80100eb8 <filewrite>
801043f6:	83 c4 10             	add    $0x10,%esp
}
801043f9:	c9                   	leave  
801043fa:	c3                   	ret    
801043fb:	90                   	nop
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
801043fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
80104401:	c9                   	leave  
80104402:	c3                   	ret    
80104403:	90                   	nop

80104404 <sys_close>:

int
sys_close(void)
{
80104404:	55                   	push   %ebp
80104405:	89 e5                	mov    %esp,%ebp
80104407:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
8010440a:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010440d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104410:	e8 9b fe ff ff       	call   801042b0 <argfd.constprop.0>
80104415:	85 c0                	test   %eax,%eax
80104417:	78 23                	js     8010443c <sys_close+0x38>
    return -1;
  myproc()->ofile[fd] = 0;
80104419:	e8 aa ee ff ff       	call   801032c8 <myproc>
8010441e:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104421:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104428:	00 
  fileclose(f);
80104429:	83 ec 0c             	sub    $0xc,%esp
8010442c:	ff 75 f4             	pushl  -0xc(%ebp)
8010442f:	e8 fc c8 ff ff       	call   80100d30 <fileclose>
  return 0;
80104434:	83 c4 10             	add    $0x10,%esp
80104437:	31 c0                	xor    %eax,%eax
}
80104439:	c9                   	leave  
8010443a:	c3                   	ret    
8010443b:	90                   	nop
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
8010443c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80104441:	c9                   	leave  
80104442:	c3                   	ret    
80104443:	90                   	nop

80104444 <sys_fstat>:

int
sys_fstat(void)
{
80104444:	55                   	push   %ebp
80104445:	89 e5                	mov    %esp,%ebp
80104447:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
8010444a:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010444d:	31 c0                	xor    %eax,%eax
8010444f:	e8 5c fe ff ff       	call   801042b0 <argfd.constprop.0>
80104454:	85 c0                	test   %eax,%eax
80104456:	78 28                	js     80104480 <sys_fstat+0x3c>
80104458:	50                   	push   %eax
80104459:	6a 14                	push   $0x14
8010445b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010445e:	50                   	push   %eax
8010445f:	6a 01                	push   $0x1
80104461:	e8 be fb ff ff       	call   80104024 <argptr>
80104466:	83 c4 10             	add    $0x10,%esp
80104469:	85 c0                	test   %eax,%eax
8010446b:	78 13                	js     80104480 <sys_fstat+0x3c>
    return -1;
  return filestat(f, st);
8010446d:	83 ec 08             	sub    $0x8,%esp
80104470:	ff 75 f4             	pushl  -0xc(%ebp)
80104473:	ff 75 f0             	pushl  -0x10(%ebp)
80104476:	e8 71 c9 ff ff       	call   80100dec <filestat>
8010447b:	83 c4 10             	add    $0x10,%esp
}
8010447e:	c9                   	leave  
8010447f:	c3                   	ret    
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80104480:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80104485:	c9                   	leave  
80104486:	c3                   	ret    
80104487:	90                   	nop

80104488 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104488:	55                   	push   %ebp
80104489:	89 e5                	mov    %esp,%ebp
8010448b:	57                   	push   %edi
8010448c:	56                   	push   %esi
8010448d:	53                   	push   %ebx
8010448e:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104491:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104494:	50                   	push   %eax
80104495:	6a 00                	push   $0x0
80104497:	e8 e0 fb ff ff       	call   8010407c <argstr>
8010449c:	83 c4 10             	add    $0x10,%esp
8010449f:	85 c0                	test   %eax,%eax
801044a1:	0f 88 f2 00 00 00    	js     80104599 <sys_link+0x111>
801044a7:	83 ec 08             	sub    $0x8,%esp
801044aa:	8d 45 d0             	lea    -0x30(%ebp),%eax
801044ad:	50                   	push   %eax
801044ae:	6a 01                	push   $0x1
801044b0:	e8 c7 fb ff ff       	call   8010407c <argstr>
801044b5:	83 c4 10             	add    $0x10,%esp
801044b8:	85 c0                	test   %eax,%eax
801044ba:	0f 88 d9 00 00 00    	js     80104599 <sys_link+0x111>
    return -1;

  begin_op();
801044c0:	e8 a3 e2 ff ff       	call   80102768 <begin_op>
  if((ip = namei(old)) == 0){
801044c5:	83 ec 0c             	sub    $0xc,%esp
801044c8:	ff 75 d4             	pushl  -0x2c(%ebp)
801044cb:	e8 e4 d7 ff ff       	call   80101cb4 <namei>
801044d0:	89 c3                	mov    %eax,%ebx
801044d2:	83 c4 10             	add    $0x10,%esp
801044d5:	85 c0                	test   %eax,%eax
801044d7:	0f 84 e3 00 00 00    	je     801045c0 <sys_link+0x138>
    end_op();
    return -1;
  }

  ilock(ip);
801044dd:	83 ec 0c             	sub    $0xc,%esp
801044e0:	50                   	push   %eax
801044e1:	e8 ee cf ff ff       	call   801014d4 <ilock>
  if(ip->type == T_DIR){
801044e6:	83 c4 10             	add    $0x10,%esp
801044e9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801044ee:	0f 84 b4 00 00 00    	je     801045a8 <sys_link+0x120>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
801044f4:	66 ff 43 56          	incw   0x56(%ebx)
  iupdate(ip);
801044f8:	83 ec 0c             	sub    $0xc,%esp
801044fb:	53                   	push   %ebx
801044fc:	e8 2b cf ff ff       	call   8010142c <iupdate>
  iunlock(ip);
80104501:	89 1c 24             	mov    %ebx,(%esp)
80104504:	e8 93 d0 ff ff       	call   8010159c <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80104509:	5a                   	pop    %edx
8010450a:	59                   	pop    %ecx
8010450b:	8d 7d da             	lea    -0x26(%ebp),%edi
8010450e:	57                   	push   %edi
8010450f:	ff 75 d0             	pushl  -0x30(%ebp)
80104512:	e8 b5 d7 ff ff       	call   80101ccc <nameiparent>
80104517:	89 c6                	mov    %eax,%esi
80104519:	83 c4 10             	add    $0x10,%esp
8010451c:	85 c0                	test   %eax,%eax
8010451e:	74 54                	je     80104574 <sys_link+0xec>
    goto bad;
  ilock(dp);
80104520:	83 ec 0c             	sub    $0xc,%esp
80104523:	50                   	push   %eax
80104524:	e8 ab cf ff ff       	call   801014d4 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104529:	83 c4 10             	add    $0x10,%esp
8010452c:	8b 03                	mov    (%ebx),%eax
8010452e:	39 06                	cmp    %eax,(%esi)
80104530:	75 36                	jne    80104568 <sys_link+0xe0>
80104532:	50                   	push   %eax
80104533:	ff 73 04             	pushl  0x4(%ebx)
80104536:	57                   	push   %edi
80104537:	56                   	push   %esi
80104538:	e8 c3 d6 ff ff       	call   80101c00 <dirlink>
8010453d:	83 c4 10             	add    $0x10,%esp
80104540:	85 c0                	test   %eax,%eax
80104542:	78 24                	js     80104568 <sys_link+0xe0>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80104544:	83 ec 0c             	sub    $0xc,%esp
80104547:	56                   	push   %esi
80104548:	e8 db d1 ff ff       	call   80101728 <iunlockput>
  iput(ip);
8010454d:	89 1c 24             	mov    %ebx,(%esp)
80104550:	e8 8b d0 ff ff       	call   801015e0 <iput>

  end_op();
80104555:	e8 76 e2 ff ff       	call   801027d0 <end_op>

  return 0;
8010455a:	83 c4 10             	add    $0x10,%esp
8010455d:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
8010455f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104562:	5b                   	pop    %ebx
80104563:	5e                   	pop    %esi
80104564:	5f                   	pop    %edi
80104565:	5d                   	pop    %ebp
80104566:	c3                   	ret    
80104567:	90                   	nop

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80104568:	83 ec 0c             	sub    $0xc,%esp
8010456b:	56                   	push   %esi
8010456c:	e8 b7 d1 ff ff       	call   80101728 <iunlockput>
    goto bad;
80104571:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80104574:	83 ec 0c             	sub    $0xc,%esp
80104577:	53                   	push   %ebx
80104578:	e8 57 cf ff ff       	call   801014d4 <ilock>
  ip->nlink--;
8010457d:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
80104581:	89 1c 24             	mov    %ebx,(%esp)
80104584:	e8 a3 ce ff ff       	call   8010142c <iupdate>
  iunlockput(ip);
80104589:	89 1c 24             	mov    %ebx,(%esp)
8010458c:	e8 97 d1 ff ff       	call   80101728 <iunlockput>
  end_op();
80104591:	e8 3a e2 ff ff       	call   801027d0 <end_op>
  return -1;
80104596:	83 c4 10             	add    $0x10,%esp
80104599:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010459e:	8d 65 f4             	lea    -0xc(%ebp),%esp
801045a1:	5b                   	pop    %ebx
801045a2:	5e                   	pop    %esi
801045a3:	5f                   	pop    %edi
801045a4:	5d                   	pop    %ebp
801045a5:	c3                   	ret    
801045a6:	66 90                	xchg   %ax,%ax
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
801045a8:	83 ec 0c             	sub    $0xc,%esp
801045ab:	53                   	push   %ebx
801045ac:	e8 77 d1 ff ff       	call   80101728 <iunlockput>
    end_op();
801045b1:	e8 1a e2 ff ff       	call   801027d0 <end_op>
    return -1;
801045b6:	83 c4 10             	add    $0x10,%esp
801045b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801045be:	eb 9f                	jmp    8010455f <sys_link+0xd7>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
801045c0:	e8 0b e2 ff ff       	call   801027d0 <end_op>
    return -1;
801045c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801045ca:	eb 93                	jmp    8010455f <sys_link+0xd7>

801045cc <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
801045cc:	55                   	push   %ebp
801045cd:	89 e5                	mov    %esp,%ebp
801045cf:	57                   	push   %edi
801045d0:	56                   	push   %esi
801045d1:	53                   	push   %ebx
801045d2:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801045d5:	8d 45 c0             	lea    -0x40(%ebp),%eax
801045d8:	50                   	push   %eax
801045d9:	6a 00                	push   $0x0
801045db:	e8 9c fa ff ff       	call   8010407c <argstr>
801045e0:	83 c4 10             	add    $0x10,%esp
801045e3:	85 c0                	test   %eax,%eax
801045e5:	0f 88 75 01 00 00    	js     80104760 <sys_unlink+0x194>
    return -1;

  begin_op();
801045eb:	e8 78 e1 ff ff       	call   80102768 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801045f0:	83 ec 08             	sub    $0x8,%esp
801045f3:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801045f6:	53                   	push   %ebx
801045f7:	ff 75 c0             	pushl  -0x40(%ebp)
801045fa:	e8 cd d6 ff ff       	call   80101ccc <nameiparent>
801045ff:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80104602:	83 c4 10             	add    $0x10,%esp
80104605:	85 c0                	test   %eax,%eax
80104607:	0f 84 5d 01 00 00    	je     8010476a <sys_unlink+0x19e>
    end_op();
    return -1;
  }

  ilock(dp);
8010460d:	83 ec 0c             	sub    $0xc,%esp
80104610:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80104613:	56                   	push   %esi
80104614:	e8 bb ce ff ff       	call   801014d4 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104619:	59                   	pop    %ecx
8010461a:	5f                   	pop    %edi
8010461b:	68 d8 6b 10 80       	push   $0x80106bd8
80104620:	53                   	push   %ebx
80104621:	e8 72 d3 ff ff       	call   80101998 <namecmp>
80104626:	83 c4 10             	add    $0x10,%esp
80104629:	85 c0                	test   %eax,%eax
8010462b:	0f 84 f4 00 00 00    	je     80104725 <sys_unlink+0x159>
80104631:	83 ec 08             	sub    $0x8,%esp
80104634:	68 d7 6b 10 80       	push   $0x80106bd7
80104639:	53                   	push   %ebx
8010463a:	e8 59 d3 ff ff       	call   80101998 <namecmp>
8010463f:	83 c4 10             	add    $0x10,%esp
80104642:	85 c0                	test   %eax,%eax
80104644:	0f 84 db 00 00 00    	je     80104725 <sys_unlink+0x159>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
8010464a:	52                   	push   %edx
8010464b:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010464e:	50                   	push   %eax
8010464f:	53                   	push   %ebx
80104650:	56                   	push   %esi
80104651:	e8 5a d3 ff ff       	call   801019b0 <dirlookup>
80104656:	89 c7                	mov    %eax,%edi
80104658:	83 c4 10             	add    $0x10,%esp
8010465b:	85 c0                	test   %eax,%eax
8010465d:	0f 84 c2 00 00 00    	je     80104725 <sys_unlink+0x159>
    goto bad;
  ilock(ip);
80104663:	83 ec 0c             	sub    $0xc,%esp
80104666:	50                   	push   %eax
80104667:	e8 68 ce ff ff       	call   801014d4 <ilock>

  if(ip->nlink < 1)
8010466c:	83 c4 10             	add    $0x10,%esp
8010466f:	66 83 7f 56 00       	cmpw   $0x0,0x56(%edi)
80104674:	0f 8e 19 01 00 00    	jle    80104793 <sys_unlink+0x1c7>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
8010467a:	66 83 7f 50 01       	cmpw   $0x1,0x50(%edi)
8010467f:	74 67                	je     801046e8 <sys_unlink+0x11c>
80104681:	8d 75 d8             	lea    -0x28(%ebp),%esi
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
80104684:	50                   	push   %eax
80104685:	6a 10                	push   $0x10
80104687:	6a 00                	push   $0x0
80104689:	56                   	push   %esi
8010468a:	e8 09 f7 ff ff       	call   80103d98 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010468f:	6a 10                	push   $0x10
80104691:	ff 75 c4             	pushl  -0x3c(%ebp)
80104694:	56                   	push   %esi
80104695:	ff 75 b4             	pushl  -0x4c(%ebp)
80104698:	e8 db d1 ff ff       	call   80101878 <writei>
8010469d:	83 c4 20             	add    $0x20,%esp
801046a0:	83 f8 10             	cmp    $0x10,%eax
801046a3:	0f 85 dd 00 00 00    	jne    80104786 <sys_unlink+0x1ba>
    panic("unlink: writei");
  if(ip->type == T_DIR){
801046a9:	66 83 7f 50 01       	cmpw   $0x1,0x50(%edi)
801046ae:	0f 84 94 00 00 00    	je     80104748 <sys_unlink+0x17c>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
801046b4:	83 ec 0c             	sub    $0xc,%esp
801046b7:	ff 75 b4             	pushl  -0x4c(%ebp)
801046ba:	e8 69 d0 ff ff       	call   80101728 <iunlockput>

  ip->nlink--;
801046bf:	66 ff 4f 56          	decw   0x56(%edi)
  iupdate(ip);
801046c3:	89 3c 24             	mov    %edi,(%esp)
801046c6:	e8 61 cd ff ff       	call   8010142c <iupdate>
  iunlockput(ip);
801046cb:	89 3c 24             	mov    %edi,(%esp)
801046ce:	e8 55 d0 ff ff       	call   80101728 <iunlockput>

  end_op();
801046d3:	e8 f8 e0 ff ff       	call   801027d0 <end_op>

  return 0;
801046d8:	83 c4 10             	add    $0x10,%esp
801046db:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
801046dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801046e0:	5b                   	pop    %ebx
801046e1:	5e                   	pop    %esi
801046e2:	5f                   	pop    %edi
801046e3:	5d                   	pop    %ebp
801046e4:	c3                   	ret    
801046e5:	8d 76 00             	lea    0x0(%esi),%esi
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801046e8:	83 7f 58 20          	cmpl   $0x20,0x58(%edi)
801046ec:	76 93                	jbe    80104681 <sys_unlink+0xb5>
801046ee:	bb 20 00 00 00       	mov    $0x20,%ebx
801046f3:	8d 75 d8             	lea    -0x28(%ebp),%esi
801046f6:	eb 08                	jmp    80104700 <sys_unlink+0x134>
801046f8:	83 c3 10             	add    $0x10,%ebx
801046fb:	3b 5f 58             	cmp    0x58(%edi),%ebx
801046fe:	73 84                	jae    80104684 <sys_unlink+0xb8>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104700:	6a 10                	push   $0x10
80104702:	53                   	push   %ebx
80104703:	56                   	push   %esi
80104704:	57                   	push   %edi
80104705:	e8 6a d0 ff ff       	call   80101774 <readi>
8010470a:	83 c4 10             	add    $0x10,%esp
8010470d:	83 f8 10             	cmp    $0x10,%eax
80104710:	75 67                	jne    80104779 <sys_unlink+0x1ad>
      panic("isdirempty: readi");
    if(de.inum != 0)
80104712:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80104717:	74 df                	je     801046f8 <sys_unlink+0x12c>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
80104719:	83 ec 0c             	sub    $0xc,%esp
8010471c:	57                   	push   %edi
8010471d:	e8 06 d0 ff ff       	call   80101728 <iunlockput>
    goto bad;
80104722:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
80104725:	83 ec 0c             	sub    $0xc,%esp
80104728:	ff 75 b4             	pushl  -0x4c(%ebp)
8010472b:	e8 f8 cf ff ff       	call   80101728 <iunlockput>
  end_op();
80104730:	e8 9b e0 ff ff       	call   801027d0 <end_op>
  return -1;
80104735:	83 c4 10             	add    $0x10,%esp
80104738:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010473d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104740:	5b                   	pop    %ebx
80104741:	5e                   	pop    %esi
80104742:	5f                   	pop    %edi
80104743:	5d                   	pop    %ebp
80104744:	c3                   	ret    
80104745:	8d 76 00             	lea    0x0(%esi),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80104748:	8b 45 b4             	mov    -0x4c(%ebp),%eax
8010474b:	66 ff 48 56          	decw   0x56(%eax)
    iupdate(dp);
8010474f:	83 ec 0c             	sub    $0xc,%esp
80104752:	50                   	push   %eax
80104753:	e8 d4 cc ff ff       	call   8010142c <iupdate>
80104758:	83 c4 10             	add    $0x10,%esp
8010475b:	e9 54 ff ff ff       	jmp    801046b4 <sys_unlink+0xe8>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
80104760:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104765:	e9 73 ff ff ff       	jmp    801046dd <sys_unlink+0x111>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
8010476a:	e8 61 e0 ff ff       	call   801027d0 <end_op>
    return -1;
8010476f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104774:	e9 64 ff ff ff       	jmp    801046dd <sys_unlink+0x111>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
80104779:	83 ec 0c             	sub    $0xc,%esp
8010477c:	68 fc 6b 10 80       	push   $0x80106bfc
80104781:	e8 b2 bb ff ff       	call   80100338 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80104786:	83 ec 0c             	sub    $0xc,%esp
80104789:	68 0e 6c 10 80       	push   $0x80106c0e
8010478e:	e8 a5 bb ff ff       	call   80100338 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
80104793:	83 ec 0c             	sub    $0xc,%esp
80104796:	68 ea 6b 10 80       	push   $0x80106bea
8010479b:	e8 98 bb ff ff       	call   80100338 <panic>

801047a0 <sys_open>:
  return ip;
}

int
sys_open(void)
{
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	57                   	push   %edi
801047a4:	56                   	push   %esi
801047a5:	53                   	push   %ebx
801047a6:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801047a9:	8d 45 e0             	lea    -0x20(%ebp),%eax
801047ac:	50                   	push   %eax
801047ad:	6a 00                	push   $0x0
801047af:	e8 c8 f8 ff ff       	call   8010407c <argstr>
801047b4:	83 c4 10             	add    $0x10,%esp
801047b7:	85 c0                	test   %eax,%eax
801047b9:	0f 88 fe 00 00 00    	js     801048bd <sys_open+0x11d>
801047bf:	83 ec 08             	sub    $0x8,%esp
801047c2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801047c5:	50                   	push   %eax
801047c6:	6a 01                	push   $0x1
801047c8:	e8 2f f8 ff ff       	call   80103ffc <argint>
801047cd:	83 c4 10             	add    $0x10,%esp
801047d0:	85 c0                	test   %eax,%eax
801047d2:	0f 88 e5 00 00 00    	js     801048bd <sys_open+0x11d>
    return -1;

  begin_op();
801047d8:	e8 8b df ff ff       	call   80102768 <begin_op>

  if(omode & O_CREATE){
801047dd:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801047e1:	0f 85 8d 00 00 00    	jne    80104874 <sys_open+0xd4>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801047e7:	83 ec 0c             	sub    $0xc,%esp
801047ea:	ff 75 e0             	pushl  -0x20(%ebp)
801047ed:	e8 c2 d4 ff ff       	call   80101cb4 <namei>
801047f2:	89 c7                	mov    %eax,%edi
801047f4:	83 c4 10             	add    $0x10,%esp
801047f7:	85 c0                	test   %eax,%eax
801047f9:	0f 84 92 00 00 00    	je     80104891 <sys_open+0xf1>
      end_op();
      return -1;
    }
    ilock(ip);
801047ff:	83 ec 0c             	sub    $0xc,%esp
80104802:	50                   	push   %eax
80104803:	e8 cc cc ff ff       	call   801014d4 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80104808:	83 c4 10             	add    $0x10,%esp
8010480b:	66 83 7f 50 01       	cmpw   $0x1,0x50(%edi)
80104810:	0f 84 8a 00 00 00    	je     801048a0 <sys_open+0x100>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80104816:	e8 6d c4 ff ff       	call   80100c88 <filealloc>
8010481b:	89 c3                	mov    %eax,%ebx
8010481d:	85 c0                	test   %eax,%eax
8010481f:	0f 84 87 00 00 00    	je     801048ac <sys_open+0x10c>
80104825:	e8 e2 f8 ff ff       	call   8010410c <fdalloc>
8010482a:	89 c6                	mov    %eax,%esi
8010482c:	85 c0                	test   %eax,%eax
8010482e:	0f 88 98 00 00 00    	js     801048cc <sys_open+0x12c>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80104834:	83 ec 0c             	sub    $0xc,%esp
80104837:	57                   	push   %edi
80104838:	e8 5f cd ff ff       	call   8010159c <iunlock>
  end_op();
8010483d:	e8 8e df ff ff       	call   801027d0 <end_op>

  f->type = FD_INODE;
80104842:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  f->ip = ip;
80104848:	89 7b 10             	mov    %edi,0x10(%ebx)
  f->off = 0;
8010484b:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  f->readable = !(omode & O_WRONLY);
80104852:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104855:	89 d0                	mov    %edx,%eax
80104857:	83 e0 01             	and    $0x1,%eax
8010485a:	83 f0 01             	xor    $0x1,%eax
8010485d:	88 43 08             	mov    %al,0x8(%ebx)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80104860:	83 c4 10             	add    $0x10,%esp
80104863:	83 e2 03             	and    $0x3,%edx
80104866:	0f 95 43 09          	setne  0x9(%ebx)
  return fd;
8010486a:	89 f0                	mov    %esi,%eax
}
8010486c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010486f:	5b                   	pop    %ebx
80104870:	5e                   	pop    %esi
80104871:	5f                   	pop    %edi
80104872:	5d                   	pop    %ebp
80104873:	c3                   	ret    
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80104874:	83 ec 0c             	sub    $0xc,%esp
80104877:	6a 00                	push   $0x0
80104879:	31 c9                	xor    %ecx,%ecx
8010487b:	ba 02 00 00 00       	mov    $0x2,%edx
80104880:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104883:	e8 b8 f8 ff ff       	call   80104140 <create>
80104888:	89 c7                	mov    %eax,%edi
    if(ip == 0){
8010488a:	83 c4 10             	add    $0x10,%esp
8010488d:	85 c0                	test   %eax,%eax
8010488f:	75 85                	jne    80104816 <sys_open+0x76>
      end_op();
80104891:	e8 3a df ff ff       	call   801027d0 <end_op>
      return -1;
80104896:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010489b:	eb cf                	jmp    8010486c <sys_open+0xcc>
8010489d:	8d 76 00             	lea    0x0(%esi),%esi
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
801048a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801048a3:	85 c0                	test   %eax,%eax
801048a5:	0f 84 6b ff ff ff    	je     80104816 <sys_open+0x76>
801048ab:	90                   	nop
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
801048ac:	83 ec 0c             	sub    $0xc,%esp
801048af:	57                   	push   %edi
801048b0:	e8 73 ce ff ff       	call   80101728 <iunlockput>
    end_op();
801048b5:	e8 16 df ff ff       	call   801027d0 <end_op>
    return -1;
801048ba:	83 c4 10             	add    $0x10,%esp
801048bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
801048c2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801048c5:	5b                   	pop    %ebx
801048c6:	5e                   	pop    %esi
801048c7:	5f                   	pop    %edi
801048c8:	5d                   	pop    %ebp
801048c9:	c3                   	ret    
801048ca:	66 90                	xchg   %ax,%ax
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
801048cc:	83 ec 0c             	sub    $0xc,%esp
801048cf:	53                   	push   %ebx
801048d0:	e8 5b c4 ff ff       	call   80100d30 <fileclose>
801048d5:	83 c4 10             	add    $0x10,%esp
801048d8:	eb d2                	jmp    801048ac <sys_open+0x10c>
801048da:	66 90                	xchg   %ax,%ax

801048dc <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
801048dc:	55                   	push   %ebp
801048dd:	89 e5                	mov    %esp,%ebp
801048df:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801048e2:	e8 81 de ff ff       	call   80102768 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801048e7:	83 ec 08             	sub    $0x8,%esp
801048ea:	8d 45 f4             	lea    -0xc(%ebp),%eax
801048ed:	50                   	push   %eax
801048ee:	6a 00                	push   $0x0
801048f0:	e8 87 f7 ff ff       	call   8010407c <argstr>
801048f5:	83 c4 10             	add    $0x10,%esp
801048f8:	85 c0                	test   %eax,%eax
801048fa:	78 30                	js     8010492c <sys_mkdir+0x50>
801048fc:	83 ec 0c             	sub    $0xc,%esp
801048ff:	6a 00                	push   $0x0
80104901:	31 c9                	xor    %ecx,%ecx
80104903:	ba 01 00 00 00       	mov    $0x1,%edx
80104908:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010490b:	e8 30 f8 ff ff       	call   80104140 <create>
80104910:	83 c4 10             	add    $0x10,%esp
80104913:	85 c0                	test   %eax,%eax
80104915:	74 15                	je     8010492c <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80104917:	83 ec 0c             	sub    $0xc,%esp
8010491a:	50                   	push   %eax
8010491b:	e8 08 ce ff ff       	call   80101728 <iunlockput>
  end_op();
80104920:	e8 ab de ff ff       	call   801027d0 <end_op>
  return 0;
80104925:	83 c4 10             	add    $0x10,%esp
80104928:	31 c0                	xor    %eax,%eax
}
8010492a:	c9                   	leave  
8010492b:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
8010492c:	e8 9f de ff ff       	call   801027d0 <end_op>
    return -1;
80104931:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
80104936:	c9                   	leave  
80104937:	c3                   	ret    

80104938 <sys_mknod>:

int
sys_mknod(void)
{
80104938:	55                   	push   %ebp
80104939:	89 e5                	mov    %esp,%ebp
8010493b:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
8010493e:	e8 25 de ff ff       	call   80102768 <begin_op>
  if((argstr(0, &path)) < 0 ||
80104943:	83 ec 08             	sub    $0x8,%esp
80104946:	8d 45 ec             	lea    -0x14(%ebp),%eax
80104949:	50                   	push   %eax
8010494a:	6a 00                	push   $0x0
8010494c:	e8 2b f7 ff ff       	call   8010407c <argstr>
80104951:	83 c4 10             	add    $0x10,%esp
80104954:	85 c0                	test   %eax,%eax
80104956:	78 60                	js     801049b8 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80104958:	83 ec 08             	sub    $0x8,%esp
8010495b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010495e:	50                   	push   %eax
8010495f:	6a 01                	push   $0x1
80104961:	e8 96 f6 ff ff       	call   80103ffc <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
80104966:	83 c4 10             	add    $0x10,%esp
80104969:	85 c0                	test   %eax,%eax
8010496b:	78 4b                	js     801049b8 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
8010496d:	83 ec 08             	sub    $0x8,%esp
80104970:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104973:	50                   	push   %eax
80104974:	6a 02                	push   $0x2
80104976:	e8 81 f6 ff ff       	call   80103ffc <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
8010497b:	83 c4 10             	add    $0x10,%esp
8010497e:	85 c0                	test   %eax,%eax
80104980:	78 36                	js     801049b8 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80104982:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80104985:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80104989:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
8010498d:	50                   	push   %eax
8010498e:	ba 03 00 00 00       	mov    $0x3,%edx
80104993:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104996:	e8 a5 f7 ff ff       	call   80104140 <create>
8010499b:	83 c4 10             	add    $0x10,%esp
8010499e:	85 c0                	test   %eax,%eax
801049a0:	74 16                	je     801049b8 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
801049a2:	83 ec 0c             	sub    $0xc,%esp
801049a5:	50                   	push   %eax
801049a6:	e8 7d cd ff ff       	call   80101728 <iunlockput>
  end_op();
801049ab:	e8 20 de ff ff       	call   801027d0 <end_op>
  return 0;
801049b0:	83 c4 10             	add    $0x10,%esp
801049b3:	31 c0                	xor    %eax,%eax
}
801049b5:	c9                   	leave  
801049b6:	c3                   	ret    
801049b7:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
801049b8:	e8 13 de ff ff       	call   801027d0 <end_op>
    return -1;
801049bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
801049c2:	c9                   	leave  
801049c3:	c3                   	ret    

801049c4 <sys_chdir>:

int
sys_chdir(void)
{
801049c4:	55                   	push   %ebp
801049c5:	89 e5                	mov    %esp,%ebp
801049c7:	56                   	push   %esi
801049c8:	53                   	push   %ebx
801049c9:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801049cc:	e8 f7 e8 ff ff       	call   801032c8 <myproc>
801049d1:	89 c6                	mov    %eax,%esi
  
  begin_op();
801049d3:	e8 90 dd ff ff       	call   80102768 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801049d8:	83 ec 08             	sub    $0x8,%esp
801049db:	8d 45 f4             	lea    -0xc(%ebp),%eax
801049de:	50                   	push   %eax
801049df:	6a 00                	push   $0x0
801049e1:	e8 96 f6 ff ff       	call   8010407c <argstr>
801049e6:	83 c4 10             	add    $0x10,%esp
801049e9:	85 c0                	test   %eax,%eax
801049eb:	78 67                	js     80104a54 <sys_chdir+0x90>
801049ed:	83 ec 0c             	sub    $0xc,%esp
801049f0:	ff 75 f4             	pushl  -0xc(%ebp)
801049f3:	e8 bc d2 ff ff       	call   80101cb4 <namei>
801049f8:	89 c3                	mov    %eax,%ebx
801049fa:	83 c4 10             	add    $0x10,%esp
801049fd:	85 c0                	test   %eax,%eax
801049ff:	74 53                	je     80104a54 <sys_chdir+0x90>
    end_op();
    return -1;
  }
  ilock(ip);
80104a01:	83 ec 0c             	sub    $0xc,%esp
80104a04:	50                   	push   %eax
80104a05:	e8 ca ca ff ff       	call   801014d4 <ilock>
  if(ip->type != T_DIR){
80104a0a:	83 c4 10             	add    $0x10,%esp
80104a0d:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104a12:	75 28                	jne    80104a3c <sys_chdir+0x78>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80104a14:	83 ec 0c             	sub    $0xc,%esp
80104a17:	53                   	push   %ebx
80104a18:	e8 7f cb ff ff       	call   8010159c <iunlock>
  iput(curproc->cwd);
80104a1d:	58                   	pop    %eax
80104a1e:	ff 76 68             	pushl  0x68(%esi)
80104a21:	e8 ba cb ff ff       	call   801015e0 <iput>
  end_op();
80104a26:	e8 a5 dd ff ff       	call   801027d0 <end_op>
  curproc->cwd = ip;
80104a2b:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80104a2e:	83 c4 10             	add    $0x10,%esp
80104a31:	31 c0                	xor    %eax,%eax
}
80104a33:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a36:	5b                   	pop    %ebx
80104a37:	5e                   	pop    %esi
80104a38:	5d                   	pop    %ebp
80104a39:	c3                   	ret    
80104a3a:	66 90                	xchg   %ax,%ax
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80104a3c:	83 ec 0c             	sub    $0xc,%esp
80104a3f:	53                   	push   %ebx
80104a40:	e8 e3 cc ff ff       	call   80101728 <iunlockput>
    end_op();
80104a45:	e8 86 dd ff ff       	call   801027d0 <end_op>
    return -1;
80104a4a:	83 c4 10             	add    $0x10,%esp
80104a4d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a52:	eb df                	jmp    80104a33 <sys_chdir+0x6f>
  struct inode *ip;
  struct proc *curproc = myproc();
  
  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
80104a54:	e8 77 dd ff ff       	call   801027d0 <end_op>
    return -1;
80104a59:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a5e:	eb d3                	jmp    80104a33 <sys_chdir+0x6f>

80104a60 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
80104a60:	55                   	push   %ebp
80104a61:	89 e5                	mov    %esp,%ebp
80104a63:	57                   	push   %edi
80104a64:	56                   	push   %esi
80104a65:	53                   	push   %ebx
80104a66:	81 ec b4 00 00 00    	sub    $0xb4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80104a6c:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80104a72:	50                   	push   %eax
80104a73:	6a 00                	push   $0x0
80104a75:	e8 02 f6 ff ff       	call   8010407c <argstr>
80104a7a:	83 c4 10             	add    $0x10,%esp
80104a7d:	85 c0                	test   %eax,%eax
80104a7f:	0f 88 8b 00 00 00    	js     80104b10 <sys_exec+0xb0>
80104a85:	83 ec 08             	sub    $0x8,%esp
80104a88:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80104a8e:	50                   	push   %eax
80104a8f:	6a 01                	push   $0x1
80104a91:	e8 66 f5 ff ff       	call   80103ffc <argint>
80104a96:	83 c4 10             	add    $0x10,%esp
80104a99:	85 c0                	test   %eax,%eax
80104a9b:	78 73                	js     80104b10 <sys_exec+0xb0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80104a9d:	50                   	push   %eax
80104a9e:	68 80 00 00 00       	push   $0x80
80104aa3:	6a 00                	push   $0x0
80104aa5:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80104aab:	56                   	push   %esi
80104aac:	e8 e7 f2 ff ff       	call   80103d98 <memset>
80104ab1:	83 c4 10             	add    $0x10,%esp
80104ab4:	31 db                	xor    %ebx,%ebx
80104ab6:	c7 85 54 ff ff ff 00 	movl   $0x0,-0xac(%ebp)
80104abd:	00 00 00 
80104ac0:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80104ac6:	66 90                	xchg   %ax,%ax
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80104ac8:	83 ec 08             	sub    $0x8,%esp
80104acb:	57                   	push   %edi
80104acc:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80104ad2:	01 d8                	add    %ebx,%eax
80104ad4:	50                   	push   %eax
80104ad5:	e8 ae f4 ff ff       	call   80103f88 <fetchint>
80104ada:	83 c4 10             	add    $0x10,%esp
80104add:	85 c0                	test   %eax,%eax
80104adf:	78 2f                	js     80104b10 <sys_exec+0xb0>
      return -1;
    if(uarg == 0){
80104ae1:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80104ae7:	85 c0                	test   %eax,%eax
80104ae9:	74 35                	je     80104b20 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80104aeb:	83 ec 08             	sub    $0x8,%esp
80104aee:	8d 14 1e             	lea    (%esi,%ebx,1),%edx
80104af1:	52                   	push   %edx
80104af2:	50                   	push   %eax
80104af3:	e8 c0 f4 ff ff       	call   80103fb8 <fetchstr>
80104af8:	83 c4 10             	add    $0x10,%esp
80104afb:	85 c0                	test   %eax,%eax
80104afd:	78 11                	js     80104b10 <sys_exec+0xb0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80104aff:	ff 85 54 ff ff ff    	incl   -0xac(%ebp)
80104b05:	83 c3 04             	add    $0x4,%ebx
    if(i >= NELEM(argv))
80104b08:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
80104b0e:	75 b8                	jne    80104ac8 <sys_exec+0x68>
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
80104b10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80104b15:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b18:	5b                   	pop    %ebx
80104b19:	5e                   	pop    %esi
80104b1a:	5f                   	pop    %edi
80104b1b:	5d                   	pop    %ebp
80104b1c:	c3                   	ret    
80104b1d:	8d 76 00             	lea    0x0(%esi),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80104b20:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
80104b26:	c7 84 85 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%eax,4)
80104b2d:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80104b31:	83 ec 08             	sub    $0x8,%esp
80104b34:	56                   	push   %esi
80104b35:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80104b3b:	e8 dc bd ff ff       	call   8010091c <exec>
80104b40:	83 c4 10             	add    $0x10,%esp
}
80104b43:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b46:	5b                   	pop    %ebx
80104b47:	5e                   	pop    %esi
80104b48:	5f                   	pop    %edi
80104b49:	5d                   	pop    %ebp
80104b4a:	c3                   	ret    
80104b4b:	90                   	nop

80104b4c <sys_pipe>:

int
sys_pipe(void)
{
80104b4c:	55                   	push   %ebp
80104b4d:	89 e5                	mov    %esp,%ebp
80104b4f:	53                   	push   %ebx
80104b50:	83 ec 18             	sub    $0x18,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80104b53:	6a 08                	push   $0x8
80104b55:	8d 45 ec             	lea    -0x14(%ebp),%eax
80104b58:	50                   	push   %eax
80104b59:	6a 00                	push   $0x0
80104b5b:	e8 c4 f4 ff ff       	call   80104024 <argptr>
80104b60:	83 c4 10             	add    $0x10,%esp
80104b63:	85 c0                	test   %eax,%eax
80104b65:	78 69                	js     80104bd0 <sys_pipe+0x84>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80104b67:	83 ec 08             	sub    $0x8,%esp
80104b6a:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b6d:	50                   	push   %eax
80104b6e:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104b71:	50                   	push   %eax
80104b72:	e8 f1 e1 ff ff       	call   80102d68 <pipealloc>
80104b77:	83 c4 10             	add    $0x10,%esp
80104b7a:	85 c0                	test   %eax,%eax
80104b7c:	78 52                	js     80104bd0 <sys_pipe+0x84>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80104b7e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104b81:	e8 86 f5 ff ff       	call   8010410c <fdalloc>
80104b86:	89 c3                	mov    %eax,%ebx
80104b88:	85 c0                	test   %eax,%eax
80104b8a:	78 2d                	js     80104bb9 <sys_pipe+0x6d>
80104b8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b8f:	e8 78 f5 ff ff       	call   8010410c <fdalloc>
80104b94:	85 c0                	test   %eax,%eax
80104b96:	78 14                	js     80104bac <sys_pipe+0x60>
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80104b98:	8b 55 ec             	mov    -0x14(%ebp),%edx
80104b9b:	89 1a                	mov    %ebx,(%edx)
  fd[1] = fd1;
80104b9d:	8b 55 ec             	mov    -0x14(%ebp),%edx
80104ba0:	89 42 04             	mov    %eax,0x4(%edx)
  return 0;
80104ba3:	31 c0                	xor    %eax,%eax
}
80104ba5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ba8:	c9                   	leave  
80104ba9:	c3                   	ret    
80104baa:	66 90                	xchg   %ax,%ax
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80104bac:	e8 17 e7 ff ff       	call   801032c8 <myproc>
80104bb1:	c7 44 98 28 00 00 00 	movl   $0x0,0x28(%eax,%ebx,4)
80104bb8:	00 
    fileclose(rf);
80104bb9:	83 ec 0c             	sub    $0xc,%esp
80104bbc:	ff 75 f0             	pushl  -0x10(%ebp)
80104bbf:	e8 6c c1 ff ff       	call   80100d30 <fileclose>
    fileclose(wf);
80104bc4:	58                   	pop    %eax
80104bc5:	ff 75 f4             	pushl  -0xc(%ebp)
80104bc8:	e8 63 c1 ff ff       	call   80100d30 <fileclose>
    return -1;
80104bcd:	83 c4 10             	add    $0x10,%esp
80104bd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80104bd5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104bd8:	c9                   	leave  
80104bd9:	c3                   	ret    
80104bda:	66 90                	xchg   %ax,%ax

80104bdc <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80104bdc:	55                   	push   %ebp
80104bdd:	89 e5                	mov    %esp,%ebp
  return fork();
}
80104bdf:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80104be0:	e9 4b e8 ff ff       	jmp    80103430 <fork>
80104be5:	8d 76 00             	lea    0x0(%esi),%esi

80104be8 <sys_exit>:
}

int
sys_exit(void)
{
80104be8:	55                   	push   %ebp
80104be9:	89 e5                	mov    %esp,%ebp
80104beb:	83 ec 08             	sub    $0x8,%esp
  exit();
80104bee:	e8 81 ea ff ff       	call   80103674 <exit>
  return 0;  // not reached
}
80104bf3:	31 c0                	xor    %eax,%eax
80104bf5:	c9                   	leave  
80104bf6:	c3                   	ret    
80104bf7:	90                   	nop

80104bf8 <sys_wait>:

int
sys_wait(void)
{
80104bf8:	55                   	push   %ebp
80104bf9:	89 e5                	mov    %esp,%ebp
  return wait();
}
80104bfb:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
80104bfc:	e9 67 ec ff ff       	jmp    80103868 <wait>
80104c01:	8d 76 00             	lea    0x0(%esi),%esi

80104c04 <sys_kill>:
}

int
sys_kill(void)
{
80104c04:	55                   	push   %ebp
80104c05:	89 e5                	mov    %esp,%ebp
80104c07:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80104c0a:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c0d:	50                   	push   %eax
80104c0e:	6a 00                	push   $0x0
80104c10:	e8 e7 f3 ff ff       	call   80103ffc <argint>
80104c15:	83 c4 10             	add    $0x10,%esp
80104c18:	85 c0                	test   %eax,%eax
80104c1a:	78 10                	js     80104c2c <sys_kill+0x28>
    return -1;
  return kill(pid);
80104c1c:	83 ec 0c             	sub    $0xc,%esp
80104c1f:	ff 75 f4             	pushl  -0xc(%ebp)
80104c22:	e8 79 ed ff ff       	call   801039a0 <kill>
80104c27:	83 c4 10             	add    $0x10,%esp
}
80104c2a:	c9                   	leave  
80104c2b:	c3                   	ret    
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80104c2c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80104c31:	c9                   	leave  
80104c32:	c3                   	ret    
80104c33:	90                   	nop

80104c34 <sys_getpid>:

int
sys_getpid(void)
{
80104c34:	55                   	push   %ebp
80104c35:	89 e5                	mov    %esp,%ebp
80104c37:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80104c3a:	e8 89 e6 ff ff       	call   801032c8 <myproc>
80104c3f:	8b 40 10             	mov    0x10(%eax),%eax
}
80104c42:	c9                   	leave  
80104c43:	c3                   	ret    

80104c44 <sys_sbrk>:

int
sys_sbrk(void)
{
80104c44:	55                   	push   %ebp
80104c45:	89 e5                	mov    %esp,%ebp
80104c47:	53                   	push   %ebx
80104c48:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80104c4b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c4e:	50                   	push   %eax
80104c4f:	6a 00                	push   $0x0
80104c51:	e8 a6 f3 ff ff       	call   80103ffc <argint>
80104c56:	83 c4 10             	add    $0x10,%esp
80104c59:	85 c0                	test   %eax,%eax
80104c5b:	78 23                	js     80104c80 <sys_sbrk+0x3c>
    return -1;
  addr = myproc()->sz;
80104c5d:	e8 66 e6 ff ff       	call   801032c8 <myproc>
80104c62:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80104c64:	83 ec 0c             	sub    $0xc,%esp
80104c67:	ff 75 f4             	pushl  -0xc(%ebp)
80104c6a:	e8 5d e7 ff ff       	call   801033cc <growproc>
80104c6f:	83 c4 10             	add    $0x10,%esp
80104c72:	85 c0                	test   %eax,%eax
80104c74:	78 0a                	js     80104c80 <sys_sbrk+0x3c>
    return -1;
  return addr;
80104c76:	89 d8                	mov    %ebx,%eax
}
80104c78:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c7b:	c9                   	leave  
80104c7c:	c3                   	ret    
80104c7d:	8d 76 00             	lea    0x0(%esi),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80104c80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c85:	eb f1                	jmp    80104c78 <sys_sbrk+0x34>
80104c87:	90                   	nop

80104c88 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80104c88:	55                   	push   %ebp
80104c89:	89 e5                	mov    %esp,%ebp
80104c8b:	53                   	push   %ebx
80104c8c:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80104c8f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c92:	50                   	push   %eax
80104c93:	6a 00                	push   $0x0
80104c95:	e8 62 f3 ff ff       	call   80103ffc <argint>
80104c9a:	83 c4 10             	add    $0x10,%esp
80104c9d:	85 c0                	test   %eax,%eax
80104c9f:	78 7e                	js     80104d1f <sys_sleep+0x97>
    return -1;
  acquire(&tickslock);
80104ca1:	83 ec 0c             	sub    $0xc,%esp
80104ca4:	68 60 3c 11 80       	push   $0x80113c60
80104ca9:	e8 ca ef ff ff       	call   80103c78 <acquire>
  ticks0 = ticks;
80104cae:	8b 1d a0 44 11 80    	mov    0x801144a0,%ebx
  while(ticks - ticks0 < n){
80104cb4:	83 c4 10             	add    $0x10,%esp
80104cb7:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104cba:	85 d2                	test   %edx,%edx
80104cbc:	75 23                	jne    80104ce1 <sys_sleep+0x59>
80104cbe:	eb 48                	jmp    80104d08 <sys_sleep+0x80>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80104cc0:	83 ec 08             	sub    $0x8,%esp
80104cc3:	68 60 3c 11 80       	push   $0x80113c60
80104cc8:	68 a0 44 11 80       	push   $0x801144a0
80104ccd:	e8 ea ea ff ff       	call   801037bc <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80104cd2:	a1 a0 44 11 80       	mov    0x801144a0,%eax
80104cd7:	29 d8                	sub    %ebx,%eax
80104cd9:	83 c4 10             	add    $0x10,%esp
80104cdc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80104cdf:	73 27                	jae    80104d08 <sys_sleep+0x80>
    if(myproc()->killed){
80104ce1:	e8 e2 e5 ff ff       	call   801032c8 <myproc>
80104ce6:	8b 40 24             	mov    0x24(%eax),%eax
80104ce9:	85 c0                	test   %eax,%eax
80104ceb:	74 d3                	je     80104cc0 <sys_sleep+0x38>
      release(&tickslock);
80104ced:	83 ec 0c             	sub    $0xc,%esp
80104cf0:	68 60 3c 11 80       	push   $0x80113c60
80104cf5:	e8 52 f0 ff ff       	call   80103d4c <release>
      return -1;
80104cfa:	83 c4 10             	add    $0x10,%esp
80104cfd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80104d02:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d05:	c9                   	leave  
80104d06:	c3                   	ret    
80104d07:	90                   	nop
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80104d08:	83 ec 0c             	sub    $0xc,%esp
80104d0b:	68 60 3c 11 80       	push   $0x80113c60
80104d10:	e8 37 f0 ff ff       	call   80103d4c <release>
  return 0;
80104d15:	83 c4 10             	add    $0x10,%esp
80104d18:	31 c0                	xor    %eax,%eax
}
80104d1a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d1d:	c9                   	leave  
80104d1e:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
80104d1f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d24:	eb dc                	jmp    80104d02 <sys_sleep+0x7a>
80104d26:	66 90                	xchg   %ax,%ax

80104d28 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80104d28:	55                   	push   %ebp
80104d29:	89 e5                	mov    %esp,%ebp
80104d2b:	53                   	push   %ebx
80104d2c:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80104d2f:	68 60 3c 11 80       	push   $0x80113c60
80104d34:	e8 3f ef ff ff       	call   80103c78 <acquire>
  xticks = ticks;
80104d39:	8b 1d a0 44 11 80    	mov    0x801144a0,%ebx
  release(&tickslock);
80104d3f:	c7 04 24 60 3c 11 80 	movl   $0x80113c60,(%esp)
80104d46:	e8 01 f0 ff ff       	call   80103d4c <release>
  return xticks;
}
80104d4b:	89 d8                	mov    %ebx,%eax
80104d4d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d50:	c9                   	leave  
80104d51:	c3                   	ret    
80104d52:	66 90                	xchg   %ax,%ax

80104d54 <sys_mike>:

int
sys_mike(void)
{
80104d54:	55                   	push   %ebp
80104d55:	89 e5                	mov    %esp,%ebp
    return mike();
}
80104d57:	5d                   	pop    %ebp
}

int
sys_mike(void)
{
    return mike();
80104d58:	e9 8b e4 ff ff       	jmp    801031e8 <mike>

80104d5d <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80104d5d:	1e                   	push   %ds
  pushl %es
80104d5e:	06                   	push   %es
  pushl %fs
80104d5f:	0f a0                	push   %fs
  pushl %gs
80104d61:	0f a8                	push   %gs
  pushal
80104d63:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80104d64:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80104d68:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80104d6a:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80104d6c:	54                   	push   %esp
  call trap
80104d6d:	e8 ba 00 00 00       	call   80104e2c <trap>
  addl $4, %esp
80104d72:	83 c4 04             	add    $0x4,%esp

80104d75 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80104d75:	61                   	popa   
  popl %gs
80104d76:	0f a9                	pop    %gs
  popl %fs
80104d78:	0f a1                	pop    %fs
  popl %es
80104d7a:	07                   	pop    %es
  popl %ds
80104d7b:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80104d7c:	83 c4 08             	add    $0x8,%esp
  iret
80104d7f:	cf                   	iret   

80104d80 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80104d80:	31 c0                	xor    %eax,%eax
80104d82:	66 90                	xchg   %ax,%ax
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80104d84:	8b 14 85 08 90 10 80 	mov    -0x7fef6ff8(,%eax,4),%edx
80104d8b:	66 89 14 c5 a0 3c 11 	mov    %dx,-0x7feec360(,%eax,8)
80104d92:	80 
80104d93:	66 c7 04 c5 a2 3c 11 	movw   $0x8,-0x7feec35e(,%eax,8)
80104d9a:	80 08 00 
80104d9d:	c6 04 c5 a4 3c 11 80 	movb   $0x0,-0x7feec35c(,%eax,8)
80104da4:	00 
80104da5:	c6 04 c5 a5 3c 11 80 	movb   $0x8e,-0x7feec35b(,%eax,8)
80104dac:	8e 
80104dad:	c1 ea 10             	shr    $0x10,%edx
80104db0:	66 89 14 c5 a6 3c 11 	mov    %dx,-0x7feec35a(,%eax,8)
80104db7:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80104db8:	40                   	inc    %eax
80104db9:	3d 00 01 00 00       	cmp    $0x100,%eax
80104dbe:	75 c4                	jne    80104d84 <tvinit+0x4>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80104dc0:	55                   	push   %ebp
80104dc1:	89 e5                	mov    %esp,%ebp
80104dc3:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80104dc6:	a1 08 91 10 80       	mov    0x80109108,%eax
80104dcb:	66 a3 a0 3e 11 80    	mov    %ax,0x80113ea0
80104dd1:	66 c7 05 a2 3e 11 80 	movw   $0x8,0x80113ea2
80104dd8:	08 00 
80104dda:	c6 05 a4 3e 11 80 00 	movb   $0x0,0x80113ea4
80104de1:	c6 05 a5 3e 11 80 ef 	movb   $0xef,0x80113ea5
80104de8:	c1 e8 10             	shr    $0x10,%eax
80104deb:	66 a3 a6 3e 11 80    	mov    %ax,0x80113ea6

  initlock(&tickslock, "time");
80104df1:	68 1d 6c 10 80       	push   $0x80106c1d
80104df6:	68 60 3c 11 80       	push   $0x80113c60
80104dfb:	e8 b4 ed ff ff       	call   80103bb4 <initlock>
80104e00:	83 c4 10             	add    $0x10,%esp
}
80104e03:	c9                   	leave  
80104e04:	c3                   	ret    
80104e05:	8d 76 00             	lea    0x0(%esi),%esi

80104e08 <idtinit>:

void
idtinit(void)
{
80104e08:	55                   	push   %ebp
80104e09:	89 e5                	mov    %esp,%ebp
80104e0b:	83 ec 10             	sub    $0x10,%esp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80104e0e:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80104e14:	b8 a0 3c 11 80       	mov    $0x80113ca0,%eax
80104e19:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80104e1d:	c1 e8 10             	shr    $0x10,%eax
80104e20:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80104e24:	8d 45 fa             	lea    -0x6(%ebp),%eax
80104e27:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80104e2a:	c9                   	leave  
80104e2b:	c3                   	ret    

80104e2c <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80104e2c:	55                   	push   %ebp
80104e2d:	89 e5                	mov    %esp,%ebp
80104e2f:	57                   	push   %edi
80104e30:	56                   	push   %esi
80104e31:	53                   	push   %ebx
80104e32:	83 ec 1c             	sub    $0x1c,%esp
80104e35:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80104e38:	8b 47 30             	mov    0x30(%edi),%eax
80104e3b:	83 f8 40             	cmp    $0x40,%eax
80104e3e:	0f 84 64 01 00 00    	je     80104fa8 <trap+0x17c>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80104e44:	83 e8 20             	sub    $0x20,%eax
80104e47:	83 f8 1f             	cmp    $0x1f,%eax
80104e4a:	77 08                	ja     80104e54 <trap+0x28>
80104e4c:	ff 24 85 c4 6c 10 80 	jmp    *-0x7fef933c(,%eax,4)
80104e53:	90                   	nop
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80104e54:	e8 6f e4 ff ff       	call   801032c8 <myproc>
80104e59:	85 c0                	test   %eax,%eax
80104e5b:	0f 84 ba 01 00 00    	je     8010501b <trap+0x1ef>
80104e61:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80104e65:	0f 84 b0 01 00 00    	je     8010501b <trap+0x1ef>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80104e6b:	0f 20 d1             	mov    %cr2,%ecx
80104e6e:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80104e71:	8b 57 38             	mov    0x38(%edi),%edx
80104e74:	89 55 dc             	mov    %edx,-0x24(%ebp)
80104e77:	e8 18 e4 ff ff       	call   80103294 <cpuid>
80104e7c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104e7f:	8b 77 34             	mov    0x34(%edi),%esi
80104e82:	8b 5f 30             	mov    0x30(%edi),%ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80104e85:	e8 3e e4 ff ff       	call   801032c8 <myproc>
80104e8a:	89 45 e0             	mov    %eax,-0x20(%ebp)
80104e8d:	e8 36 e4 ff ff       	call   801032c8 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80104e92:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80104e95:	51                   	push   %ecx
80104e96:	8b 55 dc             	mov    -0x24(%ebp),%edx
80104e99:	52                   	push   %edx
80104e9a:	ff 75 e4             	pushl  -0x1c(%ebp)
80104e9d:	56                   	push   %esi
80104e9e:	53                   	push   %ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80104e9f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104ea2:	83 c2 6c             	add    $0x6c,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80104ea5:	52                   	push   %edx
80104ea6:	ff 70 10             	pushl  0x10(%eax)
80104ea9:	68 80 6c 10 80       	push   $0x80106c80
80104eae:	e8 55 b7 ff ff       	call   80100608 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80104eb3:	83 c4 20             	add    $0x20,%esp
80104eb6:	e8 0d e4 ff ff       	call   801032c8 <myproc>
80104ebb:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80104ec2:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80104ec4:	e8 ff e3 ff ff       	call   801032c8 <myproc>
80104ec9:	85 c0                	test   %eax,%eax
80104ecb:	74 0c                	je     80104ed9 <trap+0xad>
80104ecd:	e8 f6 e3 ff ff       	call   801032c8 <myproc>
80104ed2:	8b 50 24             	mov    0x24(%eax),%edx
80104ed5:	85 d2                	test   %edx,%edx
80104ed7:	75 43                	jne    80104f1c <trap+0xf0>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80104ed9:	e8 ea e3 ff ff       	call   801032c8 <myproc>
80104ede:	85 c0                	test   %eax,%eax
80104ee0:	74 0b                	je     80104eed <trap+0xc1>
80104ee2:	e8 e1 e3 ff ff       	call   801032c8 <myproc>
80104ee7:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80104eeb:	74 43                	je     80104f30 <trap+0x104>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80104eed:	e8 d6 e3 ff ff       	call   801032c8 <myproc>
80104ef2:	85 c0                	test   %eax,%eax
80104ef4:	74 1c                	je     80104f12 <trap+0xe6>
80104ef6:	e8 cd e3 ff ff       	call   801032c8 <myproc>
80104efb:	8b 40 24             	mov    0x24(%eax),%eax
80104efe:	85 c0                	test   %eax,%eax
80104f00:	74 10                	je     80104f12 <trap+0xe6>
80104f02:	8b 47 3c             	mov    0x3c(%edi),%eax
80104f05:	83 e0 03             	and    $0x3,%eax
80104f08:	66 83 f8 03          	cmp    $0x3,%ax
80104f0c:	0f 84 bf 00 00 00    	je     80104fd1 <trap+0x1a5>
    exit();
}
80104f12:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f15:	5b                   	pop    %ebx
80104f16:	5e                   	pop    %esi
80104f17:	5f                   	pop    %edi
80104f18:	5d                   	pop    %ebp
80104f19:	c3                   	ret    
80104f1a:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80104f1c:	8b 47 3c             	mov    0x3c(%edi),%eax
80104f1f:	83 e0 03             	and    $0x3,%eax
80104f22:	66 83 f8 03          	cmp    $0x3,%ax
80104f26:	75 b1                	jne    80104ed9 <trap+0xad>
    exit();
80104f28:	e8 47 e7 ff ff       	call   80103674 <exit>
80104f2d:	eb aa                	jmp    80104ed9 <trap+0xad>
80104f2f:	90                   	nop

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80104f30:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80104f34:	75 b7                	jne    80104eed <trap+0xc1>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
80104f36:	e8 4d e8 ff ff       	call   80103788 <yield>
80104f3b:	eb b0                	jmp    80104eed <trap+0xc1>
80104f3d:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80104f40:	e8 4f e3 ff ff       	call   80103294 <cpuid>
80104f45:	85 c0                	test   %eax,%eax
80104f47:	0f 84 9b 00 00 00    	je     80104fe8 <trap+0x1bc>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80104f4d:	e8 12 d5 ff ff       	call   80102464 <lapiceoi>
    break;
80104f52:	e9 6d ff ff ff       	jmp    80104ec4 <trap+0x98>
80104f57:	90                   	nop
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80104f58:	e8 8f d3 ff ff       	call   801022ec <kbdintr>
    lapiceoi();
80104f5d:	e8 02 d5 ff ff       	call   80102464 <lapiceoi>
    break;
80104f62:	e9 5d ff ff ff       	jmp    80104ec4 <trap+0x98>
80104f67:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80104f68:	e8 fb 01 00 00       	call   80105168 <uartintr>
    lapiceoi();
80104f6d:	e8 f2 d4 ff ff       	call   80102464 <lapiceoi>
    break;
80104f72:	e9 4d ff ff ff       	jmp    80104ec4 <trap+0x98>
80104f77:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80104f78:	8b 77 38             	mov    0x38(%edi),%esi
80104f7b:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80104f7f:	e8 10 e3 ff ff       	call   80103294 <cpuid>
80104f84:	56                   	push   %esi
80104f85:	53                   	push   %ebx
80104f86:	50                   	push   %eax
80104f87:	68 28 6c 10 80       	push   $0x80106c28
80104f8c:	e8 77 b6 ff ff       	call   80100608 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80104f91:	e8 ce d4 ff ff       	call   80102464 <lapiceoi>
    break;
80104f96:	83 c4 10             	add    $0x10,%esp
80104f99:	e9 26 ff ff ff       	jmp    80104ec4 <trap+0x98>
80104f9e:	66 90                	xchg   %ax,%ax
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80104fa0:	e8 4b ce ff ff       	call   80101df0 <ideintr>
80104fa5:	eb a6                	jmp    80104f4d <trap+0x121>
80104fa7:	90                   	nop
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80104fa8:	e8 1b e3 ff ff       	call   801032c8 <myproc>
80104fad:	8b 58 24             	mov    0x24(%eax),%ebx
80104fb0:	85 db                	test   %ebx,%ebx
80104fb2:	75 2c                	jne    80104fe0 <trap+0x1b4>
      exit();
    myproc()->tf = tf;
80104fb4:	e8 0f e3 ff ff       	call   801032c8 <myproc>
80104fb9:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80104fbc:	e8 ef f0 ff ff       	call   801040b0 <syscall>
    if(myproc()->killed)
80104fc1:	e8 02 e3 ff ff       	call   801032c8 <myproc>
80104fc6:	8b 48 24             	mov    0x24(%eax),%ecx
80104fc9:	85 c9                	test   %ecx,%ecx
80104fcb:	0f 84 41 ff ff ff    	je     80104f12 <trap+0xe6>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80104fd1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104fd4:	5b                   	pop    %ebx
80104fd5:	5e                   	pop    %esi
80104fd6:	5f                   	pop    %edi
80104fd7:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
80104fd8:	e9 97 e6 ff ff       	jmp    80103674 <exit>
80104fdd:	8d 76 00             	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
80104fe0:	e8 8f e6 ff ff       	call   80103674 <exit>
80104fe5:	eb cd                	jmp    80104fb4 <trap+0x188>
80104fe7:	90                   	nop
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
80104fe8:	83 ec 0c             	sub    $0xc,%esp
80104feb:	68 60 3c 11 80       	push   $0x80113c60
80104ff0:	e8 83 ec ff ff       	call   80103c78 <acquire>
      ticks++;
80104ff5:	ff 05 a0 44 11 80    	incl   0x801144a0
      wakeup(&ticks);
80104ffb:	c7 04 24 a0 44 11 80 	movl   $0x801144a0,(%esp)
80105002:	e8 41 e9 ff ff       	call   80103948 <wakeup>
      release(&tickslock);
80105007:	c7 04 24 60 3c 11 80 	movl   $0x80113c60,(%esp)
8010500e:	e8 39 ed ff ff       	call   80103d4c <release>
80105013:	83 c4 10             	add    $0x10,%esp
80105016:	e9 32 ff ff ff       	jmp    80104f4d <trap+0x121>
8010501b:	0f 20 d6             	mov    %cr2,%esi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010501e:	8b 5f 38             	mov    0x38(%edi),%ebx
80105021:	e8 6e e2 ff ff       	call   80103294 <cpuid>
80105026:	83 ec 0c             	sub    $0xc,%esp
80105029:	56                   	push   %esi
8010502a:	53                   	push   %ebx
8010502b:	50                   	push   %eax
8010502c:	ff 77 30             	pushl  0x30(%edi)
8010502f:	68 4c 6c 10 80       	push   $0x80106c4c
80105034:	e8 cf b5 ff ff       	call   80100608 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
80105039:	83 c4 14             	add    $0x14,%esp
8010503c:	68 22 6c 10 80       	push   $0x80106c22
80105041:	e8 f2 b2 ff ff       	call   80100338 <panic>
80105046:	66 90                	xchg   %ax,%ax

80105048 <uartgetc>:
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105048:	55                   	push   %ebp
80105049:	89 e5                	mov    %esp,%ebp
  if(!uart)
8010504b:	a1 bc 95 10 80       	mov    0x801095bc,%eax
80105050:	85 c0                	test   %eax,%eax
80105052:	74 14                	je     80105068 <uartgetc+0x20>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105054:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105059:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010505a:	a8 01                	test   $0x1,%al
8010505c:	74 0a                	je     80105068 <uartgetc+0x20>
8010505e:	b2 f8                	mov    $0xf8,%dl
80105060:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105061:	0f b6 c0             	movzbl %al,%eax
}
80105064:	5d                   	pop    %ebp
80105065:	c3                   	ret    
80105066:	66 90                	xchg   %ax,%ax

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80105068:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
8010506d:	5d                   	pop    %ebp
8010506e:	c3                   	ret    
8010506f:	90                   	nop

80105070 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80105070:	55                   	push   %ebp
80105071:	89 e5                	mov    %esp,%ebp
80105073:	57                   	push   %edi
80105074:	56                   	push   %esi
80105075:	53                   	push   %ebx
80105076:	83 ec 0c             	sub    $0xc,%esp
80105079:	89 c7                	mov    %eax,%edi
8010507b:	bb 80 00 00 00       	mov    $0x80,%ebx
80105080:	be fd 03 00 00       	mov    $0x3fd,%esi
80105085:	eb 11                	jmp    80105098 <uartputc.part.0+0x28>
80105087:	90                   	nop
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80105088:	83 ec 0c             	sub    $0xc,%esp
8010508b:	6a 0a                	push   $0xa
8010508d:	e8 ee d3 ff ff       	call   80102480 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105092:	83 c4 10             	add    $0x10,%esp
80105095:	4b                   	dec    %ebx
80105096:	74 07                	je     8010509f <uartputc.part.0+0x2f>
80105098:	89 f2                	mov    %esi,%edx
8010509a:	ec                   	in     (%dx),%al
8010509b:	a8 20                	test   $0x20,%al
8010509d:	74 e9                	je     80105088 <uartputc.part.0+0x18>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010509f:	ba f8 03 00 00       	mov    $0x3f8,%edx
801050a4:	89 f8                	mov    %edi,%eax
801050a6:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
801050a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801050aa:	5b                   	pop    %ebx
801050ab:	5e                   	pop    %esi
801050ac:	5f                   	pop    %edi
801050ad:	5d                   	pop    %ebp
801050ae:	c3                   	ret    
801050af:	90                   	nop

801050b0 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	57                   	push   %edi
801050b4:	56                   	push   %esi
801050b5:	53                   	push   %ebx
801050b6:	83 ec 0c             	sub    $0xc,%esp
801050b9:	bb fa 03 00 00       	mov    $0x3fa,%ebx
801050be:	31 c0                	xor    %eax,%eax
801050c0:	89 da                	mov    %ebx,%edx
801050c2:	ee                   	out    %al,(%dx)
801050c3:	bf fb 03 00 00       	mov    $0x3fb,%edi
801050c8:	b0 80                	mov    $0x80,%al
801050ca:	89 fa                	mov    %edi,%edx
801050cc:	ee                   	out    %al,(%dx)
801050cd:	b9 f8 03 00 00       	mov    $0x3f8,%ecx
801050d2:	b0 0c                	mov    $0xc,%al
801050d4:	89 ca                	mov    %ecx,%edx
801050d6:	ee                   	out    %al,(%dx)
801050d7:	be f9 03 00 00       	mov    $0x3f9,%esi
801050dc:	31 c0                	xor    %eax,%eax
801050de:	89 f2                	mov    %esi,%edx
801050e0:	ee                   	out    %al,(%dx)
801050e1:	b0 03                	mov    $0x3,%al
801050e3:	89 fa                	mov    %edi,%edx
801050e5:	ee                   	out    %al,(%dx)
801050e6:	b2 fc                	mov    $0xfc,%dl
801050e8:	31 c0                	xor    %eax,%eax
801050ea:	ee                   	out    %al,(%dx)
801050eb:	b0 01                	mov    $0x1,%al
801050ed:	89 f2                	mov    %esi,%edx
801050ef:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801050f0:	b2 fd                	mov    $0xfd,%dl
801050f2:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
801050f3:	fe c0                	inc    %al
801050f5:	74 4d                	je     80105144 <uartinit+0x94>
    return;
  uart = 1;
801050f7:	c7 05 bc 95 10 80 01 	movl   $0x1,0x801095bc
801050fe:	00 00 00 
80105101:	89 da                	mov    %ebx,%edx
80105103:	ec                   	in     (%dx),%al
80105104:	89 ca                	mov    %ecx,%edx
80105106:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
80105107:	83 ec 08             	sub    $0x8,%esp
8010510a:	6a 00                	push   $0x0
8010510c:	6a 04                	push   $0x4
8010510e:	e8 fd ce ff ff       	call   80102010 <ioapicenable>
80105113:	83 c4 10             	add    $0x10,%esp
80105116:	b8 78 00 00 00       	mov    $0x78,%eax
8010511b:	bb 44 6d 10 80       	mov    $0x80106d44,%ebx
80105120:	eb 0a                	jmp    8010512c <uartinit+0x7c>
80105122:	66 90                	xchg   %ax,%ax

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105124:	43                   	inc    %ebx
80105125:	0f be 03             	movsbl (%ebx),%eax
80105128:	84 c0                	test   %al,%al
8010512a:	74 18                	je     80105144 <uartinit+0x94>
void
uartputc(int c)
{
  int i;

  if(!uart)
8010512c:	8b 15 bc 95 10 80    	mov    0x801095bc,%edx
80105132:	85 d2                	test   %edx,%edx
80105134:	74 ee                	je     80105124 <uartinit+0x74>
80105136:	e8 35 ff ff ff       	call   80105070 <uartputc.part.0>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
8010513b:	43                   	inc    %ebx
8010513c:	0f be 03             	movsbl (%ebx),%eax
8010513f:	84 c0                	test   %al,%al
80105141:	75 e9                	jne    8010512c <uartinit+0x7c>
80105143:	90                   	nop
    uartputc(*p);
}
80105144:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105147:	5b                   	pop    %ebx
80105148:	5e                   	pop    %esi
80105149:	5f                   	pop    %edi
8010514a:	5d                   	pop    %ebp
8010514b:	c3                   	ret    

8010514c <uartputc>:

void
uartputc(int c)
{
8010514c:	55                   	push   %ebp
8010514d:	89 e5                	mov    %esp,%ebp
8010514f:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
80105152:	8b 15 bc 95 10 80    	mov    0x801095bc,%edx
80105158:	85 d2                	test   %edx,%edx
8010515a:	74 08                	je     80105164 <uartputc+0x18>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
8010515c:	5d                   	pop    %ebp
8010515d:	e9 0e ff ff ff       	jmp    80105070 <uartputc.part.0>
80105162:	66 90                	xchg   %ax,%ax
80105164:	5d                   	pop    %ebp
80105165:	c3                   	ret    
80105166:	66 90                	xchg   %ax,%ax

80105168 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80105168:	55                   	push   %ebp
80105169:	89 e5                	mov    %esp,%ebp
8010516b:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
8010516e:	68 48 50 10 80       	push   $0x80105048
80105173:	e8 dc b5 ff ff       	call   80100754 <consoleintr>
80105178:	83 c4 10             	add    $0x10,%esp
}
8010517b:	c9                   	leave  
8010517c:	c3                   	ret    

8010517d <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
8010517d:	6a 00                	push   $0x0
  pushl $0
8010517f:	6a 00                	push   $0x0
  jmp alltraps
80105181:	e9 d7 fb ff ff       	jmp    80104d5d <alltraps>

80105186 <vector1>:
.globl vector1
vector1:
  pushl $0
80105186:	6a 00                	push   $0x0
  pushl $1
80105188:	6a 01                	push   $0x1
  jmp alltraps
8010518a:	e9 ce fb ff ff       	jmp    80104d5d <alltraps>

8010518f <vector2>:
.globl vector2
vector2:
  pushl $0
8010518f:	6a 00                	push   $0x0
  pushl $2
80105191:	6a 02                	push   $0x2
  jmp alltraps
80105193:	e9 c5 fb ff ff       	jmp    80104d5d <alltraps>

80105198 <vector3>:
.globl vector3
vector3:
  pushl $0
80105198:	6a 00                	push   $0x0
  pushl $3
8010519a:	6a 03                	push   $0x3
  jmp alltraps
8010519c:	e9 bc fb ff ff       	jmp    80104d5d <alltraps>

801051a1 <vector4>:
.globl vector4
vector4:
  pushl $0
801051a1:	6a 00                	push   $0x0
  pushl $4
801051a3:	6a 04                	push   $0x4
  jmp alltraps
801051a5:	e9 b3 fb ff ff       	jmp    80104d5d <alltraps>

801051aa <vector5>:
.globl vector5
vector5:
  pushl $0
801051aa:	6a 00                	push   $0x0
  pushl $5
801051ac:	6a 05                	push   $0x5
  jmp alltraps
801051ae:	e9 aa fb ff ff       	jmp    80104d5d <alltraps>

801051b3 <vector6>:
.globl vector6
vector6:
  pushl $0
801051b3:	6a 00                	push   $0x0
  pushl $6
801051b5:	6a 06                	push   $0x6
  jmp alltraps
801051b7:	e9 a1 fb ff ff       	jmp    80104d5d <alltraps>

801051bc <vector7>:
.globl vector7
vector7:
  pushl $0
801051bc:	6a 00                	push   $0x0
  pushl $7
801051be:	6a 07                	push   $0x7
  jmp alltraps
801051c0:	e9 98 fb ff ff       	jmp    80104d5d <alltraps>

801051c5 <vector8>:
.globl vector8
vector8:
  pushl $8
801051c5:	6a 08                	push   $0x8
  jmp alltraps
801051c7:	e9 91 fb ff ff       	jmp    80104d5d <alltraps>

801051cc <vector9>:
.globl vector9
vector9:
  pushl $0
801051cc:	6a 00                	push   $0x0
  pushl $9
801051ce:	6a 09                	push   $0x9
  jmp alltraps
801051d0:	e9 88 fb ff ff       	jmp    80104d5d <alltraps>

801051d5 <vector10>:
.globl vector10
vector10:
  pushl $10
801051d5:	6a 0a                	push   $0xa
  jmp alltraps
801051d7:	e9 81 fb ff ff       	jmp    80104d5d <alltraps>

801051dc <vector11>:
.globl vector11
vector11:
  pushl $11
801051dc:	6a 0b                	push   $0xb
  jmp alltraps
801051de:	e9 7a fb ff ff       	jmp    80104d5d <alltraps>

801051e3 <vector12>:
.globl vector12
vector12:
  pushl $12
801051e3:	6a 0c                	push   $0xc
  jmp alltraps
801051e5:	e9 73 fb ff ff       	jmp    80104d5d <alltraps>

801051ea <vector13>:
.globl vector13
vector13:
  pushl $13
801051ea:	6a 0d                	push   $0xd
  jmp alltraps
801051ec:	e9 6c fb ff ff       	jmp    80104d5d <alltraps>

801051f1 <vector14>:
.globl vector14
vector14:
  pushl $14
801051f1:	6a 0e                	push   $0xe
  jmp alltraps
801051f3:	e9 65 fb ff ff       	jmp    80104d5d <alltraps>

801051f8 <vector15>:
.globl vector15
vector15:
  pushl $0
801051f8:	6a 00                	push   $0x0
  pushl $15
801051fa:	6a 0f                	push   $0xf
  jmp alltraps
801051fc:	e9 5c fb ff ff       	jmp    80104d5d <alltraps>

80105201 <vector16>:
.globl vector16
vector16:
  pushl $0
80105201:	6a 00                	push   $0x0
  pushl $16
80105203:	6a 10                	push   $0x10
  jmp alltraps
80105205:	e9 53 fb ff ff       	jmp    80104d5d <alltraps>

8010520a <vector17>:
.globl vector17
vector17:
  pushl $17
8010520a:	6a 11                	push   $0x11
  jmp alltraps
8010520c:	e9 4c fb ff ff       	jmp    80104d5d <alltraps>

80105211 <vector18>:
.globl vector18
vector18:
  pushl $0
80105211:	6a 00                	push   $0x0
  pushl $18
80105213:	6a 12                	push   $0x12
  jmp alltraps
80105215:	e9 43 fb ff ff       	jmp    80104d5d <alltraps>

8010521a <vector19>:
.globl vector19
vector19:
  pushl $0
8010521a:	6a 00                	push   $0x0
  pushl $19
8010521c:	6a 13                	push   $0x13
  jmp alltraps
8010521e:	e9 3a fb ff ff       	jmp    80104d5d <alltraps>

80105223 <vector20>:
.globl vector20
vector20:
  pushl $0
80105223:	6a 00                	push   $0x0
  pushl $20
80105225:	6a 14                	push   $0x14
  jmp alltraps
80105227:	e9 31 fb ff ff       	jmp    80104d5d <alltraps>

8010522c <vector21>:
.globl vector21
vector21:
  pushl $0
8010522c:	6a 00                	push   $0x0
  pushl $21
8010522e:	6a 15                	push   $0x15
  jmp alltraps
80105230:	e9 28 fb ff ff       	jmp    80104d5d <alltraps>

80105235 <vector22>:
.globl vector22
vector22:
  pushl $0
80105235:	6a 00                	push   $0x0
  pushl $22
80105237:	6a 16                	push   $0x16
  jmp alltraps
80105239:	e9 1f fb ff ff       	jmp    80104d5d <alltraps>

8010523e <vector23>:
.globl vector23
vector23:
  pushl $0
8010523e:	6a 00                	push   $0x0
  pushl $23
80105240:	6a 17                	push   $0x17
  jmp alltraps
80105242:	e9 16 fb ff ff       	jmp    80104d5d <alltraps>

80105247 <vector24>:
.globl vector24
vector24:
  pushl $0
80105247:	6a 00                	push   $0x0
  pushl $24
80105249:	6a 18                	push   $0x18
  jmp alltraps
8010524b:	e9 0d fb ff ff       	jmp    80104d5d <alltraps>

80105250 <vector25>:
.globl vector25
vector25:
  pushl $0
80105250:	6a 00                	push   $0x0
  pushl $25
80105252:	6a 19                	push   $0x19
  jmp alltraps
80105254:	e9 04 fb ff ff       	jmp    80104d5d <alltraps>

80105259 <vector26>:
.globl vector26
vector26:
  pushl $0
80105259:	6a 00                	push   $0x0
  pushl $26
8010525b:	6a 1a                	push   $0x1a
  jmp alltraps
8010525d:	e9 fb fa ff ff       	jmp    80104d5d <alltraps>

80105262 <vector27>:
.globl vector27
vector27:
  pushl $0
80105262:	6a 00                	push   $0x0
  pushl $27
80105264:	6a 1b                	push   $0x1b
  jmp alltraps
80105266:	e9 f2 fa ff ff       	jmp    80104d5d <alltraps>

8010526b <vector28>:
.globl vector28
vector28:
  pushl $0
8010526b:	6a 00                	push   $0x0
  pushl $28
8010526d:	6a 1c                	push   $0x1c
  jmp alltraps
8010526f:	e9 e9 fa ff ff       	jmp    80104d5d <alltraps>

80105274 <vector29>:
.globl vector29
vector29:
  pushl $0
80105274:	6a 00                	push   $0x0
  pushl $29
80105276:	6a 1d                	push   $0x1d
  jmp alltraps
80105278:	e9 e0 fa ff ff       	jmp    80104d5d <alltraps>

8010527d <vector30>:
.globl vector30
vector30:
  pushl $0
8010527d:	6a 00                	push   $0x0
  pushl $30
8010527f:	6a 1e                	push   $0x1e
  jmp alltraps
80105281:	e9 d7 fa ff ff       	jmp    80104d5d <alltraps>

80105286 <vector31>:
.globl vector31
vector31:
  pushl $0
80105286:	6a 00                	push   $0x0
  pushl $31
80105288:	6a 1f                	push   $0x1f
  jmp alltraps
8010528a:	e9 ce fa ff ff       	jmp    80104d5d <alltraps>

8010528f <vector32>:
.globl vector32
vector32:
  pushl $0
8010528f:	6a 00                	push   $0x0
  pushl $32
80105291:	6a 20                	push   $0x20
  jmp alltraps
80105293:	e9 c5 fa ff ff       	jmp    80104d5d <alltraps>

80105298 <vector33>:
.globl vector33
vector33:
  pushl $0
80105298:	6a 00                	push   $0x0
  pushl $33
8010529a:	6a 21                	push   $0x21
  jmp alltraps
8010529c:	e9 bc fa ff ff       	jmp    80104d5d <alltraps>

801052a1 <vector34>:
.globl vector34
vector34:
  pushl $0
801052a1:	6a 00                	push   $0x0
  pushl $34
801052a3:	6a 22                	push   $0x22
  jmp alltraps
801052a5:	e9 b3 fa ff ff       	jmp    80104d5d <alltraps>

801052aa <vector35>:
.globl vector35
vector35:
  pushl $0
801052aa:	6a 00                	push   $0x0
  pushl $35
801052ac:	6a 23                	push   $0x23
  jmp alltraps
801052ae:	e9 aa fa ff ff       	jmp    80104d5d <alltraps>

801052b3 <vector36>:
.globl vector36
vector36:
  pushl $0
801052b3:	6a 00                	push   $0x0
  pushl $36
801052b5:	6a 24                	push   $0x24
  jmp alltraps
801052b7:	e9 a1 fa ff ff       	jmp    80104d5d <alltraps>

801052bc <vector37>:
.globl vector37
vector37:
  pushl $0
801052bc:	6a 00                	push   $0x0
  pushl $37
801052be:	6a 25                	push   $0x25
  jmp alltraps
801052c0:	e9 98 fa ff ff       	jmp    80104d5d <alltraps>

801052c5 <vector38>:
.globl vector38
vector38:
  pushl $0
801052c5:	6a 00                	push   $0x0
  pushl $38
801052c7:	6a 26                	push   $0x26
  jmp alltraps
801052c9:	e9 8f fa ff ff       	jmp    80104d5d <alltraps>

801052ce <vector39>:
.globl vector39
vector39:
  pushl $0
801052ce:	6a 00                	push   $0x0
  pushl $39
801052d0:	6a 27                	push   $0x27
  jmp alltraps
801052d2:	e9 86 fa ff ff       	jmp    80104d5d <alltraps>

801052d7 <vector40>:
.globl vector40
vector40:
  pushl $0
801052d7:	6a 00                	push   $0x0
  pushl $40
801052d9:	6a 28                	push   $0x28
  jmp alltraps
801052db:	e9 7d fa ff ff       	jmp    80104d5d <alltraps>

801052e0 <vector41>:
.globl vector41
vector41:
  pushl $0
801052e0:	6a 00                	push   $0x0
  pushl $41
801052e2:	6a 29                	push   $0x29
  jmp alltraps
801052e4:	e9 74 fa ff ff       	jmp    80104d5d <alltraps>

801052e9 <vector42>:
.globl vector42
vector42:
  pushl $0
801052e9:	6a 00                	push   $0x0
  pushl $42
801052eb:	6a 2a                	push   $0x2a
  jmp alltraps
801052ed:	e9 6b fa ff ff       	jmp    80104d5d <alltraps>

801052f2 <vector43>:
.globl vector43
vector43:
  pushl $0
801052f2:	6a 00                	push   $0x0
  pushl $43
801052f4:	6a 2b                	push   $0x2b
  jmp alltraps
801052f6:	e9 62 fa ff ff       	jmp    80104d5d <alltraps>

801052fb <vector44>:
.globl vector44
vector44:
  pushl $0
801052fb:	6a 00                	push   $0x0
  pushl $44
801052fd:	6a 2c                	push   $0x2c
  jmp alltraps
801052ff:	e9 59 fa ff ff       	jmp    80104d5d <alltraps>

80105304 <vector45>:
.globl vector45
vector45:
  pushl $0
80105304:	6a 00                	push   $0x0
  pushl $45
80105306:	6a 2d                	push   $0x2d
  jmp alltraps
80105308:	e9 50 fa ff ff       	jmp    80104d5d <alltraps>

8010530d <vector46>:
.globl vector46
vector46:
  pushl $0
8010530d:	6a 00                	push   $0x0
  pushl $46
8010530f:	6a 2e                	push   $0x2e
  jmp alltraps
80105311:	e9 47 fa ff ff       	jmp    80104d5d <alltraps>

80105316 <vector47>:
.globl vector47
vector47:
  pushl $0
80105316:	6a 00                	push   $0x0
  pushl $47
80105318:	6a 2f                	push   $0x2f
  jmp alltraps
8010531a:	e9 3e fa ff ff       	jmp    80104d5d <alltraps>

8010531f <vector48>:
.globl vector48
vector48:
  pushl $0
8010531f:	6a 00                	push   $0x0
  pushl $48
80105321:	6a 30                	push   $0x30
  jmp alltraps
80105323:	e9 35 fa ff ff       	jmp    80104d5d <alltraps>

80105328 <vector49>:
.globl vector49
vector49:
  pushl $0
80105328:	6a 00                	push   $0x0
  pushl $49
8010532a:	6a 31                	push   $0x31
  jmp alltraps
8010532c:	e9 2c fa ff ff       	jmp    80104d5d <alltraps>

80105331 <vector50>:
.globl vector50
vector50:
  pushl $0
80105331:	6a 00                	push   $0x0
  pushl $50
80105333:	6a 32                	push   $0x32
  jmp alltraps
80105335:	e9 23 fa ff ff       	jmp    80104d5d <alltraps>

8010533a <vector51>:
.globl vector51
vector51:
  pushl $0
8010533a:	6a 00                	push   $0x0
  pushl $51
8010533c:	6a 33                	push   $0x33
  jmp alltraps
8010533e:	e9 1a fa ff ff       	jmp    80104d5d <alltraps>

80105343 <vector52>:
.globl vector52
vector52:
  pushl $0
80105343:	6a 00                	push   $0x0
  pushl $52
80105345:	6a 34                	push   $0x34
  jmp alltraps
80105347:	e9 11 fa ff ff       	jmp    80104d5d <alltraps>

8010534c <vector53>:
.globl vector53
vector53:
  pushl $0
8010534c:	6a 00                	push   $0x0
  pushl $53
8010534e:	6a 35                	push   $0x35
  jmp alltraps
80105350:	e9 08 fa ff ff       	jmp    80104d5d <alltraps>

80105355 <vector54>:
.globl vector54
vector54:
  pushl $0
80105355:	6a 00                	push   $0x0
  pushl $54
80105357:	6a 36                	push   $0x36
  jmp alltraps
80105359:	e9 ff f9 ff ff       	jmp    80104d5d <alltraps>

8010535e <vector55>:
.globl vector55
vector55:
  pushl $0
8010535e:	6a 00                	push   $0x0
  pushl $55
80105360:	6a 37                	push   $0x37
  jmp alltraps
80105362:	e9 f6 f9 ff ff       	jmp    80104d5d <alltraps>

80105367 <vector56>:
.globl vector56
vector56:
  pushl $0
80105367:	6a 00                	push   $0x0
  pushl $56
80105369:	6a 38                	push   $0x38
  jmp alltraps
8010536b:	e9 ed f9 ff ff       	jmp    80104d5d <alltraps>

80105370 <vector57>:
.globl vector57
vector57:
  pushl $0
80105370:	6a 00                	push   $0x0
  pushl $57
80105372:	6a 39                	push   $0x39
  jmp alltraps
80105374:	e9 e4 f9 ff ff       	jmp    80104d5d <alltraps>

80105379 <vector58>:
.globl vector58
vector58:
  pushl $0
80105379:	6a 00                	push   $0x0
  pushl $58
8010537b:	6a 3a                	push   $0x3a
  jmp alltraps
8010537d:	e9 db f9 ff ff       	jmp    80104d5d <alltraps>

80105382 <vector59>:
.globl vector59
vector59:
  pushl $0
80105382:	6a 00                	push   $0x0
  pushl $59
80105384:	6a 3b                	push   $0x3b
  jmp alltraps
80105386:	e9 d2 f9 ff ff       	jmp    80104d5d <alltraps>

8010538b <vector60>:
.globl vector60
vector60:
  pushl $0
8010538b:	6a 00                	push   $0x0
  pushl $60
8010538d:	6a 3c                	push   $0x3c
  jmp alltraps
8010538f:	e9 c9 f9 ff ff       	jmp    80104d5d <alltraps>

80105394 <vector61>:
.globl vector61
vector61:
  pushl $0
80105394:	6a 00                	push   $0x0
  pushl $61
80105396:	6a 3d                	push   $0x3d
  jmp alltraps
80105398:	e9 c0 f9 ff ff       	jmp    80104d5d <alltraps>

8010539d <vector62>:
.globl vector62
vector62:
  pushl $0
8010539d:	6a 00                	push   $0x0
  pushl $62
8010539f:	6a 3e                	push   $0x3e
  jmp alltraps
801053a1:	e9 b7 f9 ff ff       	jmp    80104d5d <alltraps>

801053a6 <vector63>:
.globl vector63
vector63:
  pushl $0
801053a6:	6a 00                	push   $0x0
  pushl $63
801053a8:	6a 3f                	push   $0x3f
  jmp alltraps
801053aa:	e9 ae f9 ff ff       	jmp    80104d5d <alltraps>

801053af <vector64>:
.globl vector64
vector64:
  pushl $0
801053af:	6a 00                	push   $0x0
  pushl $64
801053b1:	6a 40                	push   $0x40
  jmp alltraps
801053b3:	e9 a5 f9 ff ff       	jmp    80104d5d <alltraps>

801053b8 <vector65>:
.globl vector65
vector65:
  pushl $0
801053b8:	6a 00                	push   $0x0
  pushl $65
801053ba:	6a 41                	push   $0x41
  jmp alltraps
801053bc:	e9 9c f9 ff ff       	jmp    80104d5d <alltraps>

801053c1 <vector66>:
.globl vector66
vector66:
  pushl $0
801053c1:	6a 00                	push   $0x0
  pushl $66
801053c3:	6a 42                	push   $0x42
  jmp alltraps
801053c5:	e9 93 f9 ff ff       	jmp    80104d5d <alltraps>

801053ca <vector67>:
.globl vector67
vector67:
  pushl $0
801053ca:	6a 00                	push   $0x0
  pushl $67
801053cc:	6a 43                	push   $0x43
  jmp alltraps
801053ce:	e9 8a f9 ff ff       	jmp    80104d5d <alltraps>

801053d3 <vector68>:
.globl vector68
vector68:
  pushl $0
801053d3:	6a 00                	push   $0x0
  pushl $68
801053d5:	6a 44                	push   $0x44
  jmp alltraps
801053d7:	e9 81 f9 ff ff       	jmp    80104d5d <alltraps>

801053dc <vector69>:
.globl vector69
vector69:
  pushl $0
801053dc:	6a 00                	push   $0x0
  pushl $69
801053de:	6a 45                	push   $0x45
  jmp alltraps
801053e0:	e9 78 f9 ff ff       	jmp    80104d5d <alltraps>

801053e5 <vector70>:
.globl vector70
vector70:
  pushl $0
801053e5:	6a 00                	push   $0x0
  pushl $70
801053e7:	6a 46                	push   $0x46
  jmp alltraps
801053e9:	e9 6f f9 ff ff       	jmp    80104d5d <alltraps>

801053ee <vector71>:
.globl vector71
vector71:
  pushl $0
801053ee:	6a 00                	push   $0x0
  pushl $71
801053f0:	6a 47                	push   $0x47
  jmp alltraps
801053f2:	e9 66 f9 ff ff       	jmp    80104d5d <alltraps>

801053f7 <vector72>:
.globl vector72
vector72:
  pushl $0
801053f7:	6a 00                	push   $0x0
  pushl $72
801053f9:	6a 48                	push   $0x48
  jmp alltraps
801053fb:	e9 5d f9 ff ff       	jmp    80104d5d <alltraps>

80105400 <vector73>:
.globl vector73
vector73:
  pushl $0
80105400:	6a 00                	push   $0x0
  pushl $73
80105402:	6a 49                	push   $0x49
  jmp alltraps
80105404:	e9 54 f9 ff ff       	jmp    80104d5d <alltraps>

80105409 <vector74>:
.globl vector74
vector74:
  pushl $0
80105409:	6a 00                	push   $0x0
  pushl $74
8010540b:	6a 4a                	push   $0x4a
  jmp alltraps
8010540d:	e9 4b f9 ff ff       	jmp    80104d5d <alltraps>

80105412 <vector75>:
.globl vector75
vector75:
  pushl $0
80105412:	6a 00                	push   $0x0
  pushl $75
80105414:	6a 4b                	push   $0x4b
  jmp alltraps
80105416:	e9 42 f9 ff ff       	jmp    80104d5d <alltraps>

8010541b <vector76>:
.globl vector76
vector76:
  pushl $0
8010541b:	6a 00                	push   $0x0
  pushl $76
8010541d:	6a 4c                	push   $0x4c
  jmp alltraps
8010541f:	e9 39 f9 ff ff       	jmp    80104d5d <alltraps>

80105424 <vector77>:
.globl vector77
vector77:
  pushl $0
80105424:	6a 00                	push   $0x0
  pushl $77
80105426:	6a 4d                	push   $0x4d
  jmp alltraps
80105428:	e9 30 f9 ff ff       	jmp    80104d5d <alltraps>

8010542d <vector78>:
.globl vector78
vector78:
  pushl $0
8010542d:	6a 00                	push   $0x0
  pushl $78
8010542f:	6a 4e                	push   $0x4e
  jmp alltraps
80105431:	e9 27 f9 ff ff       	jmp    80104d5d <alltraps>

80105436 <vector79>:
.globl vector79
vector79:
  pushl $0
80105436:	6a 00                	push   $0x0
  pushl $79
80105438:	6a 4f                	push   $0x4f
  jmp alltraps
8010543a:	e9 1e f9 ff ff       	jmp    80104d5d <alltraps>

8010543f <vector80>:
.globl vector80
vector80:
  pushl $0
8010543f:	6a 00                	push   $0x0
  pushl $80
80105441:	6a 50                	push   $0x50
  jmp alltraps
80105443:	e9 15 f9 ff ff       	jmp    80104d5d <alltraps>

80105448 <vector81>:
.globl vector81
vector81:
  pushl $0
80105448:	6a 00                	push   $0x0
  pushl $81
8010544a:	6a 51                	push   $0x51
  jmp alltraps
8010544c:	e9 0c f9 ff ff       	jmp    80104d5d <alltraps>

80105451 <vector82>:
.globl vector82
vector82:
  pushl $0
80105451:	6a 00                	push   $0x0
  pushl $82
80105453:	6a 52                	push   $0x52
  jmp alltraps
80105455:	e9 03 f9 ff ff       	jmp    80104d5d <alltraps>

8010545a <vector83>:
.globl vector83
vector83:
  pushl $0
8010545a:	6a 00                	push   $0x0
  pushl $83
8010545c:	6a 53                	push   $0x53
  jmp alltraps
8010545e:	e9 fa f8 ff ff       	jmp    80104d5d <alltraps>

80105463 <vector84>:
.globl vector84
vector84:
  pushl $0
80105463:	6a 00                	push   $0x0
  pushl $84
80105465:	6a 54                	push   $0x54
  jmp alltraps
80105467:	e9 f1 f8 ff ff       	jmp    80104d5d <alltraps>

8010546c <vector85>:
.globl vector85
vector85:
  pushl $0
8010546c:	6a 00                	push   $0x0
  pushl $85
8010546e:	6a 55                	push   $0x55
  jmp alltraps
80105470:	e9 e8 f8 ff ff       	jmp    80104d5d <alltraps>

80105475 <vector86>:
.globl vector86
vector86:
  pushl $0
80105475:	6a 00                	push   $0x0
  pushl $86
80105477:	6a 56                	push   $0x56
  jmp alltraps
80105479:	e9 df f8 ff ff       	jmp    80104d5d <alltraps>

8010547e <vector87>:
.globl vector87
vector87:
  pushl $0
8010547e:	6a 00                	push   $0x0
  pushl $87
80105480:	6a 57                	push   $0x57
  jmp alltraps
80105482:	e9 d6 f8 ff ff       	jmp    80104d5d <alltraps>

80105487 <vector88>:
.globl vector88
vector88:
  pushl $0
80105487:	6a 00                	push   $0x0
  pushl $88
80105489:	6a 58                	push   $0x58
  jmp alltraps
8010548b:	e9 cd f8 ff ff       	jmp    80104d5d <alltraps>

80105490 <vector89>:
.globl vector89
vector89:
  pushl $0
80105490:	6a 00                	push   $0x0
  pushl $89
80105492:	6a 59                	push   $0x59
  jmp alltraps
80105494:	e9 c4 f8 ff ff       	jmp    80104d5d <alltraps>

80105499 <vector90>:
.globl vector90
vector90:
  pushl $0
80105499:	6a 00                	push   $0x0
  pushl $90
8010549b:	6a 5a                	push   $0x5a
  jmp alltraps
8010549d:	e9 bb f8 ff ff       	jmp    80104d5d <alltraps>

801054a2 <vector91>:
.globl vector91
vector91:
  pushl $0
801054a2:	6a 00                	push   $0x0
  pushl $91
801054a4:	6a 5b                	push   $0x5b
  jmp alltraps
801054a6:	e9 b2 f8 ff ff       	jmp    80104d5d <alltraps>

801054ab <vector92>:
.globl vector92
vector92:
  pushl $0
801054ab:	6a 00                	push   $0x0
  pushl $92
801054ad:	6a 5c                	push   $0x5c
  jmp alltraps
801054af:	e9 a9 f8 ff ff       	jmp    80104d5d <alltraps>

801054b4 <vector93>:
.globl vector93
vector93:
  pushl $0
801054b4:	6a 00                	push   $0x0
  pushl $93
801054b6:	6a 5d                	push   $0x5d
  jmp alltraps
801054b8:	e9 a0 f8 ff ff       	jmp    80104d5d <alltraps>

801054bd <vector94>:
.globl vector94
vector94:
  pushl $0
801054bd:	6a 00                	push   $0x0
  pushl $94
801054bf:	6a 5e                	push   $0x5e
  jmp alltraps
801054c1:	e9 97 f8 ff ff       	jmp    80104d5d <alltraps>

801054c6 <vector95>:
.globl vector95
vector95:
  pushl $0
801054c6:	6a 00                	push   $0x0
  pushl $95
801054c8:	6a 5f                	push   $0x5f
  jmp alltraps
801054ca:	e9 8e f8 ff ff       	jmp    80104d5d <alltraps>

801054cf <vector96>:
.globl vector96
vector96:
  pushl $0
801054cf:	6a 00                	push   $0x0
  pushl $96
801054d1:	6a 60                	push   $0x60
  jmp alltraps
801054d3:	e9 85 f8 ff ff       	jmp    80104d5d <alltraps>

801054d8 <vector97>:
.globl vector97
vector97:
  pushl $0
801054d8:	6a 00                	push   $0x0
  pushl $97
801054da:	6a 61                	push   $0x61
  jmp alltraps
801054dc:	e9 7c f8 ff ff       	jmp    80104d5d <alltraps>

801054e1 <vector98>:
.globl vector98
vector98:
  pushl $0
801054e1:	6a 00                	push   $0x0
  pushl $98
801054e3:	6a 62                	push   $0x62
  jmp alltraps
801054e5:	e9 73 f8 ff ff       	jmp    80104d5d <alltraps>

801054ea <vector99>:
.globl vector99
vector99:
  pushl $0
801054ea:	6a 00                	push   $0x0
  pushl $99
801054ec:	6a 63                	push   $0x63
  jmp alltraps
801054ee:	e9 6a f8 ff ff       	jmp    80104d5d <alltraps>

801054f3 <vector100>:
.globl vector100
vector100:
  pushl $0
801054f3:	6a 00                	push   $0x0
  pushl $100
801054f5:	6a 64                	push   $0x64
  jmp alltraps
801054f7:	e9 61 f8 ff ff       	jmp    80104d5d <alltraps>

801054fc <vector101>:
.globl vector101
vector101:
  pushl $0
801054fc:	6a 00                	push   $0x0
  pushl $101
801054fe:	6a 65                	push   $0x65
  jmp alltraps
80105500:	e9 58 f8 ff ff       	jmp    80104d5d <alltraps>

80105505 <vector102>:
.globl vector102
vector102:
  pushl $0
80105505:	6a 00                	push   $0x0
  pushl $102
80105507:	6a 66                	push   $0x66
  jmp alltraps
80105509:	e9 4f f8 ff ff       	jmp    80104d5d <alltraps>

8010550e <vector103>:
.globl vector103
vector103:
  pushl $0
8010550e:	6a 00                	push   $0x0
  pushl $103
80105510:	6a 67                	push   $0x67
  jmp alltraps
80105512:	e9 46 f8 ff ff       	jmp    80104d5d <alltraps>

80105517 <vector104>:
.globl vector104
vector104:
  pushl $0
80105517:	6a 00                	push   $0x0
  pushl $104
80105519:	6a 68                	push   $0x68
  jmp alltraps
8010551b:	e9 3d f8 ff ff       	jmp    80104d5d <alltraps>

80105520 <vector105>:
.globl vector105
vector105:
  pushl $0
80105520:	6a 00                	push   $0x0
  pushl $105
80105522:	6a 69                	push   $0x69
  jmp alltraps
80105524:	e9 34 f8 ff ff       	jmp    80104d5d <alltraps>

80105529 <vector106>:
.globl vector106
vector106:
  pushl $0
80105529:	6a 00                	push   $0x0
  pushl $106
8010552b:	6a 6a                	push   $0x6a
  jmp alltraps
8010552d:	e9 2b f8 ff ff       	jmp    80104d5d <alltraps>

80105532 <vector107>:
.globl vector107
vector107:
  pushl $0
80105532:	6a 00                	push   $0x0
  pushl $107
80105534:	6a 6b                	push   $0x6b
  jmp alltraps
80105536:	e9 22 f8 ff ff       	jmp    80104d5d <alltraps>

8010553b <vector108>:
.globl vector108
vector108:
  pushl $0
8010553b:	6a 00                	push   $0x0
  pushl $108
8010553d:	6a 6c                	push   $0x6c
  jmp alltraps
8010553f:	e9 19 f8 ff ff       	jmp    80104d5d <alltraps>

80105544 <vector109>:
.globl vector109
vector109:
  pushl $0
80105544:	6a 00                	push   $0x0
  pushl $109
80105546:	6a 6d                	push   $0x6d
  jmp alltraps
80105548:	e9 10 f8 ff ff       	jmp    80104d5d <alltraps>

8010554d <vector110>:
.globl vector110
vector110:
  pushl $0
8010554d:	6a 00                	push   $0x0
  pushl $110
8010554f:	6a 6e                	push   $0x6e
  jmp alltraps
80105551:	e9 07 f8 ff ff       	jmp    80104d5d <alltraps>

80105556 <vector111>:
.globl vector111
vector111:
  pushl $0
80105556:	6a 00                	push   $0x0
  pushl $111
80105558:	6a 6f                	push   $0x6f
  jmp alltraps
8010555a:	e9 fe f7 ff ff       	jmp    80104d5d <alltraps>

8010555f <vector112>:
.globl vector112
vector112:
  pushl $0
8010555f:	6a 00                	push   $0x0
  pushl $112
80105561:	6a 70                	push   $0x70
  jmp alltraps
80105563:	e9 f5 f7 ff ff       	jmp    80104d5d <alltraps>

80105568 <vector113>:
.globl vector113
vector113:
  pushl $0
80105568:	6a 00                	push   $0x0
  pushl $113
8010556a:	6a 71                	push   $0x71
  jmp alltraps
8010556c:	e9 ec f7 ff ff       	jmp    80104d5d <alltraps>

80105571 <vector114>:
.globl vector114
vector114:
  pushl $0
80105571:	6a 00                	push   $0x0
  pushl $114
80105573:	6a 72                	push   $0x72
  jmp alltraps
80105575:	e9 e3 f7 ff ff       	jmp    80104d5d <alltraps>

8010557a <vector115>:
.globl vector115
vector115:
  pushl $0
8010557a:	6a 00                	push   $0x0
  pushl $115
8010557c:	6a 73                	push   $0x73
  jmp alltraps
8010557e:	e9 da f7 ff ff       	jmp    80104d5d <alltraps>

80105583 <vector116>:
.globl vector116
vector116:
  pushl $0
80105583:	6a 00                	push   $0x0
  pushl $116
80105585:	6a 74                	push   $0x74
  jmp alltraps
80105587:	e9 d1 f7 ff ff       	jmp    80104d5d <alltraps>

8010558c <vector117>:
.globl vector117
vector117:
  pushl $0
8010558c:	6a 00                	push   $0x0
  pushl $117
8010558e:	6a 75                	push   $0x75
  jmp alltraps
80105590:	e9 c8 f7 ff ff       	jmp    80104d5d <alltraps>

80105595 <vector118>:
.globl vector118
vector118:
  pushl $0
80105595:	6a 00                	push   $0x0
  pushl $118
80105597:	6a 76                	push   $0x76
  jmp alltraps
80105599:	e9 bf f7 ff ff       	jmp    80104d5d <alltraps>

8010559e <vector119>:
.globl vector119
vector119:
  pushl $0
8010559e:	6a 00                	push   $0x0
  pushl $119
801055a0:	6a 77                	push   $0x77
  jmp alltraps
801055a2:	e9 b6 f7 ff ff       	jmp    80104d5d <alltraps>

801055a7 <vector120>:
.globl vector120
vector120:
  pushl $0
801055a7:	6a 00                	push   $0x0
  pushl $120
801055a9:	6a 78                	push   $0x78
  jmp alltraps
801055ab:	e9 ad f7 ff ff       	jmp    80104d5d <alltraps>

801055b0 <vector121>:
.globl vector121
vector121:
  pushl $0
801055b0:	6a 00                	push   $0x0
  pushl $121
801055b2:	6a 79                	push   $0x79
  jmp alltraps
801055b4:	e9 a4 f7 ff ff       	jmp    80104d5d <alltraps>

801055b9 <vector122>:
.globl vector122
vector122:
  pushl $0
801055b9:	6a 00                	push   $0x0
  pushl $122
801055bb:	6a 7a                	push   $0x7a
  jmp alltraps
801055bd:	e9 9b f7 ff ff       	jmp    80104d5d <alltraps>

801055c2 <vector123>:
.globl vector123
vector123:
  pushl $0
801055c2:	6a 00                	push   $0x0
  pushl $123
801055c4:	6a 7b                	push   $0x7b
  jmp alltraps
801055c6:	e9 92 f7 ff ff       	jmp    80104d5d <alltraps>

801055cb <vector124>:
.globl vector124
vector124:
  pushl $0
801055cb:	6a 00                	push   $0x0
  pushl $124
801055cd:	6a 7c                	push   $0x7c
  jmp alltraps
801055cf:	e9 89 f7 ff ff       	jmp    80104d5d <alltraps>

801055d4 <vector125>:
.globl vector125
vector125:
  pushl $0
801055d4:	6a 00                	push   $0x0
  pushl $125
801055d6:	6a 7d                	push   $0x7d
  jmp alltraps
801055d8:	e9 80 f7 ff ff       	jmp    80104d5d <alltraps>

801055dd <vector126>:
.globl vector126
vector126:
  pushl $0
801055dd:	6a 00                	push   $0x0
  pushl $126
801055df:	6a 7e                	push   $0x7e
  jmp alltraps
801055e1:	e9 77 f7 ff ff       	jmp    80104d5d <alltraps>

801055e6 <vector127>:
.globl vector127
vector127:
  pushl $0
801055e6:	6a 00                	push   $0x0
  pushl $127
801055e8:	6a 7f                	push   $0x7f
  jmp alltraps
801055ea:	e9 6e f7 ff ff       	jmp    80104d5d <alltraps>

801055ef <vector128>:
.globl vector128
vector128:
  pushl $0
801055ef:	6a 00                	push   $0x0
  pushl $128
801055f1:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801055f6:	e9 62 f7 ff ff       	jmp    80104d5d <alltraps>

801055fb <vector129>:
.globl vector129
vector129:
  pushl $0
801055fb:	6a 00                	push   $0x0
  pushl $129
801055fd:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80105602:	e9 56 f7 ff ff       	jmp    80104d5d <alltraps>

80105607 <vector130>:
.globl vector130
vector130:
  pushl $0
80105607:	6a 00                	push   $0x0
  pushl $130
80105609:	68 82 00 00 00       	push   $0x82
  jmp alltraps
8010560e:	e9 4a f7 ff ff       	jmp    80104d5d <alltraps>

80105613 <vector131>:
.globl vector131
vector131:
  pushl $0
80105613:	6a 00                	push   $0x0
  pushl $131
80105615:	68 83 00 00 00       	push   $0x83
  jmp alltraps
8010561a:	e9 3e f7 ff ff       	jmp    80104d5d <alltraps>

8010561f <vector132>:
.globl vector132
vector132:
  pushl $0
8010561f:	6a 00                	push   $0x0
  pushl $132
80105621:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80105626:	e9 32 f7 ff ff       	jmp    80104d5d <alltraps>

8010562b <vector133>:
.globl vector133
vector133:
  pushl $0
8010562b:	6a 00                	push   $0x0
  pushl $133
8010562d:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80105632:	e9 26 f7 ff ff       	jmp    80104d5d <alltraps>

80105637 <vector134>:
.globl vector134
vector134:
  pushl $0
80105637:	6a 00                	push   $0x0
  pushl $134
80105639:	68 86 00 00 00       	push   $0x86
  jmp alltraps
8010563e:	e9 1a f7 ff ff       	jmp    80104d5d <alltraps>

80105643 <vector135>:
.globl vector135
vector135:
  pushl $0
80105643:	6a 00                	push   $0x0
  pushl $135
80105645:	68 87 00 00 00       	push   $0x87
  jmp alltraps
8010564a:	e9 0e f7 ff ff       	jmp    80104d5d <alltraps>

8010564f <vector136>:
.globl vector136
vector136:
  pushl $0
8010564f:	6a 00                	push   $0x0
  pushl $136
80105651:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80105656:	e9 02 f7 ff ff       	jmp    80104d5d <alltraps>

8010565b <vector137>:
.globl vector137
vector137:
  pushl $0
8010565b:	6a 00                	push   $0x0
  pushl $137
8010565d:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80105662:	e9 f6 f6 ff ff       	jmp    80104d5d <alltraps>

80105667 <vector138>:
.globl vector138
vector138:
  pushl $0
80105667:	6a 00                	push   $0x0
  pushl $138
80105669:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
8010566e:	e9 ea f6 ff ff       	jmp    80104d5d <alltraps>

80105673 <vector139>:
.globl vector139
vector139:
  pushl $0
80105673:	6a 00                	push   $0x0
  pushl $139
80105675:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
8010567a:	e9 de f6 ff ff       	jmp    80104d5d <alltraps>

8010567f <vector140>:
.globl vector140
vector140:
  pushl $0
8010567f:	6a 00                	push   $0x0
  pushl $140
80105681:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80105686:	e9 d2 f6 ff ff       	jmp    80104d5d <alltraps>

8010568b <vector141>:
.globl vector141
vector141:
  pushl $0
8010568b:	6a 00                	push   $0x0
  pushl $141
8010568d:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80105692:	e9 c6 f6 ff ff       	jmp    80104d5d <alltraps>

80105697 <vector142>:
.globl vector142
vector142:
  pushl $0
80105697:	6a 00                	push   $0x0
  pushl $142
80105699:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
8010569e:	e9 ba f6 ff ff       	jmp    80104d5d <alltraps>

801056a3 <vector143>:
.globl vector143
vector143:
  pushl $0
801056a3:	6a 00                	push   $0x0
  pushl $143
801056a5:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801056aa:	e9 ae f6 ff ff       	jmp    80104d5d <alltraps>

801056af <vector144>:
.globl vector144
vector144:
  pushl $0
801056af:	6a 00                	push   $0x0
  pushl $144
801056b1:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801056b6:	e9 a2 f6 ff ff       	jmp    80104d5d <alltraps>

801056bb <vector145>:
.globl vector145
vector145:
  pushl $0
801056bb:	6a 00                	push   $0x0
  pushl $145
801056bd:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801056c2:	e9 96 f6 ff ff       	jmp    80104d5d <alltraps>

801056c7 <vector146>:
.globl vector146
vector146:
  pushl $0
801056c7:	6a 00                	push   $0x0
  pushl $146
801056c9:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801056ce:	e9 8a f6 ff ff       	jmp    80104d5d <alltraps>

801056d3 <vector147>:
.globl vector147
vector147:
  pushl $0
801056d3:	6a 00                	push   $0x0
  pushl $147
801056d5:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801056da:	e9 7e f6 ff ff       	jmp    80104d5d <alltraps>

801056df <vector148>:
.globl vector148
vector148:
  pushl $0
801056df:	6a 00                	push   $0x0
  pushl $148
801056e1:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801056e6:	e9 72 f6 ff ff       	jmp    80104d5d <alltraps>

801056eb <vector149>:
.globl vector149
vector149:
  pushl $0
801056eb:	6a 00                	push   $0x0
  pushl $149
801056ed:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801056f2:	e9 66 f6 ff ff       	jmp    80104d5d <alltraps>

801056f7 <vector150>:
.globl vector150
vector150:
  pushl $0
801056f7:	6a 00                	push   $0x0
  pushl $150
801056f9:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801056fe:	e9 5a f6 ff ff       	jmp    80104d5d <alltraps>

80105703 <vector151>:
.globl vector151
vector151:
  pushl $0
80105703:	6a 00                	push   $0x0
  pushl $151
80105705:	68 97 00 00 00       	push   $0x97
  jmp alltraps
8010570a:	e9 4e f6 ff ff       	jmp    80104d5d <alltraps>

8010570f <vector152>:
.globl vector152
vector152:
  pushl $0
8010570f:	6a 00                	push   $0x0
  pushl $152
80105711:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80105716:	e9 42 f6 ff ff       	jmp    80104d5d <alltraps>

8010571b <vector153>:
.globl vector153
vector153:
  pushl $0
8010571b:	6a 00                	push   $0x0
  pushl $153
8010571d:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80105722:	e9 36 f6 ff ff       	jmp    80104d5d <alltraps>

80105727 <vector154>:
.globl vector154
vector154:
  pushl $0
80105727:	6a 00                	push   $0x0
  pushl $154
80105729:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
8010572e:	e9 2a f6 ff ff       	jmp    80104d5d <alltraps>

80105733 <vector155>:
.globl vector155
vector155:
  pushl $0
80105733:	6a 00                	push   $0x0
  pushl $155
80105735:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
8010573a:	e9 1e f6 ff ff       	jmp    80104d5d <alltraps>

8010573f <vector156>:
.globl vector156
vector156:
  pushl $0
8010573f:	6a 00                	push   $0x0
  pushl $156
80105741:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80105746:	e9 12 f6 ff ff       	jmp    80104d5d <alltraps>

8010574b <vector157>:
.globl vector157
vector157:
  pushl $0
8010574b:	6a 00                	push   $0x0
  pushl $157
8010574d:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80105752:	e9 06 f6 ff ff       	jmp    80104d5d <alltraps>

80105757 <vector158>:
.globl vector158
vector158:
  pushl $0
80105757:	6a 00                	push   $0x0
  pushl $158
80105759:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
8010575e:	e9 fa f5 ff ff       	jmp    80104d5d <alltraps>

80105763 <vector159>:
.globl vector159
vector159:
  pushl $0
80105763:	6a 00                	push   $0x0
  pushl $159
80105765:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
8010576a:	e9 ee f5 ff ff       	jmp    80104d5d <alltraps>

8010576f <vector160>:
.globl vector160
vector160:
  pushl $0
8010576f:	6a 00                	push   $0x0
  pushl $160
80105771:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80105776:	e9 e2 f5 ff ff       	jmp    80104d5d <alltraps>

8010577b <vector161>:
.globl vector161
vector161:
  pushl $0
8010577b:	6a 00                	push   $0x0
  pushl $161
8010577d:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80105782:	e9 d6 f5 ff ff       	jmp    80104d5d <alltraps>

80105787 <vector162>:
.globl vector162
vector162:
  pushl $0
80105787:	6a 00                	push   $0x0
  pushl $162
80105789:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
8010578e:	e9 ca f5 ff ff       	jmp    80104d5d <alltraps>

80105793 <vector163>:
.globl vector163
vector163:
  pushl $0
80105793:	6a 00                	push   $0x0
  pushl $163
80105795:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
8010579a:	e9 be f5 ff ff       	jmp    80104d5d <alltraps>

8010579f <vector164>:
.globl vector164
vector164:
  pushl $0
8010579f:	6a 00                	push   $0x0
  pushl $164
801057a1:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801057a6:	e9 b2 f5 ff ff       	jmp    80104d5d <alltraps>

801057ab <vector165>:
.globl vector165
vector165:
  pushl $0
801057ab:	6a 00                	push   $0x0
  pushl $165
801057ad:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801057b2:	e9 a6 f5 ff ff       	jmp    80104d5d <alltraps>

801057b7 <vector166>:
.globl vector166
vector166:
  pushl $0
801057b7:	6a 00                	push   $0x0
  pushl $166
801057b9:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801057be:	e9 9a f5 ff ff       	jmp    80104d5d <alltraps>

801057c3 <vector167>:
.globl vector167
vector167:
  pushl $0
801057c3:	6a 00                	push   $0x0
  pushl $167
801057c5:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801057ca:	e9 8e f5 ff ff       	jmp    80104d5d <alltraps>

801057cf <vector168>:
.globl vector168
vector168:
  pushl $0
801057cf:	6a 00                	push   $0x0
  pushl $168
801057d1:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801057d6:	e9 82 f5 ff ff       	jmp    80104d5d <alltraps>

801057db <vector169>:
.globl vector169
vector169:
  pushl $0
801057db:	6a 00                	push   $0x0
  pushl $169
801057dd:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801057e2:	e9 76 f5 ff ff       	jmp    80104d5d <alltraps>

801057e7 <vector170>:
.globl vector170
vector170:
  pushl $0
801057e7:	6a 00                	push   $0x0
  pushl $170
801057e9:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801057ee:	e9 6a f5 ff ff       	jmp    80104d5d <alltraps>

801057f3 <vector171>:
.globl vector171
vector171:
  pushl $0
801057f3:	6a 00                	push   $0x0
  pushl $171
801057f5:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801057fa:	e9 5e f5 ff ff       	jmp    80104d5d <alltraps>

801057ff <vector172>:
.globl vector172
vector172:
  pushl $0
801057ff:	6a 00                	push   $0x0
  pushl $172
80105801:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80105806:	e9 52 f5 ff ff       	jmp    80104d5d <alltraps>

8010580b <vector173>:
.globl vector173
vector173:
  pushl $0
8010580b:	6a 00                	push   $0x0
  pushl $173
8010580d:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80105812:	e9 46 f5 ff ff       	jmp    80104d5d <alltraps>

80105817 <vector174>:
.globl vector174
vector174:
  pushl $0
80105817:	6a 00                	push   $0x0
  pushl $174
80105819:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
8010581e:	e9 3a f5 ff ff       	jmp    80104d5d <alltraps>

80105823 <vector175>:
.globl vector175
vector175:
  pushl $0
80105823:	6a 00                	push   $0x0
  pushl $175
80105825:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
8010582a:	e9 2e f5 ff ff       	jmp    80104d5d <alltraps>

8010582f <vector176>:
.globl vector176
vector176:
  pushl $0
8010582f:	6a 00                	push   $0x0
  pushl $176
80105831:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80105836:	e9 22 f5 ff ff       	jmp    80104d5d <alltraps>

8010583b <vector177>:
.globl vector177
vector177:
  pushl $0
8010583b:	6a 00                	push   $0x0
  pushl $177
8010583d:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80105842:	e9 16 f5 ff ff       	jmp    80104d5d <alltraps>

80105847 <vector178>:
.globl vector178
vector178:
  pushl $0
80105847:	6a 00                	push   $0x0
  pushl $178
80105849:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
8010584e:	e9 0a f5 ff ff       	jmp    80104d5d <alltraps>

80105853 <vector179>:
.globl vector179
vector179:
  pushl $0
80105853:	6a 00                	push   $0x0
  pushl $179
80105855:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
8010585a:	e9 fe f4 ff ff       	jmp    80104d5d <alltraps>

8010585f <vector180>:
.globl vector180
vector180:
  pushl $0
8010585f:	6a 00                	push   $0x0
  pushl $180
80105861:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80105866:	e9 f2 f4 ff ff       	jmp    80104d5d <alltraps>

8010586b <vector181>:
.globl vector181
vector181:
  pushl $0
8010586b:	6a 00                	push   $0x0
  pushl $181
8010586d:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80105872:	e9 e6 f4 ff ff       	jmp    80104d5d <alltraps>

80105877 <vector182>:
.globl vector182
vector182:
  pushl $0
80105877:	6a 00                	push   $0x0
  pushl $182
80105879:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
8010587e:	e9 da f4 ff ff       	jmp    80104d5d <alltraps>

80105883 <vector183>:
.globl vector183
vector183:
  pushl $0
80105883:	6a 00                	push   $0x0
  pushl $183
80105885:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
8010588a:	e9 ce f4 ff ff       	jmp    80104d5d <alltraps>

8010588f <vector184>:
.globl vector184
vector184:
  pushl $0
8010588f:	6a 00                	push   $0x0
  pushl $184
80105891:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80105896:	e9 c2 f4 ff ff       	jmp    80104d5d <alltraps>

8010589b <vector185>:
.globl vector185
vector185:
  pushl $0
8010589b:	6a 00                	push   $0x0
  pushl $185
8010589d:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801058a2:	e9 b6 f4 ff ff       	jmp    80104d5d <alltraps>

801058a7 <vector186>:
.globl vector186
vector186:
  pushl $0
801058a7:	6a 00                	push   $0x0
  pushl $186
801058a9:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801058ae:	e9 aa f4 ff ff       	jmp    80104d5d <alltraps>

801058b3 <vector187>:
.globl vector187
vector187:
  pushl $0
801058b3:	6a 00                	push   $0x0
  pushl $187
801058b5:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801058ba:	e9 9e f4 ff ff       	jmp    80104d5d <alltraps>

801058bf <vector188>:
.globl vector188
vector188:
  pushl $0
801058bf:	6a 00                	push   $0x0
  pushl $188
801058c1:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801058c6:	e9 92 f4 ff ff       	jmp    80104d5d <alltraps>

801058cb <vector189>:
.globl vector189
vector189:
  pushl $0
801058cb:	6a 00                	push   $0x0
  pushl $189
801058cd:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801058d2:	e9 86 f4 ff ff       	jmp    80104d5d <alltraps>

801058d7 <vector190>:
.globl vector190
vector190:
  pushl $0
801058d7:	6a 00                	push   $0x0
  pushl $190
801058d9:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801058de:	e9 7a f4 ff ff       	jmp    80104d5d <alltraps>

801058e3 <vector191>:
.globl vector191
vector191:
  pushl $0
801058e3:	6a 00                	push   $0x0
  pushl $191
801058e5:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801058ea:	e9 6e f4 ff ff       	jmp    80104d5d <alltraps>

801058ef <vector192>:
.globl vector192
vector192:
  pushl $0
801058ef:	6a 00                	push   $0x0
  pushl $192
801058f1:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801058f6:	e9 62 f4 ff ff       	jmp    80104d5d <alltraps>

801058fb <vector193>:
.globl vector193
vector193:
  pushl $0
801058fb:	6a 00                	push   $0x0
  pushl $193
801058fd:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80105902:	e9 56 f4 ff ff       	jmp    80104d5d <alltraps>

80105907 <vector194>:
.globl vector194
vector194:
  pushl $0
80105907:	6a 00                	push   $0x0
  pushl $194
80105909:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
8010590e:	e9 4a f4 ff ff       	jmp    80104d5d <alltraps>

80105913 <vector195>:
.globl vector195
vector195:
  pushl $0
80105913:	6a 00                	push   $0x0
  pushl $195
80105915:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
8010591a:	e9 3e f4 ff ff       	jmp    80104d5d <alltraps>

8010591f <vector196>:
.globl vector196
vector196:
  pushl $0
8010591f:	6a 00                	push   $0x0
  pushl $196
80105921:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80105926:	e9 32 f4 ff ff       	jmp    80104d5d <alltraps>

8010592b <vector197>:
.globl vector197
vector197:
  pushl $0
8010592b:	6a 00                	push   $0x0
  pushl $197
8010592d:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80105932:	e9 26 f4 ff ff       	jmp    80104d5d <alltraps>

80105937 <vector198>:
.globl vector198
vector198:
  pushl $0
80105937:	6a 00                	push   $0x0
  pushl $198
80105939:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
8010593e:	e9 1a f4 ff ff       	jmp    80104d5d <alltraps>

80105943 <vector199>:
.globl vector199
vector199:
  pushl $0
80105943:	6a 00                	push   $0x0
  pushl $199
80105945:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
8010594a:	e9 0e f4 ff ff       	jmp    80104d5d <alltraps>

8010594f <vector200>:
.globl vector200
vector200:
  pushl $0
8010594f:	6a 00                	push   $0x0
  pushl $200
80105951:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80105956:	e9 02 f4 ff ff       	jmp    80104d5d <alltraps>

8010595b <vector201>:
.globl vector201
vector201:
  pushl $0
8010595b:	6a 00                	push   $0x0
  pushl $201
8010595d:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80105962:	e9 f6 f3 ff ff       	jmp    80104d5d <alltraps>

80105967 <vector202>:
.globl vector202
vector202:
  pushl $0
80105967:	6a 00                	push   $0x0
  pushl $202
80105969:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
8010596e:	e9 ea f3 ff ff       	jmp    80104d5d <alltraps>

80105973 <vector203>:
.globl vector203
vector203:
  pushl $0
80105973:	6a 00                	push   $0x0
  pushl $203
80105975:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
8010597a:	e9 de f3 ff ff       	jmp    80104d5d <alltraps>

8010597f <vector204>:
.globl vector204
vector204:
  pushl $0
8010597f:	6a 00                	push   $0x0
  pushl $204
80105981:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80105986:	e9 d2 f3 ff ff       	jmp    80104d5d <alltraps>

8010598b <vector205>:
.globl vector205
vector205:
  pushl $0
8010598b:	6a 00                	push   $0x0
  pushl $205
8010598d:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80105992:	e9 c6 f3 ff ff       	jmp    80104d5d <alltraps>

80105997 <vector206>:
.globl vector206
vector206:
  pushl $0
80105997:	6a 00                	push   $0x0
  pushl $206
80105999:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
8010599e:	e9 ba f3 ff ff       	jmp    80104d5d <alltraps>

801059a3 <vector207>:
.globl vector207
vector207:
  pushl $0
801059a3:	6a 00                	push   $0x0
  pushl $207
801059a5:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801059aa:	e9 ae f3 ff ff       	jmp    80104d5d <alltraps>

801059af <vector208>:
.globl vector208
vector208:
  pushl $0
801059af:	6a 00                	push   $0x0
  pushl $208
801059b1:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801059b6:	e9 a2 f3 ff ff       	jmp    80104d5d <alltraps>

801059bb <vector209>:
.globl vector209
vector209:
  pushl $0
801059bb:	6a 00                	push   $0x0
  pushl $209
801059bd:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801059c2:	e9 96 f3 ff ff       	jmp    80104d5d <alltraps>

801059c7 <vector210>:
.globl vector210
vector210:
  pushl $0
801059c7:	6a 00                	push   $0x0
  pushl $210
801059c9:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801059ce:	e9 8a f3 ff ff       	jmp    80104d5d <alltraps>

801059d3 <vector211>:
.globl vector211
vector211:
  pushl $0
801059d3:	6a 00                	push   $0x0
  pushl $211
801059d5:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801059da:	e9 7e f3 ff ff       	jmp    80104d5d <alltraps>

801059df <vector212>:
.globl vector212
vector212:
  pushl $0
801059df:	6a 00                	push   $0x0
  pushl $212
801059e1:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801059e6:	e9 72 f3 ff ff       	jmp    80104d5d <alltraps>

801059eb <vector213>:
.globl vector213
vector213:
  pushl $0
801059eb:	6a 00                	push   $0x0
  pushl $213
801059ed:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801059f2:	e9 66 f3 ff ff       	jmp    80104d5d <alltraps>

801059f7 <vector214>:
.globl vector214
vector214:
  pushl $0
801059f7:	6a 00                	push   $0x0
  pushl $214
801059f9:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801059fe:	e9 5a f3 ff ff       	jmp    80104d5d <alltraps>

80105a03 <vector215>:
.globl vector215
vector215:
  pushl $0
80105a03:	6a 00                	push   $0x0
  pushl $215
80105a05:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80105a0a:	e9 4e f3 ff ff       	jmp    80104d5d <alltraps>

80105a0f <vector216>:
.globl vector216
vector216:
  pushl $0
80105a0f:	6a 00                	push   $0x0
  pushl $216
80105a11:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80105a16:	e9 42 f3 ff ff       	jmp    80104d5d <alltraps>

80105a1b <vector217>:
.globl vector217
vector217:
  pushl $0
80105a1b:	6a 00                	push   $0x0
  pushl $217
80105a1d:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80105a22:	e9 36 f3 ff ff       	jmp    80104d5d <alltraps>

80105a27 <vector218>:
.globl vector218
vector218:
  pushl $0
80105a27:	6a 00                	push   $0x0
  pushl $218
80105a29:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80105a2e:	e9 2a f3 ff ff       	jmp    80104d5d <alltraps>

80105a33 <vector219>:
.globl vector219
vector219:
  pushl $0
80105a33:	6a 00                	push   $0x0
  pushl $219
80105a35:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80105a3a:	e9 1e f3 ff ff       	jmp    80104d5d <alltraps>

80105a3f <vector220>:
.globl vector220
vector220:
  pushl $0
80105a3f:	6a 00                	push   $0x0
  pushl $220
80105a41:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80105a46:	e9 12 f3 ff ff       	jmp    80104d5d <alltraps>

80105a4b <vector221>:
.globl vector221
vector221:
  pushl $0
80105a4b:	6a 00                	push   $0x0
  pushl $221
80105a4d:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80105a52:	e9 06 f3 ff ff       	jmp    80104d5d <alltraps>

80105a57 <vector222>:
.globl vector222
vector222:
  pushl $0
80105a57:	6a 00                	push   $0x0
  pushl $222
80105a59:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80105a5e:	e9 fa f2 ff ff       	jmp    80104d5d <alltraps>

80105a63 <vector223>:
.globl vector223
vector223:
  pushl $0
80105a63:	6a 00                	push   $0x0
  pushl $223
80105a65:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80105a6a:	e9 ee f2 ff ff       	jmp    80104d5d <alltraps>

80105a6f <vector224>:
.globl vector224
vector224:
  pushl $0
80105a6f:	6a 00                	push   $0x0
  pushl $224
80105a71:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80105a76:	e9 e2 f2 ff ff       	jmp    80104d5d <alltraps>

80105a7b <vector225>:
.globl vector225
vector225:
  pushl $0
80105a7b:	6a 00                	push   $0x0
  pushl $225
80105a7d:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80105a82:	e9 d6 f2 ff ff       	jmp    80104d5d <alltraps>

80105a87 <vector226>:
.globl vector226
vector226:
  pushl $0
80105a87:	6a 00                	push   $0x0
  pushl $226
80105a89:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80105a8e:	e9 ca f2 ff ff       	jmp    80104d5d <alltraps>

80105a93 <vector227>:
.globl vector227
vector227:
  pushl $0
80105a93:	6a 00                	push   $0x0
  pushl $227
80105a95:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80105a9a:	e9 be f2 ff ff       	jmp    80104d5d <alltraps>

80105a9f <vector228>:
.globl vector228
vector228:
  pushl $0
80105a9f:	6a 00                	push   $0x0
  pushl $228
80105aa1:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80105aa6:	e9 b2 f2 ff ff       	jmp    80104d5d <alltraps>

80105aab <vector229>:
.globl vector229
vector229:
  pushl $0
80105aab:	6a 00                	push   $0x0
  pushl $229
80105aad:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80105ab2:	e9 a6 f2 ff ff       	jmp    80104d5d <alltraps>

80105ab7 <vector230>:
.globl vector230
vector230:
  pushl $0
80105ab7:	6a 00                	push   $0x0
  pushl $230
80105ab9:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80105abe:	e9 9a f2 ff ff       	jmp    80104d5d <alltraps>

80105ac3 <vector231>:
.globl vector231
vector231:
  pushl $0
80105ac3:	6a 00                	push   $0x0
  pushl $231
80105ac5:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80105aca:	e9 8e f2 ff ff       	jmp    80104d5d <alltraps>

80105acf <vector232>:
.globl vector232
vector232:
  pushl $0
80105acf:	6a 00                	push   $0x0
  pushl $232
80105ad1:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80105ad6:	e9 82 f2 ff ff       	jmp    80104d5d <alltraps>

80105adb <vector233>:
.globl vector233
vector233:
  pushl $0
80105adb:	6a 00                	push   $0x0
  pushl $233
80105add:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80105ae2:	e9 76 f2 ff ff       	jmp    80104d5d <alltraps>

80105ae7 <vector234>:
.globl vector234
vector234:
  pushl $0
80105ae7:	6a 00                	push   $0x0
  pushl $234
80105ae9:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80105aee:	e9 6a f2 ff ff       	jmp    80104d5d <alltraps>

80105af3 <vector235>:
.globl vector235
vector235:
  pushl $0
80105af3:	6a 00                	push   $0x0
  pushl $235
80105af5:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80105afa:	e9 5e f2 ff ff       	jmp    80104d5d <alltraps>

80105aff <vector236>:
.globl vector236
vector236:
  pushl $0
80105aff:	6a 00                	push   $0x0
  pushl $236
80105b01:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80105b06:	e9 52 f2 ff ff       	jmp    80104d5d <alltraps>

80105b0b <vector237>:
.globl vector237
vector237:
  pushl $0
80105b0b:	6a 00                	push   $0x0
  pushl $237
80105b0d:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80105b12:	e9 46 f2 ff ff       	jmp    80104d5d <alltraps>

80105b17 <vector238>:
.globl vector238
vector238:
  pushl $0
80105b17:	6a 00                	push   $0x0
  pushl $238
80105b19:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80105b1e:	e9 3a f2 ff ff       	jmp    80104d5d <alltraps>

80105b23 <vector239>:
.globl vector239
vector239:
  pushl $0
80105b23:	6a 00                	push   $0x0
  pushl $239
80105b25:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80105b2a:	e9 2e f2 ff ff       	jmp    80104d5d <alltraps>

80105b2f <vector240>:
.globl vector240
vector240:
  pushl $0
80105b2f:	6a 00                	push   $0x0
  pushl $240
80105b31:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80105b36:	e9 22 f2 ff ff       	jmp    80104d5d <alltraps>

80105b3b <vector241>:
.globl vector241
vector241:
  pushl $0
80105b3b:	6a 00                	push   $0x0
  pushl $241
80105b3d:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80105b42:	e9 16 f2 ff ff       	jmp    80104d5d <alltraps>

80105b47 <vector242>:
.globl vector242
vector242:
  pushl $0
80105b47:	6a 00                	push   $0x0
  pushl $242
80105b49:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80105b4e:	e9 0a f2 ff ff       	jmp    80104d5d <alltraps>

80105b53 <vector243>:
.globl vector243
vector243:
  pushl $0
80105b53:	6a 00                	push   $0x0
  pushl $243
80105b55:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80105b5a:	e9 fe f1 ff ff       	jmp    80104d5d <alltraps>

80105b5f <vector244>:
.globl vector244
vector244:
  pushl $0
80105b5f:	6a 00                	push   $0x0
  pushl $244
80105b61:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80105b66:	e9 f2 f1 ff ff       	jmp    80104d5d <alltraps>

80105b6b <vector245>:
.globl vector245
vector245:
  pushl $0
80105b6b:	6a 00                	push   $0x0
  pushl $245
80105b6d:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80105b72:	e9 e6 f1 ff ff       	jmp    80104d5d <alltraps>

80105b77 <vector246>:
.globl vector246
vector246:
  pushl $0
80105b77:	6a 00                	push   $0x0
  pushl $246
80105b79:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80105b7e:	e9 da f1 ff ff       	jmp    80104d5d <alltraps>

80105b83 <vector247>:
.globl vector247
vector247:
  pushl $0
80105b83:	6a 00                	push   $0x0
  pushl $247
80105b85:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80105b8a:	e9 ce f1 ff ff       	jmp    80104d5d <alltraps>

80105b8f <vector248>:
.globl vector248
vector248:
  pushl $0
80105b8f:	6a 00                	push   $0x0
  pushl $248
80105b91:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80105b96:	e9 c2 f1 ff ff       	jmp    80104d5d <alltraps>

80105b9b <vector249>:
.globl vector249
vector249:
  pushl $0
80105b9b:	6a 00                	push   $0x0
  pushl $249
80105b9d:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80105ba2:	e9 b6 f1 ff ff       	jmp    80104d5d <alltraps>

80105ba7 <vector250>:
.globl vector250
vector250:
  pushl $0
80105ba7:	6a 00                	push   $0x0
  pushl $250
80105ba9:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80105bae:	e9 aa f1 ff ff       	jmp    80104d5d <alltraps>

80105bb3 <vector251>:
.globl vector251
vector251:
  pushl $0
80105bb3:	6a 00                	push   $0x0
  pushl $251
80105bb5:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80105bba:	e9 9e f1 ff ff       	jmp    80104d5d <alltraps>

80105bbf <vector252>:
.globl vector252
vector252:
  pushl $0
80105bbf:	6a 00                	push   $0x0
  pushl $252
80105bc1:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80105bc6:	e9 92 f1 ff ff       	jmp    80104d5d <alltraps>

80105bcb <vector253>:
.globl vector253
vector253:
  pushl $0
80105bcb:	6a 00                	push   $0x0
  pushl $253
80105bcd:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80105bd2:	e9 86 f1 ff ff       	jmp    80104d5d <alltraps>

80105bd7 <vector254>:
.globl vector254
vector254:
  pushl $0
80105bd7:	6a 00                	push   $0x0
  pushl $254
80105bd9:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80105bde:	e9 7a f1 ff ff       	jmp    80104d5d <alltraps>

80105be3 <vector255>:
.globl vector255
vector255:
  pushl $0
80105be3:	6a 00                	push   $0x0
  pushl $255
80105be5:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80105bea:	e9 6e f1 ff ff       	jmp    80104d5d <alltraps>
80105bef:	90                   	nop

80105bf0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80105bf0:	55                   	push   %ebp
80105bf1:	89 e5                	mov    %esp,%ebp
80105bf3:	57                   	push   %edi
80105bf4:	56                   	push   %esi
80105bf5:	53                   	push   %ebx
80105bf6:	83 ec 0c             	sub    $0xc,%esp
80105bf9:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80105bfb:	c1 ea 16             	shr    $0x16,%edx
80105bfe:	8d 3c 90             	lea    (%eax,%edx,4),%edi
  if(*pde & PTE_P){
80105c01:	8b 07                	mov    (%edi),%eax
80105c03:	a8 01                	test   $0x1,%al
80105c05:	74 21                	je     80105c28 <walkpgdir+0x38>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80105c07:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80105c0c:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80105c12:	c1 eb 0a             	shr    $0xa,%ebx
80105c15:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
80105c1b:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
80105c1e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c21:	5b                   	pop    %ebx
80105c22:	5e                   	pop    %esi
80105c23:	5f                   	pop    %edi
80105c24:	5d                   	pop    %ebp
80105c25:	c3                   	ret    
80105c26:	66 90                	xchg   %ax,%ax

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80105c28:	85 c9                	test   %ecx,%ecx
80105c2a:	74 2c                	je     80105c58 <walkpgdir+0x68>
80105c2c:	e8 9f c5 ff ff       	call   801021d0 <kalloc>
80105c31:	89 c6                	mov    %eax,%esi
80105c33:	85 c0                	test   %eax,%eax
80105c35:	74 21                	je     80105c58 <walkpgdir+0x68>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80105c37:	50                   	push   %eax
80105c38:	68 00 10 00 00       	push   $0x1000
80105c3d:	6a 00                	push   $0x0
80105c3f:	56                   	push   %esi
80105c40:	e8 53 e1 ff ff       	call   80103d98 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80105c45:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80105c4b:	83 c8 07             	or     $0x7,%eax
80105c4e:	89 07                	mov    %eax,(%edi)
80105c50:	83 c4 10             	add    $0x10,%esp
80105c53:	eb bd                	jmp    80105c12 <walkpgdir+0x22>
80105c55:	8d 76 00             	lea    0x0(%esi),%esi
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
80105c58:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80105c5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c5d:	5b                   	pop    %ebx
80105c5e:	5e                   	pop    %esi
80105c5f:	5f                   	pop    %edi
80105c60:	5d                   	pop    %ebp
80105c61:	c3                   	ret    
80105c62:	66 90                	xchg   %ax,%ax

80105c64 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80105c64:	55                   	push   %ebp
80105c65:	89 e5                	mov    %esp,%ebp
80105c67:	57                   	push   %edi
80105c68:	56                   	push   %esi
80105c69:	53                   	push   %ebx
80105c6a:	83 ec 1c             	sub    $0x1c,%esp
80105c6d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80105c70:	89 d3                	mov    %edx,%ebx
80105c72:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80105c78:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80105c7c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80105c81:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105c84:	8b 7d 08             	mov    0x8(%ebp),%edi
80105c87:	29 df                	sub    %ebx,%edi
80105c89:	8b 45 0c             	mov    0xc(%ebp),%eax
80105c8c:	83 c8 01             	or     $0x1,%eax
80105c8f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105c92:	eb 15                	jmp    80105ca9 <mappages+0x45>
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80105c94:	f6 00 01             	testb  $0x1,(%eax)
80105c97:	75 3d                	jne    80105cd6 <mappages+0x72>
      panic("remap");
    *pte = pa | perm | PTE_P;
80105c99:	0b 75 dc             	or     -0x24(%ebp),%esi
80105c9c:	89 30                	mov    %esi,(%eax)
    if(a == last)
80105c9e:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
80105ca1:	74 29                	je     80105ccc <mappages+0x68>
      break;
    a += PGSIZE;
80105ca3:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80105ca9:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80105cac:	b9 01 00 00 00       	mov    $0x1,%ecx
80105cb1:	89 da                	mov    %ebx,%edx
80105cb3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105cb6:	e8 35 ff ff ff       	call   80105bf0 <walkpgdir>
80105cbb:	85 c0                	test   %eax,%eax
80105cbd:	75 d5                	jne    80105c94 <mappages+0x30>
      return -1;
80105cbf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80105cc4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105cc7:	5b                   	pop    %ebx
80105cc8:	5e                   	pop    %esi
80105cc9:	5f                   	pop    %edi
80105cca:	5d                   	pop    %ebp
80105ccb:	c3                   	ret    
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80105ccc:	31 c0                	xor    %eax,%eax
}
80105cce:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105cd1:	5b                   	pop    %ebx
80105cd2:	5e                   	pop    %esi
80105cd3:	5f                   	pop    %edi
80105cd4:	5d                   	pop    %ebp
80105cd5:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
80105cd6:	83 ec 0c             	sub    $0xc,%esp
80105cd9:	68 4c 6d 10 80       	push   $0x80106d4c
80105cde:	e8 55 a6 ff ff       	call   80100338 <panic>
80105ce3:	90                   	nop

80105ce4 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80105ce4:	55                   	push   %ebp
80105ce5:	89 e5                	mov    %esp,%ebp
80105ce7:	57                   	push   %edi
80105ce8:	56                   	push   %esi
80105ce9:	53                   	push   %ebx
80105cea:	83 ec 1c             	sub    $0x1c,%esp
80105ced:	89 c7                	mov    %eax,%edi
80105cef:	89 d6                	mov    %edx,%esi
80105cf1:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80105cf4:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80105cfa:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80105d00:	39 d3                	cmp    %edx,%ebx
80105d02:	72 3b                	jb     80105d3f <deallocuvm.part.0+0x5b>
80105d04:	eb 5e                	jmp    80105d64 <deallocuvm.part.0+0x80>
80105d06:	66 90                	xchg   %ax,%ax
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80105d08:	8b 10                	mov    (%eax),%edx
80105d0a:	f6 c2 01             	test   $0x1,%dl
80105d0d:	74 26                	je     80105d35 <deallocuvm.part.0+0x51>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80105d0f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80105d15:	74 58                	je     80105d6f <deallocuvm.part.0+0x8b>
80105d17:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80105d1a:	83 ec 0c             	sub    $0xc,%esp
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
      char *v = P2V(pa);
80105d1d:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
80105d23:	52                   	push   %edx
80105d24:	e8 1b c3 ff ff       	call   80102044 <kfree>
      *pte = 0;
80105d29:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105d2c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105d32:	83 c4 10             	add    $0x10,%esp

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80105d35:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80105d3b:	39 f3                	cmp    %esi,%ebx
80105d3d:	73 25                	jae    80105d64 <deallocuvm.part.0+0x80>
    pte = walkpgdir(pgdir, (char*)a, 0);
80105d3f:	31 c9                	xor    %ecx,%ecx
80105d41:	89 da                	mov    %ebx,%edx
80105d43:	89 f8                	mov    %edi,%eax
80105d45:	e8 a6 fe ff ff       	call   80105bf0 <walkpgdir>
    if(!pte)
80105d4a:	85 c0                	test   %eax,%eax
80105d4c:	75 ba                	jne    80105d08 <deallocuvm.part.0+0x24>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80105d4e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80105d54:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80105d5a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80105d60:	39 f3                	cmp    %esi,%ebx
80105d62:	72 db                	jb     80105d3f <deallocuvm.part.0+0x5b>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80105d64:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105d67:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d6a:	5b                   	pop    %ebx
80105d6b:	5e                   	pop    %esi
80105d6c:	5f                   	pop    %edi
80105d6d:	5d                   	pop    %ebp
80105d6e:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80105d6f:	83 ec 0c             	sub    $0xc,%esp
80105d72:	68 c6 66 10 80       	push   $0x801066c6
80105d77:	e8 bc a5 ff ff       	call   80100338 <panic>

80105d7c <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80105d7c:	55                   	push   %ebp
80105d7d:	89 e5                	mov    %esp,%ebp
80105d7f:	53                   	push   %ebx
80105d80:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80105d83:	e8 0c d5 ff ff       	call   80103294 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80105d88:	8d 14 80             	lea    (%eax,%eax,4),%edx
80105d8b:	01 d2                	add    %edx,%edx
80105d8d:	01 d0                	add    %edx,%eax
80105d8f:	c1 e0 04             	shl    $0x4,%eax
80105d92:	8d 90 80 17 11 80    	lea    -0x7feee880(%eax),%edx
80105d98:	66 c7 42 78 ff ff    	movw   $0xffff,0x78(%edx)
80105d9e:	66 c7 42 7a 00 00    	movw   $0x0,0x7a(%edx)
80105da4:	c6 42 7c 00          	movb   $0x0,0x7c(%edx)
80105da8:	c6 80 fd 17 11 80 9a 	movb   $0x9a,-0x7feee803(%eax)
80105daf:	c6 80 fe 17 11 80 cf 	movb   $0xcf,-0x7feee802(%eax)
80105db6:	c6 42 7f 00          	movb   $0x0,0x7f(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80105dba:	66 c7 82 80 00 00 00 	movw   $0xffff,0x80(%edx)
80105dc1:	ff ff 
80105dc3:	66 c7 82 82 00 00 00 	movw   $0x0,0x82(%edx)
80105dca:	00 00 
80105dcc:	c6 82 84 00 00 00 00 	movb   $0x0,0x84(%edx)
80105dd3:	c6 80 05 18 11 80 92 	movb   $0x92,-0x7feee7fb(%eax)
80105dda:	c6 80 06 18 11 80 cf 	movb   $0xcf,-0x7feee7fa(%eax)
80105de1:	c6 82 87 00 00 00 00 	movb   $0x0,0x87(%edx)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80105de8:	66 c7 82 88 00 00 00 	movw   $0xffff,0x88(%edx)
80105def:	ff ff 
80105df1:	66 c7 82 8a 00 00 00 	movw   $0x0,0x8a(%edx)
80105df8:	00 00 
80105dfa:	c6 82 8c 00 00 00 00 	movb   $0x0,0x8c(%edx)
80105e01:	c6 80 0d 18 11 80 fa 	movb   $0xfa,-0x7feee7f3(%eax)
80105e08:	c6 80 0e 18 11 80 cf 	movb   $0xcf,-0x7feee7f2(%eax)
80105e0f:	c6 82 8f 00 00 00 00 	movb   $0x0,0x8f(%edx)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80105e16:	8d 8a 90 00 00 00    	lea    0x90(%edx),%ecx
80105e1c:	66 c7 82 90 00 00 00 	movw   $0xffff,0x90(%edx)
80105e23:	ff ff 
80105e25:	66 c7 82 92 00 00 00 	movw   $0x0,0x92(%edx)
80105e2c:	00 00 
80105e2e:	c6 82 94 00 00 00 00 	movb   $0x0,0x94(%edx)
80105e35:	c6 80 15 18 11 80 f2 	movb   $0xf2,-0x7feee7eb(%eax)
80105e3c:	c6 80 16 18 11 80 cf 	movb   $0xcf,-0x7feee7ea(%eax)
80105e43:	c6 41 07 00          	movb   $0x0,0x7(%ecx)
  lgdt(c->gdt, sizeof(c->gdt));
80105e47:	05 f0 17 11 80       	add    $0x801117f0,%eax
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80105e4c:	66 c7 45 f2 2f 00    	movw   $0x2f,-0xe(%ebp)
  pd[1] = (uint)p;
80105e52:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80105e56:	c1 e8 10             	shr    $0x10,%eax
80105e59:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80105e5d:	8d 45 f2             	lea    -0xe(%ebp),%eax
80105e60:	0f 01 10             	lgdtl  (%eax)
}
80105e63:	83 c4 14             	add    $0x14,%esp
80105e66:	5b                   	pop    %ebx
80105e67:	5d                   	pop    %ebp
80105e68:	c3                   	ret    
80105e69:	8d 76 00             	lea    0x0(%esi),%esi

80105e6c <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80105e6c:	55                   	push   %ebp
80105e6d:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80105e6f:	a1 a4 44 11 80       	mov    0x801144a4,%eax
80105e74:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80105e79:	0f 22 d8             	mov    %eax,%cr3
}
80105e7c:	5d                   	pop    %ebp
80105e7d:	c3                   	ret    
80105e7e:	66 90                	xchg   %ax,%ax

80105e80 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80105e80:	55                   	push   %ebp
80105e81:	89 e5                	mov    %esp,%ebp
80105e83:	57                   	push   %edi
80105e84:	56                   	push   %esi
80105e85:	53                   	push   %ebx
80105e86:	83 ec 1c             	sub    $0x1c,%esp
80105e89:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80105e8c:	85 f6                	test   %esi,%esi
80105e8e:	0f 84 c4 00 00 00    	je     80105f58 <switchuvm+0xd8>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80105e94:	8b 56 08             	mov    0x8(%esi),%edx
80105e97:	85 d2                	test   %edx,%edx
80105e99:	0f 84 d3 00 00 00    	je     80105f72 <switchuvm+0xf2>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80105e9f:	8b 46 04             	mov    0x4(%esi),%eax
80105ea2:	85 c0                	test   %eax,%eax
80105ea4:	0f 84 bb 00 00 00    	je     80105f65 <switchuvm+0xe5>
    panic("switchuvm: no pgdir");

  pushcli();
80105eaa:	e8 91 dd ff ff       	call   80103c40 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80105eaf:	e8 68 d3 ff ff       	call   8010321c <mycpu>
80105eb4:	89 c3                	mov    %eax,%ebx
80105eb6:	e8 61 d3 ff ff       	call   8010321c <mycpu>
80105ebb:	89 c7                	mov    %eax,%edi
80105ebd:	e8 5a d3 ff ff       	call   8010321c <mycpu>
80105ec2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80105ec5:	e8 52 d3 ff ff       	call   8010321c <mycpu>
80105eca:	66 c7 83 98 00 00 00 	movw   $0x67,0x98(%ebx)
80105ed1:	67 00 
80105ed3:	83 c7 08             	add    $0x8,%edi
80105ed6:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80105edd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105ee0:	83 c1 08             	add    $0x8,%ecx
80105ee3:	c1 e9 10             	shr    $0x10,%ecx
80105ee6:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80105eec:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80105ef3:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80105efa:	83 c0 08             	add    $0x8,%eax
80105efd:	c1 e8 18             	shr    $0x18,%eax
80105f00:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
80105f06:	e8 11 d3 ff ff       	call   8010321c <mycpu>
80105f0b:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80105f12:	e8 05 d3 ff ff       	call   8010321c <mycpu>
80105f17:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80105f1d:	e8 fa d2 ff ff       	call   8010321c <mycpu>
80105f22:	8b 56 08             	mov    0x8(%esi),%edx
80105f25:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80105f2b:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80105f2e:	e8 e9 d2 ff ff       	call   8010321c <mycpu>
80105f33:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
80105f39:	b8 28 00 00 00       	mov    $0x28,%eax
80105f3e:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
80105f41:	8b 46 04             	mov    0x4(%esi),%eax
80105f44:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80105f49:	0f 22 d8             	mov    %eax,%cr3
  popcli();
}
80105f4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f4f:	5b                   	pop    %ebx
80105f50:	5e                   	pop    %esi
80105f51:	5f                   	pop    %edi
80105f52:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80105f53:	e9 90 dd ff ff       	jmp    80103ce8 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
80105f58:	83 ec 0c             	sub    $0xc,%esp
80105f5b:	68 52 6d 10 80       	push   $0x80106d52
80105f60:	e8 d3 a3 ff ff       	call   80100338 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80105f65:	83 ec 0c             	sub    $0xc,%esp
80105f68:	68 7d 6d 10 80       	push   $0x80106d7d
80105f6d:	e8 c6 a3 ff ff       	call   80100338 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80105f72:	83 ec 0c             	sub    $0xc,%esp
80105f75:	68 68 6d 10 80       	push   $0x80106d68
80105f7a:	e8 b9 a3 ff ff       	call   80100338 <panic>
80105f7f:	90                   	nop

80105f80 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80105f80:	55                   	push   %ebp
80105f81:	89 e5                	mov    %esp,%ebp
80105f83:	57                   	push   %edi
80105f84:	56                   	push   %esi
80105f85:	53                   	push   %ebx
80105f86:	83 ec 1c             	sub    $0x1c,%esp
80105f89:	8b 45 08             	mov    0x8(%ebp),%eax
80105f8c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80105f8f:	8b 7d 0c             	mov    0xc(%ebp),%edi
80105f92:	8b 75 10             	mov    0x10(%ebp),%esi
  char *mem;

  if(sz >= PGSIZE)
80105f95:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80105f9b:	77 47                	ja     80105fe4 <inituvm+0x64>
    panic("inituvm: more than a page");
  mem = kalloc();
80105f9d:	e8 2e c2 ff ff       	call   801021d0 <kalloc>
80105fa2:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80105fa4:	50                   	push   %eax
80105fa5:	68 00 10 00 00       	push   $0x1000
80105faa:	6a 00                	push   $0x0
80105fac:	53                   	push   %ebx
80105fad:	e8 e6 dd ff ff       	call   80103d98 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80105fb2:	5a                   	pop    %edx
80105fb3:	59                   	pop    %ecx
80105fb4:	6a 06                	push   $0x6
80105fb6:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80105fbc:	50                   	push   %eax
80105fbd:	b9 00 10 00 00       	mov    $0x1000,%ecx
80105fc2:	31 d2                	xor    %edx,%edx
80105fc4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105fc7:	e8 98 fc ff ff       	call   80105c64 <mappages>
  memmove(mem, init, sz);
80105fcc:	83 c4 10             	add    $0x10,%esp
80105fcf:	89 75 10             	mov    %esi,0x10(%ebp)
80105fd2:	89 7d 0c             	mov    %edi,0xc(%ebp)
80105fd5:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80105fd8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105fdb:	5b                   	pop    %ebx
80105fdc:	5e                   	pop    %esi
80105fdd:	5f                   	pop    %edi
80105fde:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80105fdf:	e9 48 de ff ff       	jmp    80103e2c <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80105fe4:	83 ec 0c             	sub    $0xc,%esp
80105fe7:	68 91 6d 10 80       	push   $0x80106d91
80105fec:	e8 47 a3 ff ff       	call   80100338 <panic>
80105ff1:	8d 76 00             	lea    0x0(%esi),%esi

80105ff4 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80105ff4:	55                   	push   %ebp
80105ff5:	89 e5                	mov    %esp,%ebp
80105ff7:	57                   	push   %edi
80105ff8:	56                   	push   %esi
80105ff9:	53                   	push   %ebx
80105ffa:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80105ffd:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106004:	0f 85 8c 00 00 00    	jne    80106096 <loaduvm+0xa2>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
8010600a:	8b 45 18             	mov    0x18(%ebp),%eax
8010600d:	85 c0                	test   %eax,%eax
8010600f:	74 5f                	je     80106070 <loaduvm+0x7c>
80106011:	8b 75 18             	mov    0x18(%ebp),%esi
80106014:	31 db                	xor    %ebx,%ebx
80106016:	eb 2f                	jmp    80106047 <loaduvm+0x53>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
80106018:	89 f7                	mov    %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010601a:	57                   	push   %edi
8010601b:	8b 4d 14             	mov    0x14(%ebp),%ecx
8010601e:	01 d9                	add    %ebx,%ecx
80106020:	51                   	push   %ecx
80106021:	05 00 00 00 80       	add    $0x80000000,%eax
80106026:	50                   	push   %eax
80106027:	ff 75 10             	pushl  0x10(%ebp)
8010602a:	e8 45 b7 ff ff       	call   80101774 <readi>
8010602f:	83 c4 10             	add    $0x10,%esp
80106032:	39 f8                	cmp    %edi,%eax
80106034:	75 46                	jne    8010607c <loaduvm+0x88>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106036:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010603c:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106042:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106045:	76 29                	jbe    80106070 <loaduvm+0x7c>
80106047:	8b 55 0c             	mov    0xc(%ebp),%edx
8010604a:	01 da                	add    %ebx,%edx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010604c:	31 c9                	xor    %ecx,%ecx
8010604e:	8b 45 08             	mov    0x8(%ebp),%eax
80106051:	e8 9a fb ff ff       	call   80105bf0 <walkpgdir>
80106056:	85 c0                	test   %eax,%eax
80106058:	74 2f                	je     80106089 <loaduvm+0x95>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
8010605a:	8b 00                	mov    (%eax),%eax
8010605c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106061:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106067:	76 af                	jbe    80106018 <loaduvm+0x24>
      n = sz - i;
    else
      n = PGSIZE;
80106069:	bf 00 10 00 00       	mov    $0x1000,%edi
8010606e:	eb aa                	jmp    8010601a <loaduvm+0x26>
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80106070:	31 c0                	xor    %eax,%eax
}
80106072:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106075:	5b                   	pop    %ebx
80106076:	5e                   	pop    %esi
80106077:	5f                   	pop    %edi
80106078:	5d                   	pop    %ebp
80106079:	c3                   	ret    
8010607a:	66 90                	xchg   %ax,%ax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
8010607c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80106081:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106084:	5b                   	pop    %ebx
80106085:	5e                   	pop    %esi
80106086:	5f                   	pop    %edi
80106087:	5d                   	pop    %ebp
80106088:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106089:	83 ec 0c             	sub    $0xc,%esp
8010608c:	68 ab 6d 10 80       	push   $0x80106dab
80106091:	e8 a2 a2 ff ff       	call   80100338 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80106096:	83 ec 0c             	sub    $0xc,%esp
80106099:	68 4c 6e 10 80       	push   $0x80106e4c
8010609e:	e8 95 a2 ff ff       	call   80100338 <panic>
801060a3:	90                   	nop

801060a4 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
801060a4:	55                   	push   %ebp
801060a5:	89 e5                	mov    %esp,%ebp
801060a7:	57                   	push   %edi
801060a8:	56                   	push   %esi
801060a9:	53                   	push   %ebx
801060aa:	83 ec 0c             	sub    $0xc,%esp
801060ad:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
801060b0:	85 ff                	test   %edi,%edi
801060b2:	78 75                	js     80106129 <allocuvm+0x85>
    return 0;
  if(newsz < oldsz)
    return oldsz;
801060b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
801060b7:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801060ba:	72 6f                	jb     8010612b <allocuvm+0x87>
    return oldsz;

  a = PGROUNDUP(oldsz);
801060bc:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801060c2:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
801060c8:	39 df                	cmp    %ebx,%edi
801060ca:	77 3d                	ja     80106109 <allocuvm+0x65>
801060cc:	eb 66                	jmp    80106134 <allocuvm+0x90>
801060ce:	66 90                	xchg   %ax,%ax
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
801060d0:	50                   	push   %eax
801060d1:	68 00 10 00 00       	push   $0x1000
801060d6:	6a 00                	push   $0x0
801060d8:	56                   	push   %esi
801060d9:	e8 ba dc ff ff       	call   80103d98 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801060de:	5a                   	pop    %edx
801060df:	59                   	pop    %ecx
801060e0:	6a 06                	push   $0x6
801060e2:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801060e8:	50                   	push   %eax
801060e9:	b9 00 10 00 00       	mov    $0x1000,%ecx
801060ee:	89 da                	mov    %ebx,%edx
801060f0:	8b 45 08             	mov    0x8(%ebp),%eax
801060f3:	e8 6c fb ff ff       	call   80105c64 <mappages>
801060f8:	83 c4 10             	add    $0x10,%esp
801060fb:	85 c0                	test   %eax,%eax
801060fd:	78 41                	js     80106140 <allocuvm+0x9c>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
801060ff:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106105:	39 df                	cmp    %ebx,%edi
80106107:	76 2b                	jbe    80106134 <allocuvm+0x90>
    mem = kalloc();
80106109:	e8 c2 c0 ff ff       	call   801021d0 <kalloc>
8010610e:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106110:	85 c0                	test   %eax,%eax
80106112:	75 bc                	jne    801060d0 <allocuvm+0x2c>
      cprintf("allocuvm out of memory\n");
80106114:	83 ec 0c             	sub    $0xc,%esp
80106117:	68 c9 6d 10 80       	push   $0x80106dc9
8010611c:	e8 e7 a4 ff ff       	call   80100608 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106121:	83 c4 10             	add    $0x10,%esp
80106124:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106127:	77 49                	ja     80106172 <allocuvm+0xce>
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80106129:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
8010612b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010612e:	5b                   	pop    %ebx
8010612f:	5e                   	pop    %esi
80106130:	5f                   	pop    %edi
80106131:	5d                   	pop    %ebp
80106132:	c3                   	ret    
80106133:	90                   	nop
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106134:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106136:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106139:	5b                   	pop    %ebx
8010613a:	5e                   	pop    %esi
8010613b:	5f                   	pop    %edi
8010613c:	5d                   	pop    %ebp
8010613d:	c3                   	ret    
8010613e:	66 90                	xchg   %ax,%ax
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106140:	83 ec 0c             	sub    $0xc,%esp
80106143:	68 e1 6d 10 80       	push   $0x80106de1
80106148:	e8 bb a4 ff ff       	call   80100608 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
8010614d:	83 c4 10             	add    $0x10,%esp
80106150:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106153:	76 0d                	jbe    80106162 <allocuvm+0xbe>
80106155:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106158:	89 fa                	mov    %edi,%edx
8010615a:	8b 45 08             	mov    0x8(%ebp),%eax
8010615d:	e8 82 fb ff ff       	call   80105ce4 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80106162:	83 ec 0c             	sub    $0xc,%esp
80106165:	56                   	push   %esi
80106166:	e8 d9 be ff ff       	call   80102044 <kfree>
      return 0;
8010616b:	83 c4 10             	add    $0x10,%esp
8010616e:	31 c0                	xor    %eax,%eax
80106170:	eb b9                	jmp    8010612b <allocuvm+0x87>
80106172:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106175:	89 fa                	mov    %edi,%edx
80106177:	8b 45 08             	mov    0x8(%ebp),%eax
8010617a:	e8 65 fb ff ff       	call   80105ce4 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
8010617f:	31 c0                	xor    %eax,%eax
80106181:	eb a8                	jmp    8010612b <allocuvm+0x87>
80106183:	90                   	nop

80106184 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106184:	55                   	push   %ebp
80106185:	89 e5                	mov    %esp,%ebp
80106187:	8b 45 08             	mov    0x8(%ebp),%eax
8010618a:	8b 55 0c             	mov    0xc(%ebp),%edx
8010618d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106190:	39 d1                	cmp    %edx,%ecx
80106192:	73 08                	jae    8010619c <deallocuvm+0x18>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106194:	5d                   	pop    %ebp
80106195:	e9 4a fb ff ff       	jmp    80105ce4 <deallocuvm.part.0>
8010619a:	66 90                	xchg   %ax,%ax
8010619c:	89 d0                	mov    %edx,%eax
8010619e:	5d                   	pop    %ebp
8010619f:	c3                   	ret    

801061a0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801061a0:	55                   	push   %ebp
801061a1:	89 e5                	mov    %esp,%ebp
801061a3:	57                   	push   %edi
801061a4:	56                   	push   %esi
801061a5:	53                   	push   %ebx
801061a6:	83 ec 0c             	sub    $0xc,%esp
801061a9:	8b 7d 08             	mov    0x8(%ebp),%edi
  uint i;

  if(pgdir == 0)
801061ac:	85 ff                	test   %edi,%edi
801061ae:	74 51                	je     80106201 <freevm+0x61>
801061b0:	31 c9                	xor    %ecx,%ecx
801061b2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801061b7:	89 f8                	mov    %edi,%eax
801061b9:	e8 26 fb ff ff       	call   80105ce4 <deallocuvm.part.0>
801061be:	89 fb                	mov    %edi,%ebx
801061c0:	8d b7 00 10 00 00    	lea    0x1000(%edi),%esi
801061c6:	eb 07                	jmp    801061cf <freevm+0x2f>
801061c8:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801061cb:	39 f3                	cmp    %esi,%ebx
801061cd:	74 23                	je     801061f2 <freevm+0x52>
    if(pgdir[i] & PTE_P){
801061cf:	8b 03                	mov    (%ebx),%eax
801061d1:	a8 01                	test   $0x1,%al
801061d3:	74 f3                	je     801061c8 <freevm+0x28>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
801061d5:	83 ec 0c             	sub    $0xc,%esp
  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
801061d8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801061dd:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801061e2:	50                   	push   %eax
801061e3:	e8 5c be ff ff       	call   80102044 <kfree>
801061e8:	83 c4 10             	add    $0x10,%esp
801061eb:	83 c3 04             	add    $0x4,%ebx
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801061ee:	39 f3                	cmp    %esi,%ebx
801061f0:	75 dd                	jne    801061cf <freevm+0x2f>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801061f2:	89 7d 08             	mov    %edi,0x8(%ebp)
}
801061f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801061f8:	5b                   	pop    %ebx
801061f9:	5e                   	pop    %esi
801061fa:	5f                   	pop    %edi
801061fb:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801061fc:	e9 43 be ff ff       	jmp    80102044 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80106201:	83 ec 0c             	sub    $0xc,%esp
80106204:	68 fd 6d 10 80       	push   $0x80106dfd
80106209:	e8 2a a1 ff ff       	call   80100338 <panic>
8010620e:	66 90                	xchg   %ax,%ax

80106210 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80106210:	55                   	push   %ebp
80106211:	89 e5                	mov    %esp,%ebp
80106213:	56                   	push   %esi
80106214:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80106215:	e8 b6 bf ff ff       	call   801021d0 <kalloc>
8010621a:	89 c6                	mov    %eax,%esi
8010621c:	85 c0                	test   %eax,%eax
8010621e:	74 64                	je     80106284 <setupkvm+0x74>
    return 0;
  memset(pgdir, 0, PGSIZE);
80106220:	50                   	push   %eax
80106221:	68 00 10 00 00       	push   $0x1000
80106226:	6a 00                	push   $0x0
80106228:	56                   	push   %esi
80106229:	e8 6a db ff ff       	call   80103d98 <memset>
8010622e:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106231:	bb 20 94 10 80       	mov    $0x80109420,%ebx
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106236:	8b 43 04             	mov    0x4(%ebx),%eax
80106239:	83 ec 08             	sub    $0x8,%esp
8010623c:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010623f:	29 c1                	sub    %eax,%ecx
80106241:	ff 73 0c             	pushl  0xc(%ebx)
80106244:	50                   	push   %eax
80106245:	8b 13                	mov    (%ebx),%edx
80106247:	89 f0                	mov    %esi,%eax
80106249:	e8 16 fa ff ff       	call   80105c64 <mappages>
8010624e:	83 c4 10             	add    $0x10,%esp
80106251:	85 c0                	test   %eax,%eax
80106253:	78 17                	js     8010626c <setupkvm+0x5c>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106255:	83 c3 10             	add    $0x10,%ebx
80106258:	81 fb 60 94 10 80    	cmp    $0x80109460,%ebx
8010625e:	72 d6                	jb     80106236 <setupkvm+0x26>
80106260:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
80106262:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106265:	5b                   	pop    %ebx
80106266:	5e                   	pop    %esi
80106267:	5d                   	pop    %ebp
80106268:	c3                   	ret    
80106269:	8d 76 00             	lea    0x0(%esi),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
8010626c:	83 ec 0c             	sub    $0xc,%esp
8010626f:	56                   	push   %esi
80106270:	e8 2b ff ff ff       	call   801061a0 <freevm>
      return 0;
80106275:	83 c4 10             	add    $0x10,%esp
80106278:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
8010627a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010627d:	5b                   	pop    %ebx
8010627e:	5e                   	pop    %esi
8010627f:	5d                   	pop    %ebp
80106280:	c3                   	ret    
80106281:	8d 76 00             	lea    0x0(%esi),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80106284:	31 c0                	xor    %eax,%eax
80106286:	eb da                	jmp    80106262 <setupkvm+0x52>

80106288 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80106288:	55                   	push   %ebp
80106289:	89 e5                	mov    %esp,%ebp
8010628b:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
8010628e:	e8 7d ff ff ff       	call   80106210 <setupkvm>
80106293:	a3 a4 44 11 80       	mov    %eax,0x801144a4
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106298:	05 00 00 00 80       	add    $0x80000000,%eax
8010629d:	0f 22 d8             	mov    %eax,%cr3
void
kvmalloc(void)
{
  kpgdir = setupkvm();
  switchkvm();
}
801062a0:	c9                   	leave  
801062a1:	c3                   	ret    
801062a2:	66 90                	xchg   %ax,%ax

801062a4 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801062a4:	55                   	push   %ebp
801062a5:	89 e5                	mov    %esp,%ebp
801062a7:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801062aa:	31 c9                	xor    %ecx,%ecx
801062ac:	8b 55 0c             	mov    0xc(%ebp),%edx
801062af:	8b 45 08             	mov    0x8(%ebp),%eax
801062b2:	e8 39 f9 ff ff       	call   80105bf0 <walkpgdir>
  if(pte == 0)
801062b7:	85 c0                	test   %eax,%eax
801062b9:	74 05                	je     801062c0 <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
801062bb:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801062be:	c9                   	leave  
801062bf:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
801062c0:	83 ec 0c             	sub    $0xc,%esp
801062c3:	68 0e 6e 10 80       	push   $0x80106e0e
801062c8:	e8 6b a0 ff ff       	call   80100338 <panic>
801062cd:	8d 76 00             	lea    0x0(%esi),%esi

801062d0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801062d0:	55                   	push   %ebp
801062d1:	89 e5                	mov    %esp,%ebp
801062d3:	57                   	push   %edi
801062d4:	56                   	push   %esi
801062d5:	53                   	push   %ebx
801062d6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801062d9:	e8 32 ff ff ff       	call   80106210 <setupkvm>
801062de:	89 45 e0             	mov    %eax,-0x20(%ebp)
801062e1:	85 c0                	test   %eax,%eax
801062e3:	0f 84 a6 00 00 00    	je     8010638f <copyuvm+0xbf>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801062e9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801062ec:	85 db                	test   %ebx,%ebx
801062ee:	0f 84 90 00 00 00    	je     80106384 <copyuvm+0xb4>
801062f4:	31 f6                	xor    %esi,%esi
801062f6:	eb 40                	jmp    80106338 <copyuvm+0x68>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801062f8:	50                   	push   %eax
801062f9:	68 00 10 00 00       	push   $0x1000
801062fe:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80106304:	57                   	push   %edi
80106305:	53                   	push   %ebx
80106306:	e8 21 db ff ff       	call   80103e2c <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
8010630b:	5a                   	pop    %edx
8010630c:	59                   	pop    %ecx
8010630d:	ff 75 e4             	pushl  -0x1c(%ebp)
80106310:	8d 93 00 00 00 80    	lea    -0x80000000(%ebx),%edx
80106316:	52                   	push   %edx
80106317:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010631c:	89 f2                	mov    %esi,%edx
8010631e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106321:	e8 3e f9 ff ff       	call   80105c64 <mappages>
80106326:	83 c4 10             	add    $0x10,%esp
80106329:	85 c0                	test   %eax,%eax
8010632b:	78 3e                	js     8010636b <copyuvm+0x9b>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
8010632d:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106333:	39 75 0c             	cmp    %esi,0xc(%ebp)
80106336:	76 4c                	jbe    80106384 <copyuvm+0xb4>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106338:	31 c9                	xor    %ecx,%ecx
8010633a:	89 f2                	mov    %esi,%edx
8010633c:	8b 45 08             	mov    0x8(%ebp),%eax
8010633f:	e8 ac f8 ff ff       	call   80105bf0 <walkpgdir>
80106344:	85 c0                	test   %eax,%eax
80106346:	74 58                	je     801063a0 <copyuvm+0xd0>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80106348:	8b 18                	mov    (%eax),%ebx
8010634a:	f6 c3 01             	test   $0x1,%bl
8010634d:	74 44                	je     80106393 <copyuvm+0xc3>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
8010634f:	89 df                	mov    %ebx,%edi
80106351:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    flags = PTE_FLAGS(*pte);
80106357:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
8010635d:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80106360:	e8 6b be ff ff       	call   801021d0 <kalloc>
80106365:	89 c3                	mov    %eax,%ebx
80106367:	85 c0                	test   %eax,%eax
80106369:	75 8d                	jne    801062f8 <copyuvm+0x28>
      goto bad;
  }
  return d;

bad:
  freevm(d);
8010636b:	83 ec 0c             	sub    $0xc,%esp
8010636e:	ff 75 e0             	pushl  -0x20(%ebp)
80106371:	e8 2a fe ff ff       	call   801061a0 <freevm>
  return 0;
80106376:	83 c4 10             	add    $0x10,%esp
80106379:	31 c0                	xor    %eax,%eax
}
8010637b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010637e:	5b                   	pop    %ebx
8010637f:	5e                   	pop    %esi
80106380:	5f                   	pop    %edi
80106381:	5d                   	pop    %ebp
80106382:	c3                   	ret    
80106383:	90                   	nop
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106384:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
80106387:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010638a:	5b                   	pop    %ebx
8010638b:	5e                   	pop    %esi
8010638c:	5f                   	pop    %edi
8010638d:	5d                   	pop    %ebp
8010638e:	c3                   	ret    
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
8010638f:	31 c0                	xor    %eax,%eax
80106391:	eb e8                	jmp    8010637b <copyuvm+0xab>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
80106393:	83 ec 0c             	sub    $0xc,%esp
80106396:	68 32 6e 10 80       	push   $0x80106e32
8010639b:	e8 98 9f ff ff       	call   80100338 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
801063a0:	83 ec 0c             	sub    $0xc,%esp
801063a3:	68 18 6e 10 80       	push   $0x80106e18
801063a8:	e8 8b 9f ff ff       	call   80100338 <panic>
801063ad:	8d 76 00             	lea    0x0(%esi),%esi

801063b0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801063b0:	55                   	push   %ebp
801063b1:	89 e5                	mov    %esp,%ebp
801063b3:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801063b6:	31 c9                	xor    %ecx,%ecx
801063b8:	8b 55 0c             	mov    0xc(%ebp),%edx
801063bb:	8b 45 08             	mov    0x8(%ebp),%eax
801063be:	e8 2d f8 ff ff       	call   80105bf0 <walkpgdir>
  if((*pte & PTE_P) == 0)
801063c3:	8b 00                	mov    (%eax),%eax
801063c5:	89 c2                	mov    %eax,%edx
801063c7:	83 e2 05             	and    $0x5,%edx
    return 0;
  if((*pte & PTE_U) == 0)
801063ca:	83 fa 05             	cmp    $0x5,%edx
801063cd:	75 0d                	jne    801063dc <uva2ka+0x2c>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801063cf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801063d4:	05 00 00 00 80       	add    $0x80000000,%eax
}
801063d9:	c9                   	leave  
801063da:	c3                   	ret    
801063db:	90                   	nop

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
801063dc:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
801063de:	c9                   	leave  
801063df:	c3                   	ret    

801063e0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801063e0:	55                   	push   %ebp
801063e1:	89 e5                	mov    %esp,%ebp
801063e3:	57                   	push   %edi
801063e4:	56                   	push   %esi
801063e5:	53                   	push   %ebx
801063e6:	83 ec 0c             	sub    $0xc,%esp
801063e9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801063ec:	8b 4d 14             	mov    0x14(%ebp),%ecx
801063ef:	89 df                	mov    %ebx,%edi
801063f1:	85 c9                	test   %ecx,%ecx
801063f3:	75 37                	jne    8010642c <copyout+0x4c>
801063f5:	eb 5d                	jmp    80106454 <copyout+0x74>
801063f7:	90                   	nop
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801063f8:	89 f2                	mov    %esi,%edx
801063fa:	29 fa                	sub    %edi,%edx
801063fc:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
80106402:	3b 5d 14             	cmp    0x14(%ebp),%ebx
80106405:	76 03                	jbe    8010640a <copyout+0x2a>
80106407:	8b 5d 14             	mov    0x14(%ebp),%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
8010640a:	52                   	push   %edx
8010640b:	53                   	push   %ebx
8010640c:	ff 75 10             	pushl  0x10(%ebp)
8010640f:	89 f9                	mov    %edi,%ecx
80106411:	29 f1                	sub    %esi,%ecx
80106413:	01 c8                	add    %ecx,%eax
80106415:	50                   	push   %eax
80106416:	e8 11 da ff ff       	call   80103e2c <memmove>
    len -= n;
    buf += n;
8010641b:	01 5d 10             	add    %ebx,0x10(%ebp)
    va = va0 + PGSIZE;
8010641e:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106424:	83 c4 10             	add    $0x10,%esp
80106427:	29 5d 14             	sub    %ebx,0x14(%ebp)
8010642a:	74 28                	je     80106454 <copyout+0x74>
    va0 = (uint)PGROUNDDOWN(va);
8010642c:	89 fe                	mov    %edi,%esi
8010642e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80106434:	83 ec 08             	sub    $0x8,%esp
80106437:	56                   	push   %esi
80106438:	ff 75 08             	pushl  0x8(%ebp)
8010643b:	e8 70 ff ff ff       	call   801063b0 <uva2ka>
    if(pa0 == 0)
80106440:	83 c4 10             	add    $0x10,%esp
80106443:	85 c0                	test   %eax,%eax
80106445:	75 b1                	jne    801063f8 <copyout+0x18>
      return -1;
80106447:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
8010644c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010644f:	5b                   	pop    %ebx
80106450:	5e                   	pop    %esi
80106451:	5f                   	pop    %edi
80106452:	5d                   	pop    %ebp
80106453:	c3                   	ret    
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80106454:	31 c0                	xor    %eax,%eax
}
80106456:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106459:	5b                   	pop    %ebx
8010645a:	5e                   	pop    %esi
8010645b:	5f                   	pop    %edi
8010645c:	5d                   	pop    %ebp
8010645d:	c3                   	ret    
