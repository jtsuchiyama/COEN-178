Select clubname,fee from Members Natural Join Club;
Select Distinct clubname,fee from Members Natural Join Club;
Select members.clubname,fee from Members INNER JOIN Club ON Members.clubname = Club.clubname;
Select Distinct members.clubname,fee from Members INNER JOIN Club ON Members.clubname = Club.clubname;
Select name,members.clubname,fee from Members Left Join Club ON Members.clubname = Club.clubname;
Select name,club.clubname,fee from Members Right Join Club ON Members.clubname = Club.clubname;
