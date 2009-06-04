class GemDownload < ActiveRecord::Base
  def self.update_gems_features_box
    datestr = (Time.now - (60*60*24*7)).strftime("%d-%b-%y")
    sql = "select gem_name, count(gem_name) as total from gem_downloads where downloaded_at > '#{datestr}' group by gem_name order by total desc limit 15"
    File.open("/var/www/gems/stats_features_box.html", "w") do |f| 
      f.write(ActiveRecord::Base.connection.query(sql).inject("") {|memo, r| "#{memo}\n(#{number_with_delimiter(r[1].to_i)}) #{r[0].split(".gem")[0]}<br/>" }) 
    end
  end
  def self.update_overall_gem_stats
    sql = "select gem_name, count(gem_name) as total from gem_downloads group by gem_name"
    stats = {}
    ActiveRecord::Base.connection.query(sql).each do |r|
      begin
        short_name = r[0].split(/-[0-9]/)[0].gsub(/\//, "")
        stats[short_name] ||= 0
        stats[short_name] += r[1].to_i
      rescue Exception => e
        puts "Skipping #{r[0]} (nil? == #{r[0].nil?}) due to an exception"
        puts e.message
        puts e.backtrace
      end
    end
    stats_arr = stats.sort {|a,b| b[1] <=> a[1] }
    total = 0
    stats_arr.each {|r| total += r[1].to_i }
    out = "<html><head><title>Gem download stats</title></head><body><h3>Generated #{Time.now}; #{total} RubyGem downloads to date</h3><table><tr><th>Gem</th><th>Downloads</th></tr>"
    stats_arr.each do |r|
      next if r[1] < 10
      out << "<tr><td><a name=\"#{r[0]}\">#{r[0]}</a></td><td>#{r[1]}</td></tr>\n"
    end
    out  << "</table></body></html>"
    File.open("/var/www/gems/stats.html", "w") {|f| f.write(out) }
  end

  # TODO - import ActiveSupport (or whatever) instead
  def self.number_with_delimiter(number, delimiter=",")
    number.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{delimiter}")
  end
end

