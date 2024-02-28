#!/usr/bin/env python
# coding: utf-8

# In[15]:


import pandas as pd
import seaborn as sns
import numpy as np
import matplotlib.pyplot as plt


# In[16]:


dat = pd.read_csv(r'C:\Users\shash\Downloads\world_population.csv')


# In[17]:


df= pd.DataFrame(dat)


# In[18]:


df.head()


# In[19]:


df.info()


# In[55]:


df.describe()


# In[20]:


pd.set_option('display.float_format', lambda x: '%.2f' % x)


# In[21]:


df.head()


# In[23]:


df.isna().sum()


# In[24]:


df.nunique()


# In[26]:


df.sort_values(by='2022 Population', ascending = False).head(15)


# In[27]:


df.corr()


# In[31]:


sns.heatmap(df.corr(), annot=True)

plt.show()

plt.rcParams['figure.figsize'] = (20,7)


# In[32]:


#correlation ranges from -1 to 1
# positive values means positive correlation, both the variables increase or decrease
# negative value means inversly porportional, if one variable increases then another decreases


# In[ ]:


# lets group the data by continent and see how density is related


# In[43]:


df2= df.groupby('Continent')['1970 Population',
       '1980 Population', '1990 Population', '2000 Population',
       '2010 Population', '2015 Population', '2020 Population',
       '2022 Population'].mean().sort_values(by='2022 Population', ascending=False)


#or use this 
#df2 = df.groupby('Continent')[df.columns[5:13][::-1]].mean(numeric_only=True).sort_values(by='2022 Population', ascending=False)


# In[44]:


df2


# In[45]:


df2.plot()


# In[46]:


df3=df2.transpose()


# In[47]:


df3


# In[48]:


df3.plot()


# In[51]:


df.boxplot(figsize=(20,10))


# In[ ]:


#box plots are really useful for finding the outliers, all the circles or dots represents outliers.
#The lower and upper lines of the box shows upper and lower range ofthe average values. 
#Since this is a population data it is acceptable to have these outliers. 
#If it was a revenu data then we have to investigate.


# In[54]:


df.select_dtypes(include='float')

#select_types selects only those data with the mentioned datatype, which is very useful while retriving only numeric data or categorical data.


# In[ ]:




