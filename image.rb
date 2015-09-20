class Image 

	
	def initialize(input)
	@input = input 
	#define as instance variable 
	@c = input.first.size
	 # find the amount of collums assuming all are equal to the first one  
	@r = input.size 
	# find amount of rows 
	#@input_copy = Array.new(@r){Array.new(@c)}
	#create a empty array that is the same size
	#how could I set it all to zero 
	@input_copy = Array.new(@r){|i| Array.new(@c) { |i| 0 }} 
	#-Explain 
	#@input_copy.each {|x|print x} 
	#@input.each {|x|print x}
	@coumter = 1 
	end 

	
	def output_image
		@input.each do |input|
		puts input.join('')
		end 
		#puts @r
 		#puts @c

		#@input_copy.each do |input|
		#puts input.join('')
		#.inspect
		
		#end 

	end 

	
	
def output_image_blur
		#@input.each do |input|
		#puts input.join('')
		#end 
		#puts @r
 		#puts @c

		@input_copy.each do |input|
		puts input.join('')
		#.inspect
		
		end 

	end 
	








	def blur
		@input.each_with_index do |row, row_i|
			row.each_with_index do |cell, collum_i|
					if cell == 1 
						puts "row index #{row_i } has in index #{collum_i} a number 1, row size #{@r}, collum size #{@c}"
					@input_copy[row_i][collum_i]=1
					begin 
						@input_copy[row_i+1][collum_i]=1
					rescue NoMethodError 
					end 
					# covers 
					if row_i != 0 
					@input_copy[row_i-1][collum_i]=1
					end 
					#covers
					if collum_i != @c-1 
					@input_copy[row_i][collum_i+1]=1
					end 
					#covers 
					if collum_i != 0 
					@input_copy[row_i][collum_i-1]=1
					end
				end 
			end 
		end 

		#@input_copy.each {|x|print x} 
	end 



def m_blur(a)

 

		@input.each_with_index do |row, row_i|
			row.each_with_index do |cell, collum_i|
				if cell == 1 

					puts "row index #{row_i } has in index #{collum_i} a number 1, row size #{@r}, collum size #{@c}"

					@input_copy[row_i][collum_i]=1
					


					
				end 
			end 
		end 

	end 


end 



image = Image.new([
  [0, 0, 0, 0,0,0,0,0,0,0, 0, 0,0,0,0,0,0,1],
  [0, 0, 0, 0,0,0,0,0,0,0, 0, 0,0,0,0,0,0,0],
  [0, 0, 0, 0,0,0,0,0,0,0, 0, 0,0,0,0,0,0,0],
  [0, 0, 0, 0,0,0,0,0,0,0, 0, 0,0,0,0,0,0,0],
  [0, 0, 0, 0,0,0,0,0,0,0, 0, 0,0,0,0,0,0,0],
  [0, 0, 0, 0,0,0,0,0,0,0, 0, 0,0,0,0,0,0,0],
  [0, 0, 0, 0,0,0,0,0,0,0, 0, 0,0,0,0,0,0,0],
  [0, 0, 0, 0,0,0,0,0,0,0, 0, 0,0,0,0,0,0,0],
  [0, 0, 0, 0,0,0,0,0,0,0, 0, 0,0,0,0,0,0,0],
  [0, 0, 0, 0,0,0,0,0,0,0, 0, 0,0,0,0,0,0,0],
  [0, 0, 0, 0,0,0,0,0,0,0, 0, 0,0,0,0,0,0,0],
  [0, 0, 0, 0,0,0,0,0,0,0, 0, 0,0,0,0,0,0,0],
  [0, 0, 0, 0,0,0,0,0,0,0, 0, 0,0,0,0,0,0,0],
  [0, 0, 0, 0,0,0,0,0,0,0, 0, 0,0,0,0,0,0,0],
  [0, 0, 0, 0,0,0,0,0,0,0, 0, 0,0,0,0,0,0,0],
  [0, 0, 0, 0,0,0,0,0,0,0, 0, 0,0,0,0,0,0,0],
  [0, 0, 0, 1,0,0,0,0,0,0, 0, 0,0,0,0,0,0,0],
  [0, 0, 0, 0,0,0,0,0,0,0, 0, 0,0,0,0,0,0,0],
  [0, 0, 0, 0,0,0,0,0,0,0, 0, 0,0,0,0,0,0,0]
])

image.output_image
#image.blur
#image.output_image_blur
##image.output_image
#puts "Begin"
image.m_blur(6)

image.output_image_blur


#why doesnt this work? 
#@input_copy.each do |ar|
			#ar.each do |x|
				#x=0
			#end 
		#end 

		#arr.each_with_index{|value,index| puts " #{index} is a #{value}";}
		#what does the ; do? 

#ignore below
		#if cell == 1 
					#puts "row index #{row_i } has in #{collum_i} a number 1"
				#end 