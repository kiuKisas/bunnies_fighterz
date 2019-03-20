//= require waitforelem
//= require stockviewupdater

// TODO: make it a class
function statWrapper(statWrapperId) {
  wrapper = document.getElementById(statWrapperId)
  return {
    wrapper : wrapper,
    input : wrapper.getElementsByTagName('input')[0],
    progress : wrapper.getElementsByClassName('rpgui-progress')[0],
  }
}

function initProgBarDOM_bck(statWrapperId, statNbr, statMax) {
	waitForElement('.rpgui-progress-fill').then(function(element) {
    const size = (statNbr/statMax)
		const stat = statWrapper(statWrapperId)
    RPGUI.set_value(stat.progress, size)
	})
}

let statMax;
let statMin;
let stockMax;

function initProgBarDOM(statWrapperId, statNbr, statMax, statMin = 0, stockMax = 0) {
  self.statMax = statMax
  self.statMin = statMin
  self.stockMax = stockMax
	waitForElement('.rpgui-progress-fill').then(function(element) {
    const size = (statNbr/statMax)
		const stat = statWrapper(statWrapperId)
    RPGUI.set_value(stat.progress, size)
	})
}

function updateProgBarDOM(stat, statNbr, statMax = self.statMax) {
  stat.input.value = statNbr
  RPGUI.set_value(stat.progress, (statNbr/statMax))
}

function addStat(statWrapperId, stockInputId) {
  // TODO: refacto
  const stockInput = document.getElementById(stockInputId)
  const stat = statWrapper(statWrapperId)
  stockNbr = parseInt(stockInput.value)

  if (stockNbr > 0 && stat.input.value < self.statMax) {
  stockInput.value = --stockNbr
  incStockView('stock-view', stockNbr)
  statNbr = parseInt(stat.input.value)
  ++statNbr
  updateProgBarDOM(stat, statNbr)
  }
}

function rmStat(statWrapperId, stockInputId) {
  // TODO: refacto
  const stockInput = document.getElementById(stockInputId)
  const stat = statWrapper(statWrapperId)
  stockNbr = parseInt(stockInput.value)

  if (stockNbr <= self.stockMax && stat.input.value != self.statMin) {
    stockInput.value = ++stockNbr
    incStockView('stock-view', stockNbr)
    statNbr = parseInt(stat.input.value)
    --statNbr
    updateProgBarDOM(stat, statNbr)
  }
}
