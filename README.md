##Complete Me

CompleteMe is an autocompletion tool that suggests words from a dictionary given a partial entry.  It notes selections made by user for a partial entry and future suggestions will be weighted according to previous selections.

####To Use:

Open a session of Pry or IRB and load the CompleteMe file:
`require "./lib/complete_me" `

Instantiate an autocompletion object:

`completion = CompleteMe.new`

Populate the autocompletion dictionary with a dictionary or words loaded on your computer:

```
dictionary = File.read("/usr/share/dict/words")
completion.populate(dictionary)
```

To get suggested words for a partial entry, use the `suggest` method as follows:

`completion.suggest("piz")`

To enter your preferences to get better suggestions in future entries, use the `select` method as follows:

`completion.select("piz", "pizzeria")`
