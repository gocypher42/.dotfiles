--
-- Module for marcotte functions
--

is_marcotte_computer = function()
  if os.getenv("MARCOTTE_WORKSTATION_TYPE") then
    return true end
  return false
end
