json.array!(@thing_images) do |thing_image|
  json.extract! thing_image, :id, :thing_id, :image_id, :priority, :creator_id, :created_at, :updated_at
  json.thing_name thing_image.thing_name if thing_image.respond_to?(:thing_name)
  json.image_caption thing_image.image_caption if thing_image.respond_to?(:image_caption)
end
