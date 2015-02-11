br1 = Brewery.create name:"Koff", year:1897
br2 = Brewery.create name:"Malmgard", year:2001
br3 = Brewery.create name:"Weihenstephaner", year:1042
br4 = Brewery.create name:"Laitila", year:1995

s1 = Style.create name:"Euro Pale Lager", description: "Similar to the Munich Helles story, many European countries reacted to the popularity of early pale lagers by brewing their own. Hop flavor is significant and of noble varieties, bitterness is moderate, and both are backed by a solid malt body and sweetish notes from an all-malt base."

s2 = Style.create name:"Dunkelweizen", description: "Similar to a Hefeweizen, these southern Germany wheat beers are brewed as darker versions (Dunkel means 'dark') with deliciously complex malts and a low balancing bitterness. Most are brown and murky (from the yeast). The usual clove and fruity (banana) characters will be present, some may even taste like banana bread."

s3 = Style.create name:"American Pale Ale (APA)", description: "Of British origin, this style is now popular worldwide and the use of local ingredients, or imported, produces variances in character from region to region. Generally, expect a good balance of malt and hops. Fruity esters and diacetyl can vary from none to moderate, and bitterness can range from lightly floral to pungent. American versions tend to be cleaner and hoppier, while British tend to be more malty, buttery, aromatic and balanced."

s4 = Style.create name:"American Porter", description: "Inspired from the now wavering English Porter, the American Porter is the ingenuous creation from that. Thankfully with lots of innovation and originality American brewers have taken this style to a new level. Whether it is highly hopping the brew, using smoked malts, or adding coffee or chocolate to complement the burnt flavor associated with this style. Some are even barrel aged in Bourbon or whiskey barrels. The hop bitterness range is quite wide but most are balanced. Many are just easy drinking session porters as well."

Style.create name:"Sahti", description: "Said to be one of the only primitive beers to survive in Western Europe, Sahti is a farmhouse ale with roots in Finland. First brewed by peasants in the 1500s, mashing (steeping of grains) went down in wooden barrels, and then that mash would be scooped into a hand-carved wooden trough (a kuurna) with a bed of juniper twigs that acted as a filter. The bung at the bottom of the kuurna would be pulled to allow the sweet wort (liquid infusion from the mash) to pass through the twig filter, followed by wort recirculation and a hot water sparge (rinsing of the grains), all of which created a juniper infusion of sorts. Sahti is also referred to as being turbid, because the wort isn't boiled after lautering (separation of spent grain and liquid), leaving loads of proteins behind, thus providing tremendous body. A low-flocculating Finnish baker's yeast creates a cloudy unfiltered beer, with an abundance of sediment. Traditional Sahti is not typically hopped, so the task of balancing is left up to the juniper twigs, which impart an unusual resiny character and also act as a preservative. Some have compared Sahtis to German Hefeweizens, though we find them to be more akin to the Lambics of Belgium due to the exposure to wild yeast and bacteria, and its signature tartness."


be1 = Beer.new name:"Iso 3"
be2 = Beer.new name:"Karhu"
be3 = Beer.new name:"Tuplahumala"
be4 = Beer.new name:"X Porter"
be5 = Beer.new name:"Hefezeizen"
be6 = Beer.new name:"Helles"
be7 = Beer.new name:"Kukko"
be8 = Beer.new name:"Huvila Pale Ale"

s1.beers << be1
s1.beers << be2
s1.beers << be7
s2.beers << be3
s2.beers << be5
s3.beers << be8
s4.beers << be4
s4.beers << be6

br1.beers << be1
br1.beers << be2
br1.beers << be3
br2.beers << be4
br3.beers << be5
br3.beers << be6
br4.beers << be7
br2.beers << be8


BeerClub.create name:"Kumpulan Kumoojat", founded:1903, city:"Helsinki"
BeerClub.create name:"Vallilan Hiiva", founded:1857, city:"Helsinki"
BeerClub.create name:"Maatilan Kukko", founded:1675, city:"Sauvo"

User.create username:"admin", password:"A123", password_confirmation:"A123"
