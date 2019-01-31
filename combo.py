# Combinations

from pyds import MassFunction

# For Discourse "put it down"

m1 = MassFunction({'k':0.25, 'kt':0.75})
m2 = MassFunction({'k':1.0})
m3 = MassFunction({'k':0.5, 't':0.5})

m_dcr_putdown = m1.combine_conjunctive(m2,m3)
print("Putdown",m_dcr_putdown.bel())


# For Discourse put it in the bowl

m4 = MassFunction({'k':0.5, 't':0.21, 'kt':0.27})
m5 = MassFunction({'t':1.0})
m6 = MassFunction({'t':1.0})
m_dcr_putin = m4.combine_conjunctive(m5,m6)
print("putin",m_dcr_putin)

# For Discoure pass it to me

#In washing dishes context
m7 = MassFunction({'k':0.4, 't':0.3, 'kt':0.3})
m8_w = MassFunction({'k':1.0})
m9_w = MassFunction({'k':1.0})
m_dcr_pass_w = m7.combine_conjunctive(m8_w,m9_w)
print("pass -wash",m_dcr_pass_w)

#In cooking context
m7 = MassFunction({'k':0.4, 't':0.3, 'kt':0.3})
m8_c = MassFunction({'t':1.0})
m9_c = MassFunction({'t':1.0})
m_dcr_pass_c = m7.combine_conjunctive(m8_c,m9_c)
print("pass -cook",m_dcr_pass_c)
