class Photo < ActiveRecord::Base



  dragonfly_accessor :image do

   after_assign do |img|
    img.encode!('jpg', '-quality 80') if img.image?
   end

   after_assign do |img|
    img.rotate!(90) # 90 is the amount of degrees to rotate
   end

end




validates :title, presence: true, length: {minimum: 2, maximum: 20}
validates :image, presence: true

validates :image, presence: true
validates_size_of :image, maximum: 500.kilobytes,
                  message: "should be no more than 500 KB", if: :image_changed?

validates_property :format, of: :image, in: [:jpeg, :jpg, :png, :bmp], case_sensitive: false,
                   message: "should be either .jpeg, .jpg, .png, .bmp", if: :image_changed?

validates_property :width, of: :image, in: (0..400),
                           message: proc{ |actual, model| "Unlucky #{model.title} - was #{actual}" }





=begin  на потом

def resource_params
    allowed = [
      :title,
      :sub_title,
      :comment,
      fp(:photo)
    ]

    params.require(:feedback).permit(*allowed)
end




	add_column :photos, :image_uid,  :string
	add_column :photos, :image_name, :string	# Optional - if you want urls
                                            	# to end with the original filename


attr_accessible :image, :title
resources :photos, only: [:new, :create, :index]
root to: 'photos#index'
end

=end
end
