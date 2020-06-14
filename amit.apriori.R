library(arules)
library(arulesViz)
library(datasets)
data("Groceries")
str(Groceries)
inspect(Groceries)  #9835 items
head(Groceries@itemInfo, n=12)
summary(Groceries)
itemFrequencyPlot(Groceries,topN=20,type='absolute')
?apriori
rules <- apriori(Groceries) # default rules with confidence 0.8 and support 0.1
rules <- apriori(Groceries, parameter = list(supp =.01, conf=.8)) # let's create a new rule
# high support and high confidence that's why when i run this rule, there is no rule
inspect(rules[1:5])
#mplementing Apriori Algorithm and Key Terms and Usage, decrease support to 0.001, confidence=0.8
rules = apriori(Groceries, parameter = list(support=0.001, confidence=0.8)) #let's fine tune thihs thing with the support - 0.001  #410 rules
#options(digits = 2)
inspect(rules[1:10])
rules <- sort(rules, by="support", decreasing = T) # because we want high support appear 1st
inspect(rules[1:10])
plot(rules[1:20],method = "graph",control = list(type = "items"))
#set of 410 rules
rules <- sort(rules, by="confidence", decreasing = TRUE)
options(digits = 2)
inspect(rules[1:10])


#identify duplicate rules
?is.redundant
rules  
redundant_rules <- is.redundant(rules)
redundant_rules
#TRUE DUPLICATE RULES, #FALSE NOT DUPLICATE RULES
summary(redundant_rules)
#18 rules are duplicate
#removing duplicate rules
rules <- rules[!redundant_rules]
rules # set of 392 rules now
# what other products a customer buy with product x i.e x => ?
inspect(rules[1:5])
#lhs would be whole milk, rhs would be items likely to be bought with whole milk
gr_rules_whole_milk <- apriori(Groceries, parameter = list(supp=.001, conf=.08),appearance =
                                 list(default="rhs", lhs="whole milk"))  
inspect(gr_rules_whole_milk[1:10])
gr_rules_bottled_beer <- apriori(Groceries, parameter = list(supp=.001, conf=.08),appearance =
                                 list(default="rhs", lhs="bottled beer"))  
inspect(gr_rules_bottled_beer[1:10])
plot(rules, method="graph")







#set of 410 rules
redundant_rules <- is.redundant(gr_rules)
redundant_rules
#TRUE DUPLICATE RULES, #FALSE NOT DUPLICATE RULES
summary(redundant_rules)






rules = apriori(Groceries, parameter = list(support=0.001, confidence=0.15)
                ,appearance = list(default="rhs", lhs="whole milk"),
                control = list(verbose=F))
rules<- sort(rules, decreasing=TRUE, by="confidence")
inspect(rules[1:6])
library(arulesViz)
plot(rules,method="graph", interactive=TRUE, shading=NA)