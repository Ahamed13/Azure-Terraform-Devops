#Random string resource
resource "random_string" "myrandom" {
    length = 6
    upper = false
    special = false  
}