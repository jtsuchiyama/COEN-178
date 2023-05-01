Select id, MONTHS_BETWEEN(SYSDATE,JoinedDate) Months from L_Member;
Select id, FLOOR(MONTHS_BETWEEN(SYSDATE,JoinedDate)) Months from L_Member;
Select id, FLOOR(MONTHS_BETWEEN(SYSDATE,JoinedDate)/12) Years, FLOOR(MOD(MONTHS_BETWEEN(SYSDATE,JoinedDate),12)) Months from L_Member;

Select id,clubname,joinedDate from L_Member where joinedDate <= all(Select joinedDate from L_Member);

Select id,name from L_Person where exists (Select * from L_Member where L_Person.id = L_Member.id);
Select id,name from L_Person where exists (Select * from L_Member);
Select id,name from L_Person where not exists (Select * from L_Member where L_Person.id = L_Member.id);

SELECT id,name FROM L_Person WHERE id IN (SELECT id FROM L_Member);
SELECT id,name FROM L_Person WHERE id NOT IN (SELECT id FROM L_Member);
