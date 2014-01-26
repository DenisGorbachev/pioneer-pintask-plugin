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

Cards.before.update (userId, card, fieldNames, modifier, options) ->
  if modifier.$set && userId not in card.memberIds
    for key, value of modifier.$set
      matches = key.match(/^comments\.(\d+)\.isNew$/)
      if matches && value == false && card.comments[matches[1]].ownerId == userId
        modifier.$addToSet = modifier.$addToSet || {}
        modifier.$addToSet.memberIds = userId
