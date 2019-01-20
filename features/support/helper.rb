# helper module
module Helper
  def take_screenshot(file_name, result)
    file_path = "results/screenshots/#{result}"
    screenshot = "#{file_path}/#{file_name}.png"
    page.save_screenshot(screenshot)
    embed(screenshot, "image/png", "Click here to see screenshot")
  end
end
