## import data to R from R directory
x <- read.csv("score.csv", header=TRUE)
## the sample turnout which can be changed based on the real turnout we calculated
## initial settings for scoring calculating
y <- 0.1497 ## turnout of certain organization
y.size <- 49165 ## voter size in the organization
## set three ranges for size of x
size_range1 <- 1000
size_range2 <- 3000
size_range3 <- 10000
##
##
x.all <- sqldf("SELECT Turnout FROM x ORDER BY Turnout")
## extract all the tuples with Otype is Association and Membersihp Organization
x.otype <- sqldf("SELECT Turnout FROM x WHERE Otype='Association and Membersihp Organization' ORDER BY Turnout")
## extract all the turnout with Ballot type is Leadership
x.btype <- sqldf("SELECT Turnout FROM x WHERE Etype='Leadership' ORDER BY Turnout")
###################################
if (y.size <= 1000) {
	## extract all the Turnout with Size greater than 49165
	x.size <- sqldf("SELECT Turnout FROM x WHERE Size<=1000 ORDER BY Turnout")
	## set up different conditions
	x.size_otype <- sqldf("SELECT Turnout FROM x WHERE Size<=1000 AND Otype='Association and Membersihp Organization' ORDER BY Turnout")
	x.size_btype <- sqldf("SELECT Turnout FROM x WHERE Size<=1000 AND Etype='Leadership' ORDER BY Turnout")
	x.size_otype_btype <- sqldf("SELECT Turnout FROM x WHERE Size<=1000 AND Otype='Association and Membersihp Organization' AND Etype='Leadership' ORDER BY Turnout")
} else if (y.size > 1000 & y.size <= 3000) {
	## extract all the Turnout with Size greater than 49165
	x.size <- sqldf("SELECT Turnout FROM x WHERE Size>1000 AND Size<=3000 ORDER BY Turnout")
	## set up different conditions
	x.size_otype <- sqldf("SELECT Turnout FROM x WHERE Size>1000 AND Size<=3000 AND Otype='Association and Membersihp Organization' ORDER BY Turnout")
	x.size_btype <- sqldf("SELECT Turnout FROM x WHERE Size>1000 AND Size<=3000 AND Etype='Leadership' ORDER BY Turnout")
	x.size_otype_btype <- sqldf("SELECT Turnout FROM x WHERE Size>1000 AND Size<=3000 AND Otype='Association and Membersihp Organization' AND Etype='Leadership' ORDER BY Turnout")
} else if (y.size > 3000 & y.size < 10000) {
	## extract all the Turnout with Size greater than 49165
	x.size <- sqldf("SELECT Turnout FROM x WHERE Size>3000 AND Size<10000 ORDER BY Turnout")
	## set up different conditions
	x.size_otype <- sqldf("SELECT Turnout FROM x WHERE Size>3000 AND Size<10000 AND Otype='Association and Membersihp Organization' ORDER BY Turnout")
	x.size_btype <- sqldf("SELECT Turnout FROM x WHERE Size>3000 AND Size<10000 AND Etype='Leadership' ORDER BY Turnout")
	x.size_otype_btype <- sqldf("SELECT Turnout FROM x WHERE Size>3000 AND Size<10000 AND Otype='Association and Membersihp Organization' AND Etype='Leadership' ORDER BY Turnout")
} else {
	## extract all the Turnout with Size greater than 49165
	x.size <- sqldf("SELECT Turnout FROM x WHERE Size>=10000 ORDER BY Turnout")
	## set up different conditions
	x.size_otype <- sqldf("SELECT Turnout FROM x WHERE Size>=10000 AND Otype='Association and Membersihp Organization' ORDER BY Turnout")
	x.size_btype <- sqldf("SELECT Turnout FROM x WHERE Size>=10000 AND Etype='Leadership' ORDER BY Turnout")
	x.size_otype_btype <- sqldf("SELECT Turnout FROM x WHERE Size>=10000 AND Otype='Association and Membersihp Organization' AND Etype='Leadership' ORDER BY Turnout")
}
x.otype_btype <- sqldf("SELECT Turnout FROM x WHERE Etype='Leadership' AND Otype='Association and Membersihp Organization' ORDER BY Turnout")
## reformat to vector
x.all <- as.vector(x.all)
x.size <- as.vector(x.size)
x.otype <- as.vector(x.otype)
x.btype <- as.vector(x.btype)
x.size_otype <- as.vector(x.size_otype)
x.size_btype <- as.vector(x.size_btype)
x.otype_btype <- as.vector(x.otype_btype)
x.size_otype_btype <- as.vector(x.size_otype_btype)

## insert the sample turnout into the vector extracted above
x.all <- c(y, x.all$Turnout)
x.size <- c(y, x.size$Turnout)
x.otype <- c(y, x.otype$Turnout)
x.btype <- c(y, x.btype$Turnout)
x.size_otype <- c(y, x.size_otype$Turnout)
x.size_btype <- c(y, x.size_btype$Turnout)
x.otype_btype <- c(y, x.otype_btype$Turnout)
x.size_otype_btype <- c(y, x.size_otype_btype$Turnout)
## calculate the lengths for each vector
x.all.length <- length(x.all)
x.size.length <- length(x.size)
x.otype.length <- length(x.otype)
x.btype.length <- length(x.btype)
x.size_otype.length <- length(x.size_otype)
x.size_btype.length <- length(x.size_btype)
x.otype_btype.length <- length(x.otype_btype)
x.size_otype_btype.length <- length(x.size_otype_btype)
## calculate the rank for each turnout in the vector
x.all.rank <- rank(x.all)
x.size.rank <- rank(x.size)
x.otype.rank <- rank(x.otype)
x.btype.rank <- rank(x.btype)
x.size_otype.rank <- rank(x.size_otype)
x.size_btype.rank <- rank(x.size_btype)
x.otype_btype.rank <- rank(x.otype_btype)
x.size_otype_btype.rank <- rank(x.size_otype_btype)
## let's see the rank of y
y.rank.all <- x.all.rank[1]
y.rank.size <- x.size.rank[1]
y.rank.otype <- x.otype.rank[1]
y.rank.btype <- x.btype.rank[1]
y.rank.size_otype <- x.size_otype.rank[1]
y.rank.size_btype <- x.size_btype.rank[1]
y.rank.otype_btype <- x.otype_btype.rank[1]
y.rank.size_otype_btype <- x.size_otype_btype.rank[1]
## finally, scores come here
score.all <- y.rank.all/x.all.length
score.size <- y.rank.size/x.size.length
score.otype <- y.rank.otype/x.otype.length
score.btype <- y.rank.btype/x.btype.length
score.size_otype <- y.rank.size_otype/x.size_otype.length
score.size_btype <- y.rank.size_btype/x.size_btype.length
score.otype_btype <- y.rank.otype_btype/x.otype_btype.length
score.size_otype_btype <- y.rank.size_otype_btype/x.size_otype_btype.length
## show scores
score.all
score.size
score.otype
score.btype
score.size_otype
score.size_btype
score.otype_btype
score.size_otype_btype
