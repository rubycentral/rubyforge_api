Consider this for API docs:
http://techblog.floorplanner.com/2008/05/07/rapidoc-rails-rest-api-documentation-generation-well-just-rapidoc/ 

Used this to install the machinist gem:
sudo gem install notahat-machinist --source http://gems.github.com

Some notes about news byte creation:
# sample data for a support group "Merry Chrismas" news byte:
 # THESE MUST BE CREATED AS PART OF THE NEWS BYTE
 gforge=> select id, group_id, forum_id from news_bytes where group_id = 5 and forum_id = 589;
  id  | group_id | forum_id 
 -----+----------+----------
  188 |        5 |      589
 (1 row)
 gforge=>  select * from forum_group_list where group_id = 3 and group_forum_id = 589;
  group_forum_id | group_id |    forum_name    | is_public |   description    | allow_anonymous | send_all_posts_to 
 ----------------+----------+------------------+-----------+------------------+-----------------+-------------------
             589 |        3 | merry-christmas- |         1 | Merry Christmas! |               0 | 
 (1 row)

 ### THESE ARE THE REPLIES; THEY ARE CREATED AFTER THE FACT
 gforge=> select msg_id, group_forum_id, posted_by, subject from forum where group_forum_id = 589;
  msg_id | group_forum_id | posted_by |            subject             
 --------+----------------+-----------+--------------------------------
     766 |            589 |       154 | happy christmas +  newyear
     775 |            589 |       119 | RE: happy christmas +  newyear
 (2 rows)
