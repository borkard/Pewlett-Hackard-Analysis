# Pewlett-Hackard-Analysis

## Overview
At Pewlett Hackard, a large number of employees seemed to be nearing retirement age.
An analysis was conducted to plan for the retirement of eligible employees at Pewlett Hackard.
The analysis aimed to answer the questions of who would be retiring in the next few years and how many positions will need to be filled.
Although the employee data provided was in six different .csv files, an employee database was created using Postgres and SQL to generate a list of all Pewlett Hackard employees eligible for the retirement package. Using this employee database, the number of retiring employees per title and employees eligible to participate in a mentorship program were determined.

## Results

* Most retirement vacancies will need to be filled in senior positions as 29,414 Senior Engineers and 28,254 Senior Staff are eligible for retirement in the coming years.
* Only 2 managers are eligible for retirement.

*Number of Employees Retiring by Position Title:*

![retiring_titles](https://github.com/borkard/Pewlett-Hackard-Analysis/blob/main/retiring_titles.PNG)


* 1,549 employees are eligible for the mentorship program.
* A majority of the mentorship-eligible employees are either senior staff or engineers.

*Employees eligible for mentorship program:*
![mentorship_eligibility](https://github.com/borkard/Pewlett-Hackard-Analysis/blob/main/mentorship_eligibility.PNG)



## Summary

There are 90,398 positions that will need to be filled as the "silver tsunami" begins to make an impact.
As only 1,549 employees are eligible for the mentorship program, there are more than enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees.

To provide more insight into the upcoming "silver tsunami", it may be helpful to know how many mentorship-eligible employees there are by title (as shown below) to have a better understanding of how to allocate resources when training and filling positions of retirees.


*Number of mentorship-eligible employees by title:*

![mentorship_eligible_title](https://github.com/borkard/Pewlett-Hackard-Analysis/blob/main/mentorship_eligible_title.PNG)


Additionally, it may be useful to group the retiring employees by the year they started working at Pewlett Hackard to better understand the retention of Pewlett Hackard employees.


*Number of retiring employees by starting year:*

![from_date_retirees](https://github.com/borkard/Pewlett-Hackard-Analysis/blob/main/from_date_retirees.PNG)
