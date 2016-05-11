# I am very sorry to whomever may have to work with the below.
# It's as neat as I could make it, but ultimately when you have to insert a huge
# ball of data you get a huge unreadable file. If it helps, take heart in the
# fact that the bastardised JS/embedded JSON file from which much of this
# derives was twice the size.

################################################################################
# These are the first eight kiosks, created for the pilot. Others may antecede.

kiosks = [
  ['gp-godalming',   'Catteshall Mill, Catteshall Road, Godalming, GU7 1JW',            'Robin Forward - robin.forward@nhs.net',               2],
  ['gp-farnham',     'Farnham Centre for Health, Hale Road, Farnham, GU9 9QS',          'Deji Bajomo - deji.bajomo@property.nhs.uk',           2],
  ['gp-cranleigh',   'Cranleigh Medical Practice, 18 High Street, Cranleigh, GU6 8AE',  'Jackie Stockill - jacqueline.stockill@nhs.net',       2],
  ['furniturelink',  'Unit 4, Deaconsfield, Cathedral Hill, Guildford, GU2 8YT',        'Various - 01483 506504',                              1],
  ['ageuk',          'Age UK, William Road, Guildford, GU1 4QZ',                        'David Hahn - 01483 503414',                           1],
  ['waverley',       'New Montrose House, 36 Bridge Street, Godalming, GU7 1HP',        'Michele Taylor - admin@farnhamcab.cabnet.org.uk',     2],
  ['ash',            'Ash CA, Ash Hill Road, Ash, Aldershot, GU12 5DP',                 'Karen Creeth - ',                                     1],
  ['guildford',      'Guildford CA, 15 Haydon Place, City Centre, Guildford, GU1 4LL',  'Erica Sandford - erica.sandford@guildfordcab.org.uk', 1]
]

kiosks.each do |name, address, contact, jurisdiction_id|
  k = Kiosk.find_or_create_by(name: name)
  k.update_attributes(address: address, contact: contact, jurisdiction_id: jurisdiction_id)
end

################################################################################

jurisdictions = [
  ['guildford', true, '10.33.228.250'],
  ['waverley',  true, '10.33.228.250']
]

jurisdictions.each do |name, telephone, pbx_server|
  j = Jurisdiction.find_or_create_by(name: name)
  j.update_attributes(name: name, telephone: telephone, pbx_server: pbx_server)
end

################################################################################
# We don't really 'need' to do this next bit, DatabaseStufferJob will create
# them automatically. These are here for testing purposes.

hosts = [
  ['gp-godalming-(Kiosk)' ],
  ['gp-farnham-(Kiosk)'   ],
  ['gp-cranleigh-(Kiosk)' ],
  ['furniturelink-(Kiosk)'],
  ['ageuk-(Kiosk)'        ],
  ['waverley-(Kiosk)'     ],
  ['ash-(Kiosk)'          ],
  ['guildford-(Kiosk)'    ],
  ['ageuk.co.uk'          ],
  ['citizensadvice.org.uk']
]

hosts.each do |name|
  Host.find_or_create_by(name: name)
end

################################################################################

logos = [
  ['gas-logo-full.png',             "Guildford Advice Services", "https://guildfordadviceservices.org", [Jurisdiction.find_by(name: "guildford")]                                        ],
  ['hi_big_e_lrg_blue-2.jpg',       "Big Lottery Fund",          "https://www.biglotteryfund.org.uk/",  [Jurisdiction.find_by(name: "guildford"), Jurisdiction.find_by(name: "waverley")]],
  ['logo.jpg',                      "Waverley Borough Council",  "http://www.waverley.gov.uk",          [Jurisdiction.find_by(name: "waverley")]                                         ],
  ['website_PNG_blue_Waverley.png', "Citizens Advice Waverley",  "http://www.waverleycab.org.uk",       [Jurisdiction.find_by(name: "waverley")]                                         ],
  ['website_PNG_blue.png',          "Citizens Advice Guildford", "http://www.guildfordcab.org.uk",      [Jurisdiction.find_by(name: "guildford")]                                        ]
]

logos.each do |image, title, url, jurisdictions|
  l = Logo.find_or_create_by(title: title, url: url)
  l.update_attributes(image: File.open("app/assets/images/#{image}"), title: title, url: url)
  l.jurisdictions << jurisdictions
  l.save
end

################################################################################
# These topic headings were derived from the Citizens Advice website, after
# much argument. If you need to change them, do so, but be prepared for dragons.

kiosk_topics = [
  ['benefits',            'Benefits',            'Information on claiming benefits' ],
  ['work',                'Work',                'Work and Employment'              ],
  ['debt',                'Debt',                'Help dealing with debt'           ],
  ['consumer',            'Consumer',            'Consumer Issues and Complaints'   ],
  ['relationships',       'Relationships',       'Family and relationship issues'   ],
  ['housing',             'Housing',             'Housing and homelessness'         ],
  ['law_and_rights',      'Law and Rights',      'Legal and rights issues'          ],
  ['discrimination',      'Discrimination',      'Unfair discrimination issues'     ],
  ['tax',                 'Tax',                 'Issues with taxation'             ],
  ['healthcare',          'Healthcare',          'Physical and mental health issues'],
  ['education',           'Education',           'Education and training'           ]
]

kiosk_topics.each do |name, label, description|
  k = KioskTopic.find_or_create_by(name: name)
  k.update_attributes(label: label, description: description)
end

################################################################################
# This is where it gets painful. I hope you have a big screen...

advice_pages = [
  ['Citizens Advice',          'https://www.citizensadvice.org.uk/benefits/',                                        '03448487969', 'The Citizens Advice Information Site',                     ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'benefits'           ],
  ['Turn 2 Us',                'https://www.turn2us.org.uk/Your-Situation',                                          '08088022000', 'Detailed benefits information',                            ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'benefits'           ],
  ['Gov.UK',                   'http://www.gov.uk/browse/benefits',                                                  '',            'The Government benefits guide',                            ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'benefits'           ],
  ['Age UK',                   'http://www.ageuk.org.uk/money-matters/claiming-benefits/',                           '08001696565', 'Benefits for older people',                                ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'benefits'           ],
  ['HMRC',                     'http://www.hmrc.gov.uk',                                                             '03002003300', 'Tax and benefits information',                             ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'benefits'           ],
  ['Citizens Advice',          'https://www.citizensadvice.org.uk/work/',                                            '03448487969', 'The Citizens Advice information site',                     ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'work'               ],
  ['Gov.UK',                   'http://www.gov.uk/browse/working',                                                   '',            'The Government Working Guide',                             ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'work'               ],
  ['Pension Service',          'http://www.gov.uk/contact-pension-service',                                          '',            'The Government Pensions Advice Service',                   ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'work'               ],
  ['ACAS',                     'http://www.acas.org.uk/index.aspx?articleid_1461',                                   '',            'Employment relations advice',                              ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'work'               ],
  ['Tribunal Service',         'http://www.acas.org.uk/index.aspx?articleid_1461',                                   '03001231100', 'Employment tribunals',                                     ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'work'               ],
  ['Age UK',                   'http://www.ageuk.org.uk/work-and-learning/',                                         '08001696565', 'Employment advice for older people',                       ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'work'               ],
  ['National Careers Service', 'https://nationalcareersservice.direct.gov.uk/Pages/Home.aspx',                       '',            'Help and Advice with Careers',                             ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'work'               ],
  ['Citizens Advice',          'https://www.citizensadvice.org.uk/debt-and-money/',                                  '03448487969', 'The Citizens Advice information site',                     ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'debt'               ],
  ['StepChange',               'https://www.stepchange.org',                                                         '08001381111', 'Advice on getting out of debt',                            ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'debt'               ],
  ['Gov.UK',                   'http://www.gov.uk/government/organisations/insolvency-service',                      '',            'The Government Insolvency Service',                        ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'debt'               ],
  ['Money Advice Service',     'http://www.moneyadviceservice.org.uk',                                               '03005005000', 'The UK Money Advice Service',                              ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'debt'               ],
  ['Age UK',                   'http://www.ageuk.org.uk/money-matters/money-management/',                            '08001696565', 'Debt advice for older people',                             ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'debt'               ],
  ['National Debtline',        'https://www.nationaldebtline.org/EW/Pages/default.aspx',                             '08088084000', 'Help with managing debt and money',                        ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'debt'               ],
  ['Citizens Advice',          'https://www.citizensadvice.org.uk/consumer/',                                        '',            'The Citizens Advice information site',                     ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'consumer'           ],
  ['Gov.UK',                   'http://www.gov.uk/consumer-protection-rights/',                                      '',            'The Government consumer rights guide',                     ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'consumer'           ],
  ['Complaints Commission',    'http://www.ukecc.net',                                                               '',            'The European Complaints Commission',                       ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'consumer'           ],
  ['Age UK',                   'http://www.ageuk.org.uk/money-matters/consumer-advice/',                             '08001696565', 'Consumer advice for older people',                         ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'consumer'           ],
  ['Financial Ombudsman',      'http://www.financial-ombudsman.org.uk',                                              '08000234567', 'The Government consumer rights guide',                     ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'consumer'           ],
  ['Citizens Advice',          'https://www.citizensadvice.org.uk/relationships/',                                   '03448487969', 'The Citizens Advice information site',                     ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'relationships'      ],
  ['Gov.UK',                   'http://www.gov.uk/child-maintenance',                                                '',            'The Government Child Maintenance Guide',                   ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'relationships'      ],
  ['Family Mediation Council', 'http://www.familymediationcouncil.org.uk/family-mediation/choose-family-mediation/', '',            'Mediation services',                                       ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'relationships'      ],
  ['Relate',                   'https://www.relate.org.uk',                                                          '03001001234', 'Counselling, support and mediation service',               ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'relationships'      ],
  ['Childline',                'http://www.childline.org.uk/explore/Pages/Explore.aspx',                             '08001111',    'Counselling, support and mediation service',               ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'relationships'      ],
  ['Rasasc',                   'http://www.rasasc.org/advice-guides/',                                               '08000288022', 'Advice and information relating to Rape and Sexual Abuse', ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'relationships'      ],
  ['Age UK',                   'http://www.ageuk.org.uk/health-wellbeing/relationships-and-family/',                 '08001696565', 'Relationship advice for older people',                     ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'relationships'      ],
  ["Women's Aid",              'https://www.womensaid.org.uk/information-support/what-is-domestic-abuse/',           '08082000247', 'Advice and assistance with domestic abuse',                ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'relationships'      ],
  ['Citizens Advice',          'https://www.citizensadvice.org.uk/housing/',                                         '03448487969', 'The Citizens Advice information site',                     ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'housing'            ],
  ['Step by Step',             'http://www.stepbystep.org.uk',                                                       '01252346105', 'Advice on homelessness for young people',                  ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'housing'            ],
  ['Gov.UK',                   'http://www.gov.uk/browse/housing/owning-renting-property',                           '',            'The Government Housing Guide',                             ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'housing'            ],
  ['Age UK',                   'http://www.ageuk.org.uk/home-and-care/',                                             '08001696565', 'Housing advice for older people',                          ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'housing'            ],
  ['Shelter',                  'http://england.shelter.org.uk/get_advice',                                           '',            'Advice on homelessness in England',                        ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'housing'            ],
  ['Citizens Advice',          'https://www.citizensadvice.org.uk/law-and-rights/',                                  '03448487969', 'The Citizens Advice information site',                     ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'law_and_rights'     ],
  ['Gov.UK',                   'https://www.gov.uk/browse/justice',                                                  '',            'Government Justice Guide',                                 ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'law_and_rights'     ],
  ['Gov.UK Immigration',       'https://www.gov.uk/visa-immigration',                                                '',            'Immigration and Residency Law Guide',                      ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'law_and_rights'     ],
  ['CLS Direct Legal Service', 'http://www.clsdirect.org.uk/',                                                       '',            'Legal advice and legal aid',                               ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'law_and_rights'     ],
  ['Age UK',                   'http://www.ageuk.org.uk/money-matters/legal-issues/',                                '08001696565', 'Legal advice for older people',                            ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'law_and_rights'     ],
  ['Power of Attorney',        'http://www.justice.gov.uk/about/opg',                                                '',            'Advice on Powers of Attorney',                             ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'law_and_rights'     ],
  ['Citizens Advice',          'https://www.citizensadvice.org.uk/discrimination/',                                  '03448487969', 'The Citizens Advice information site',                     ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'discrimination'     ],
  ['Age UK',                   'http://www.ageuk.org.uk/work-and-learning/discrimination-and-rights/',               '08001696565', 'Discrimination advice for older people',                   ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'discrimination'     ],
  ['Citizens Advice',          'https://www.citizensadvice.org.uk/tax/',                                             '03448487969', 'Citizens Advice information site',                         ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'tax'                ],
  ['Gov.UK',                   'http://www.gov.uk/browse/tax',                                                       '',            'The Government taxation guide',                            ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'tax'                ],
  ['HM Revenue & Customs',     'http://www.hmrc.gov.uk',                                                             '03002003300', 'Tax and benefits information',                             ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'tax'                ],
  ['Age UK',                   'http://www.ageuk.org.uk/money-matters/income-and-tax/',                              '08001696565', 'Tax advice for older people',                              ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'tax'                ],
  ['TaxAid',                   'http://www.taxaid.org.uk',                                                           '03451203779', 'If HMRC cannot help with a tax issue',                     ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'tax'                ],
  ['Citizens Advice',          'https://www.citizensadvice.org.uk/healthcare/',                                      '03448487969', 'The Citizens Advice information site',                     ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'healthcare'         ],
  ['NHS Choices',              'https://www.nhs.uk/',                                                                '',            'The National Health Service',                              ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'healthcare'         ],
  ['Healthwatch',              'http://www.healthwatch.co.uk',                                                       '03000683000', 'The Health Service Watchdog',                              ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'healthcare'         ],
  ['Age UK',                   'http://www.ageuk.org.uk',                                                            '08001696565', 'Health and advice for older people',                       ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'healthcare'         ],
  ['Mind',                     'http://www.mind.org.uk',                                                             '03001233393', 'Advice and assistance with mental health issues',          ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'healthcare'         ],
  ['Age UK',                   'http://www.ageuk.org.uk',                                                            '08001696565', 'Health and advice for older people',                       ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'healthcare'         ],
  ['NHS Sexual Health',        'http://www.letstalkaboutit.nhs.uk',                                                  '',            'NHS advice on sexual health issues',                       ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'healthcare'         ],
  ['Citizens Advice',          'https://www.citizensadvice.org.uk/education/',                                       '03448487969', 'The Citizens Advice information site',                     ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'education'          ],
  ['Gov.UK',                   'http://www.gov.uk/browse/education',                                                 '',            'The Government Education Guide',                           ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'education'          ],
  ['Age UK',                   'http://www.ageuk.org.uk/work-and-learning/further-education-and-training/',          '08001696565', 'Education advice for older people',                        ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'education'          ],
  ['Education Otherwise',      'http://www.education-otherwise.net',                                                 '08454786345', 'Home Schooling Advice',                                    ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'education'          ],
  ['NUS',                      'http://www.nus.org.uk',                                                              '01625413200', 'National Union of Students',                               ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'education'          ],
  ['IPSEA',                    'http://www.ipsea.org.uk',                                                            '08000184016', 'Special Educational Needs Assistance',                     ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'education'          ],
  ['ACE Education',            'http://www.ace-ed.org.uk',                                                           '02088883377', 'Help with choice of schools',                              ['gp-godalming', 'gp-farnham', 'gp-cranleigh', 'guildford', 'ash', 'waverley', 'furniturelink', 'ageuk'], 'education'          ]
]

advice_pages.each do |organisation, url, telephone, details, kiosks, topic|
  a = AdvicePage.find_or_create_by(url: url) # "organisation" IS NOT UNIQUE IN THIS INSTANCE!
  a.update_attributes(organisation: organisation, telephone: telephone, details: details, kiosks: Kiosk.where(:name => kiosks), topic: topic)
end
