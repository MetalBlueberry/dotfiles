function fish_right_prompt -d "Write out the right prompt"
    date '+%X'
    if [ -n "$AWS_PROFILE" ]
       echo " - "
       echo $AWS_PROFILE 
    end
end
