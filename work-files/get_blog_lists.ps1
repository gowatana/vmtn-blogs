$num_max = 431
$url_base = "https://communities.vmware.com/people/gowatana/blog?start="
$page_interval = 15

$time_stamp = Get-Date -f "yyyyMMdd_HHmmss"
$csv_file = "vmtn_blogs_" + $time_stamp + ".csv"

$num=0
for(){
    $num
    if($num -ge $num_max){break}
    
    $url = $url_base + $num.ToString()
    $page = Invoke-WebRequest -Uri $url
    $blog_list = $page.Links |
        where {$_.href -match ".*/people/gowatana/blog/20../../../*"} |
        where {$_.href -notmatch ".*\#comments$"} |
        where {$_.outerText -notmatch "^Permalink$"} |
        select href, outerText
    $blog_list
    $blog_list | Export-Csv -NoTypeInformation -Path $csv_file -Encoding UTF8 -Append
    $num += $page_interval
    Start-Sleep 1
}




