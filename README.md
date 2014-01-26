Autoassign plugin for Pintask
=========================

You add yourself to card members when adding to (or dropping it on) a list that you are a member of.

This versatile plugin is only a couple lines of code:

```coffee
if !Cards
  throw "Hey, where are my Cards?"
if !Lists
  throw "Look, I need those Lists, too!"

Cards.before.insert (userId, card) ->
  list = Lists.findOne(card.listId)
  if userId in list.memberIds && userId not in card.memberIds
    card.memberIds.push(userId)

Cards.before.update (userId, card, fieldNames, modifier, options) ->
  if modifier.$set?.listId
    list = Lists.findOne(modifier.$set.listId)
    if userId in list.memberIds && userId not in card.memberIds
      if !modifier.$addToSet?.memberIds # safety check
        modifier.$addToSet = {memberIds: userId}
```

So easy to make your own plugin ;)
