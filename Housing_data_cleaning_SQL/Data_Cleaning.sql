select *
from Portfolio.dbo.NashvilleHousing

--Standardizing Date Format, adding new column and deleting it

select SaleDate
from Portfolio.dbo.NashvilleHousing

alter table Portfolio.dbo.NashvilleHousing
add SaleDateConverted date;

update Portfolio.dbo.NashvilleHousing
set SaleDateConverted = CONVERT(date, SaleDate)

alter table Portfolio.dbo.NashvilleHousing
drop column SaleDateConverted


--Populating Property Address data


select *
from Portfolio.dbo.NashvilleHousing
where PropertyAddress is null
order by ParcelID

select *
from Portfolio.dbo.NashvilleHousing a
join Portfolio.dbo.NashvilleHousing b
on a.ParcelID=b.ParcelID
and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null


select a.ParcelID, a.UniqueID, a.PropertyAddress, b.ParcelID, b.UniqueID, b.PropertyAddress, isnull(a.PropertyAddress,b.PropertyAddress)
from Portfolio.dbo.NashvilleHousing a
join Portfolio.dbo.NashvilleHousing b
on a.ParcelID=b.ParcelID
and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null


update a
set PropertyAddress = isnull(a.PropertyAddress,b.PropertyAddress)
from Portfolio.dbo.NashvilleHousing a
join Portfolio.dbo.NashvilleHousing b
on a.ParcelID=b.ParcelID
and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null


--Separaatin the address column into different columns

select OwnerAddress
from Portfolio.dbo.NashvilleHousing


select
parsename(replace(OwnerAddress,',','.'),3) as StreetAddress, 
parsename(replace(OwnerAddress,',','.'),2) as City,
parsename(replace(OwnerAddress,',','.'),1) as StateName
from Portfolio.dbo.NashvilleHousing


alter table Portfolio.dbo.NashvilleHousing
drop column StreetAddress ;

alter table Portfolio.dbo.NashvilleHousing
drop column City;

alter table Portfolio.dbo.NashvilleHousing
drop column StateName;


alter table Portfolio.dbo.NashvilleHousing
add OwnerStreetAddress nvarchar(255);

alter table Portfolio.dbo.NashvilleHousing
add OwnerCity nvarchar(255);

alter table Portfolio.dbo.NashvilleHousing
add OwnerStateName nvarchar(255);


update Portfolio.dbo.NashvilleHousing
set OwnerStreetAddress= parsename(replace(OwnerAddress,',','.'),3) 

update Portfolio.dbo.NashvilleHousing
set OwnerCity= parsename(replace(OwnerAddress,',','.'),2) 

update Portfolio.dbo.NashvilleHousing
set OwnerStateName= parsename(replace(OwnerAddress,',','.'),1) 


select * 
from Portfolio.dbo.NashvilleHousing


select PropertyAddress
from Portfolio.dbo.NashvilleHousing 


select 
parsename(replace(PropertyAddress,',','.'),2) as PropertyStreetAddress,
parsename(replace(PropertyAddress,',','.'),1) as PropertyCity
from Portfolio.dbo.NashvilleHousing


alter table Portfolio.dbo.NashvilleHousing
add PropertyStreetAddress nvarchar(255);

alter table Portfolio.dbo.NashvilleHousing
add PropertyCity nvarchar(255);

update Portfolio.dbo.NashvilleHousing
set PropertyStreetAddress = parsename(replace(PropertyAddress,',','.'),2)


update Portfolio.dbo.NashvilleHousing
set PropertyCity = parsename(replace(PropertyAddress,',','.'),1)



--Changing '1' to Yes and '0' to No in SoldAsVacant column


select distinct(SoldAsVacant), count(SoldAsVacant)
from Portfolio.dbo.NashvilleHousing
group by SoldAsVacant
order by 2


--case statement
alter table Portfolio.dbo.NashvilleHousing
alter column SoldAsVacant nvarchar(255);




select SoldAsVacant,
case when SoldAsVacant='1' then 'Yes'
     when SoldAsVacant= '0' then 'No'
	 else SoldAsVacant
	 end
from Portfolio.dbo.NashvilleHousing



update Portfolio.dbo.NashvilleHousing
set SoldAsVacant = case when SoldAsVacant='1' then 'Yes'
     when SoldAsVacant= '0' then 'No'
	 else SoldAsVacant
	 end
from Portfolio.dbo.NashvilleHousing


select *
from Portfolio.dbo.NashvilleHousing


--Removing Duplicates

ALTER DATABASE Portfolio SET COMPATIBILITY_LEVEL =  100 


WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From Portfolio.dbo.NashvilleHousing
--order by ParcelID
)
--select*
Delete
From RowNumCTE
Where row_num > 1
--Order by PropertyAddress




delete 
order by PropertyAddress


--deleting unused columns


select *
from Portfolio.dbo.NashvilleHousing 


Alter table Portfolio.dbo.NashvilleHousing
Drop column PropertyAddress, OwnerAddress, TaxDistrict