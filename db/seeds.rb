kiosks = [
  [ "gp-godalming",   "Catteshall Mill, Catteshall Road, Godalming, GU7 1JW",            "Robin Forward - robin.forward@nhs.net", "waverley"],
  [ "gp-farnham",     "Farnham Centre for Health, Hale Road, Farnham, GU9 9QS",          "Deji Bajomo - deji.bajomo@property.nhs.uk", "waverley"],
  [ "gp-cranleigh",   "Cranleigh Medical Practice, 18 High Street, Cranleigh, GU6 8AE",  "Jackie Stockill - jacqueline.stockill@nhs.net", "waverley"],
  [ "furniturelink",  "Unit 4, Deaconsfield, Cathedral Hill, Guildford, GU2 8YT",        "Various - 01483 506504", "guildford"],
  [ "ageuk",          "Age UK, William Road, Guildford, GU1 4QZ",                        "David Hahn - 01483 503414", "guildford"],
  [ "waverley",       "New Montrose House, 36 Bridge Street, Godalming, GU7 1HP",        "Michele Taylor - admin@farnhamcab.cabnet.org.uk", "waverley"],
  [ "ash",            "Ash CA, Ash Hill Road, Ash, Aldershot, GU12 5DP",                 "Karen Creeth - ", "guildford"],
  [ "guildford",      "Guildford CA, 15 Haydon Place, City Centre, Guildford, GU1 4LL",  "Erica Sandford - erica.sandford@guildfordcab.org.uk", "guildford"]
  ]

kiosks.each do |name, address, contact, jurisdiction|
  k = Kiosk.find_or_create_by(:name => name)
  k.update_attributes(:address => address, :contact => contact, :jurisdiction => jurisdiction)
end

hosts = [
  [ "gp-godalming-(Kiosk)"],
  [ "gp-farnham-(Kiosk)"],
  [ "gp-cranleigh-(Kiosk)"],
  [ "furniturelink-(Kiosk)"],
  [ "ageuk-(Kiosk)"],
  [ "waverley-(Kiosk)"],
  [ "ash-(Kiosk)"],
  [ "guildford-(Kiosk)"],
  [ "ageuk.co.uk"],
  [ "citizensadvice.org.uk"]
  ]

hosts.each do |name|
  Host.find_or_create_by(:name => name)
end

kiosk_topics = [
  [ "benefits",  "Benefits", "Information on claiming benefits"],
  [ "work",  "Work", "Work and Employment"],
  [ "debt",  "Debt", "Help dealing with debt"],
  [ "consumer",  "Consumer", "Consumer Issues and Complaints"],
  [ "relationships",  "Relationships", "Family and relationship issues"],
  [ "housing",  "Housing", "Housing and homelessness"],
  [ "law_and_rights",  "Law and Rights", "Legal and rights issues"],
  [ "discrimination",  "Discrimination", "Unfair discrimination issues"],
  [ "tax",  "Tax", "Issues with taxation"],
  [ "healthcare",  "Healthcare", "Physical and mental health issues"],
  [ "education",  "Education", "Education and training"],
  [ "local_organisations",  "Local Organisations", ""]
  ]

kiosk_topics.each do |name, label, description|
  k = KioskTopic.find_or_create_by(:name => name)
  k.update_attributes(:label => label, :description => description)
end

advice_pages = [
  ["Citizens Advice", "https://www.citizensadvice.org.uk/benefits/", "03448487969", "The Citizens Advice Information Site", ["1", "2", "3", "4", "5", "6", "7", "8", "9"], "benefits"],
  ["Turn 2 Us", "https://www.turn2us.org.uk/Your-Situation","08088022000","Detailed benefits information", ["1", "2", "3", "4", "5", "6", "7", "8", "9"], "benefits"],
  ["Gov.UK", "http://www.gov.uk/browse/benefits","","The Government benefits guide", ["1", "2", "3", "4", "5", "6", "7", "8", "9"], "benefits"],
  ["Age UK", "http://www.ageuk.org.uk/money-matters/claiming-benefits/","08001696565","Benefits for older people", ["1", "2", "3", "4", "5", "6", "7", "8", "9"], "benefits"],
  ["HMRC", "http://www.hmrc.gov.uk","03002003300","Tax and benefits information", ["1", "2", "3", "4", "5", "6", "7", "8", "9"], "benefits"],
]

advice_pages.each do |organisation, url, telephone, details, kiosks, topic|
  a = AdvicePage.find_or_create_by(:organisation => organisation)
  a.update_attributes(:url => url, :telephone => telephone, :details => details, :kiosks => kiosks, :topic => topic)
end
