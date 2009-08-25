class GemNamespaceOwnership < ActiveRecord::Base
  
  belongs_to :group
  
  validates_presence_of :group_id, :namespace
  
  def self.import_complete_gem_map(filename)
    GemNamespaceOwnership.delete_all
    Marshal.load(File.read(filename)).each do |gem_name, unix_group_name|
      if !Group.exists?(:unix_group_name => unix_group_name)
        puts "Skipping #{unix_group_name} owns #{gem_name} since #{unix_group_name} doesn't exist"
        next
      end  
      namespace = get_name_from_script(gem_name)
      if namespace.blank?
        puts "Skipping #{unix_group_name} owns #{gem_name} since '#{gem_name}' is blank"
        next
      end
      group = Group.find_by_unix_group_name(unix_group_name)
      if exists?(:group_id => group.id, :namespace => namespace)
        puts "Skipping #{unix_group_name} owns #{gem_name} since #{gem_name} is already claimed by #{unix_group_name}"
        next
      end
      puts "Creating GemNamespaceOwnership for #{unix_group_name} owns #{gem_name}"
      GemNamespaceOwnership.create!(:group => group, :namespace => namespace)
    end
  end
  
  def self.get_name_from_script(long_name)
    names = long_name.split(/-[0-9]/)
    names.size > 1 ? names[0] : nil
  end
  
  
end
