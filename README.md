##Complete Me

CompleteMe is an autocompletion tool that suggests words from a dictionary given a partial entry.  It notes selections made by user for a partial entry and future suggestions will be weighted according to previous selections.

####To Use:

You can use this autocomplete program using a dictionary or words already loaded on your computer or for a list of all addresses in the City of Denver.  If you want to use the program with addresses, dowload [this CSV file](http://data.denvergov.org/download/gis/addresses/csv/addresses.csv) from the City of Denver.  Make note of the file path where it is saved.

Open a session of Pry or IRB and load the CompleteMe file:
`require "./lib/complete_me" `

Instantiate an autocompletion object:

`completion = CompleteMe.new`

Populate the autocompletion dictionary with a dictionary of words loaded on your computer:

```
dictionary = File.read("/usr/share/dict/words")
completion.populate(dictionary)
```
or with the Denver street addresses you downloaded earlier:

```
dictionary = completion.get_addresses('YOUR FILE PATH')
completion.populate(dictionary)
```


To get suggested words/addresses for a partial entry, use the `suggest` method as follows:

`completion.suggest("piz")`

To enter your preferences to get better suggestions in future entries, use the `select` method as follows:

`completion.select("piz", "pizzeria")`
