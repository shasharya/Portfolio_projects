#!/usr/bin/env python
# coding: utf-8

# In[30]:


import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
pd.set_option('display.max_columns', 200)


# In[31]:


data= pd.read_csv(r'C:\Users\shash\Downloads\car.csv')


# In[32]:


df= pd.DataFrame(data)


# In[33]:


df.shape


# In[34]:


df.describe


# In[35]:


df.rename(columns={'Invoice':'Invoice_amount'}).copy()


# In[36]:


df.isna().sum()


# In[51]:


df_subset=df.head(20)
ax= df_subset.plot(kind='scatter', x= 'MSRP', y='EngineSize')
ax.set_xticks(range(len(df_subset['MSRP'])))
ax.set_xticklabels(df_subset['MSRP'], rotation=50, ha='left')
plt.show()


# In[65]:


df_subset.value_counts()


# In[73]:


ax1= sns.pairplot(df_subset, vars=['MPG_Highway', 'Weight', 'Wheelbase', 'Length'],
             hue='Type')

plt.suptitle('Factors affecting mileage of a car', y=1.02)


# In[ ]:




