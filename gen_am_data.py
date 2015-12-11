import random
s = """
am in habemus splendide, fuisset insolens salutandi nec ut. In vel case admodum perpetua, ei consulatu mnesarchum eos. Munere fabulas aliquando his id. Justo platonem vituperata mea ex. Mea ad velit dolor officiis, eum ea idque phaedrum moderatius. Partiendo splendide cu duo. Cu tibique similique has, ex quis vide torquatos nec. In ius veniam iriure salutandi. Per in everti maiorum consequuntur, at eruditi reprimique est. Est no aeque alterum honestatis. Odio tractatos no quo, eu quo nostro dolorum recusabo, ne doming appetere sensibus pro. Ea amet habeo regione mea, zril civibus explicari mel et. Id natum veniam utamur eum, tacimates mediocrem mei ad, ut possit disputando per. Per aeterno deserunt delicatissimi id. Et sumo copiosae mea. Ea tale nominati complectitur duo, id vel iusto simul. Dico atomorum id sea, atqui iisque adipisci no eum, sed an nostrud electram appellantur.
""".split()

print "dob, caption, ethnicity, weight, height, bodytype, smoke, drink, seeking, email_domain, ge    nder, zip, lat, long, city, state, contry, status, loginkey, login_key_recurrence"

for i in range(100):
    dob = random.randint(1940,1993)
    cap = ' '.join([random.choice(s) for _ in xrange(20)])
    weight = random.randint(95,300)
    ethnicity = random.randint(0,6)
    height = random.randint(123,183)
    bodytype = random.randint(0,5)
    smoke = random.randint(0,1)
    drink = random.randint(0,1)
    seeking = random.randint(0,5)
    email_domain = random.choice(['google','aol','yahoo','other'])
    gender = random.randint(0,3)
    zip = random.randint(111111,444444)
    city = random.choice(s)
    state = random.choice(s)
    contry = random.choice(s)
    status = random.choice(s)
    login_key = random.choice(s)
    r = random.randint(0,1000)
    print ','.join([str(n) for n in [dob, cap, weight, ethnicity, height, bodytype, smoke, drink, seeking, email_domain, gender, city, state, contry, status, login_key, r]])
