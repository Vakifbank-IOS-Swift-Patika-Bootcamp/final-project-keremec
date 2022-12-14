- [ ] Clean Code

- [ ] It is easy to say that names should reveal intent. What we want to impress upon you is that we are serious about this. Choosing good names takes time but saves more than it takes. So take care with your names and change them when you find better ones. Everyone who reads your code (including you) will be happier if you do. 
- [ ] Programmers must avoid leaving false clues that obscure the meaning of code. We should avoid words whose entrenched meanings vary from our intended meaning. 
- [ ] It is not sufficient to add number series or noise words, even though the compiler is satisfied. If names must be different, then they should also mean something different. 
- [ ] Humans are good at words. A significant part of our brains is dedicated to the concept of words. And words are, by definition, pronounceable. 
- [ ] Use searchable names. Single-letter names and numeric constants have a particular problem in that they are not easy to locate across a body of text. 
- [ ] We have enough encodings to deal with without adding more to our burden. Encoding type or scope information into names simply adds an extra burden of deciphering. 
- [ ] Readers shouldn’t have to mentally translate your names into other names they already know. This problem generally arises from a choice to use neither problem domain terms nor solution domain terms. 
- [ ] asses and objects should have noun or noun phrase names like Customer, WikiPage, Account, and AddressParser. Avoid words like Manager, Processor, Data, or Info in the name of a class. A class name should not be a verb. 
- [ ] Methods should have verb or verb phrase names like postPayment, deletePage, or save. Accessors, mutators, and predicates should be named for their value and prefixed with get, set, and is according to the javabean standard. 
- [ ] If names are too clever, they will be memorable only to people who share the author’s sense of humor, and only as long as these people remember the joke. Will they know what the function named HolyHandGrenade is supposed to do? Sure, it’s cute, but maybe in this case DeleteItems might be a better name. Choose clarity over entertainment value 
- [ ] Pick one word for one abstract concept and stick with it. 
- [ ] Avoid using the same word for two purposes. Using the same term for two different ideas is essentially a pun. 
- [ ] FUNCTIONS SHOULD DO ONE THING. THEY SHOULD DO IT WELL. THEY SHOULD DO IT ONLY.
- [ ] Side effects are lies. Your function promises to do one thing, but it also does other hidden things. Sometimes it will make unexpected changes to the variables of its own class. Sometimes it will make them to the parameters passed into the function or to system globals. In either case they are devious and damaging mistruths that often result in strange temporal couplings and order dependencies. 
- [ ] There is a well-known heuristic called the Law of Demeter2 that says a module should not know about the innards of the objects it manipulates. 
- [ ] When we return null, we are essentially creating work for ourselves and foisting problems upon our callers. All it takes is one missing null check to send an application spinning out of control. 
- [ ] Returning null from methods is bad, but passing null into methods is worse. Unless you are working with an API which expects you to pass null, you should avoid passing null in your code whenever possible. 
- [ ] Now everyone knows that TDD asks us to write unit tests first, before we write produc- tion code. 
- [ ] But that rule is just the tip of the iceberg. Consider the following three laws 
- [ ] You may not write production code until you have written a failing unit test. 
- [ ] You may not write more of a unit test than is sufficient to fail, and not com- 
- [ ] piling is failing. 
- [ ] You may not write more production code than is sufficient to pass the cur- rently failing test. 
- [ ] The first rule of classes is that they should be small. The second rule of classes is that they should be smaller than that. 
- [ ] Duplication is the primary enemy of a well-designed system. It represents additional work, additional risk, and additional unnecessary complexity. 
