new() {
    export DATE_FMT=$(date +"%Y-%m-%d") 
    echo $DATE_FMT  
    cp model.md "${DATE_FMT}.md"
}