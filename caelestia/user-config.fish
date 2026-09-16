
# caelestia-tools: add ~/.local/bin to PATH
if not contains ~/.local/bin $PATH
    set -gx PATH $PATH ~/.local/bin
end
