## What's MemTester - Mac?

It's a native Cocoa port of a game a friend of mine made a while ago. The game was written in Java and was therefore terrible (jk). MemTester - Mac is just a weekend project really. MemTester's a little memory testing game. It'll present you with a series of letters, numbers or characters depending on the difficulty and you'll have to memorise them and then re-enter them. Simple.

## What's completed in MemTester - Mac?

**Not a lot**. So far (7/05/12), you can play a very badly put together version of the easy mode. It's really bad, the window doesn't resize properly or anything. Importantly, however, all the underlying logic is written and it *shouldn't* take too long to implement all the other levels. 

If you want to try the other levels, you can just edit line 24 of *SCGameController.m* and add the following line of code in the method:

```
self.difficulty = 0;
```

0 is easy mode, 1 is medium & 2 is hard. 

## Where's The Original Version of MemTester

My friend has it on a GoogleCode page. There's a desktop version (that needs Java) and an Android version too. There's also source code.

[MemTester (Original)](https://code.google.com/p/mem-tester/)

## License

My friend has it under the GNU GPL v3 license. Does that mean I have to? 