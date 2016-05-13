class Photo < ActiveRecord::Base
	
  dragonfly_accessor :image do

   after_assign do |img|
    img.encode!('jpg', '-quality 80') if img.image?
   end
=begin
   after_assign do |img|
    img.rotate!(90) # 90 is the amount of degrees to rotate
   end
=end
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end


validates :title, presence: true, length: {minimum: 2, maximum: 20}
validates :image, presence: true

validates :image, presence: true
validates_size_of :image, maximum: 500.kilobytes,
                  message: "should be no more than 500 KB", if: :image_changed?

validates_property :format, of: :image, in: [:jpeg, :jpg, :png, :bmp], case_sensitive: false,
                   message: "should be either .jpeg, .jpg, .png, .bmp", if: :image_changed?



end
