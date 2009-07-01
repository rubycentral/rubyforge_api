class NewsBytesController < ApplicationController
  
# sample data for a support group "Merry Chrismas" news byte:
=begin
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

=end
  def create
    raise "NOT YET IMPLEMENTED"
    ensure_is_group_admin || access_denied
    Group.transaction do
      @news_byte_forum = Group.system_news_group.forum_group.create()
      @news_byte = group.news_bytes.create!(params[:news_byte])
    end
    respond_to do |wants| 
      wants.js {render :json => @news_byte, :status => :created, :location => group_news_byte_url(group, @news_byte)}
    end
  end
  
  private
  
  def ensure_is_group_admin
    current_user.user_group.find_by_group_id(group.id).group_admin?
  end
  
end