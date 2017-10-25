  ## Módulo do curso : EXPLANATORY DATA ANALYSIS
  ## Semana 01 - projeto01
  ## Gráfico - 04
  ## Geraldo Barbosa do Amarante
 
  ## Preparação do ambiente
  setwd("c:/amarante/coursera/projeto01")
  
  ## Leitura do arquivo de dados
  arquivoDados <- read.table("./dados/household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";"  )

  ## Adiciona uma coluna para data e hora
  dataHora <- strptime(paste(arquivoDados$Date, arquivoDados$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
  arquivoDados <- cbind(arquivoDados, dataHora) 
     
  ## Formata os campos do arquivo conforme instruções do projeto
  ## Date                 : Date in format dd/mm/yyyy
  ## Time                 : time in format hh:mm:ss
  ## Global_active_power  : household global minute-averaged active power (in kilowatt)
  ## Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
  ## Voltage              : minute-averaged voltage (in volt)
  ## Global_intensity     : household global minute-averaged current intensity (in ampere)
  ## Sub_metering_1       : energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
  ## Sub_metering_2       : energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
  ## Sub_metering_3       : energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

  arquivoDados$Date <- as.Date(arquivoDados$Date, format="%d/%m/%Y")
  arquivoDados$Time <- format(arquivoDados$Time, format="%H:%M:%S")
  arquivoDados$Global_active_power <- as.numeric(arquivoDados$Global_active_power)
  arquivoDados$Global_reactive_power <- as.numeric(arquivoDados$Global_reactive_power)
  arquivoDados$Voltage <- as.numeric(arquivoDados$Voltage)
  arquivoDados$Global_intensity <- as.numeric(arquivoDados$Global_intensity)
  arquivoDados$Sub_metering_1 <- as.numeric(arquivoDados$Sub_metering_1)
  arquivoDados$Sub_metering_2 <- as.numeric(arquivoDados$Sub_metering_2)
  arquivoDados$Sub_metering_3 <- as.numeric(arquivoDados$Sub_metering_3)
  
  ## Seleciona os dados entre as datas 01/02/2007 e 02/02/2007
  ## We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data
  ## from just those dates rather than reading in the entire dataset and subsetting to those dates.
  subconjuntoDados <- subset(arquivoDados, Date == "2007-02-01" | Date =="2007-02-02")
  
  ## Gerara o gráfico segundo as instruções de dimentsão: altura= 480 e largura = 480
  ## Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
  png("./graficos/plot4.png", width=480, height=480)
  ## Define algumas características e gera o gráfico
  par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
  with(subconjuntoDados, {
    plot(Global_active_power~dataHora, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    plot(Voltage~dataHora, type="l", 
         ylab="Voltage (volt)", xlab="")
    plot(Sub_metering_1~dataHora, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~dataHora,col='Red')
    lines(Sub_metering_3~dataHora,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~dataHora, type="l", 
         ylab="Global Rective Power (kilowatts)",xlab="")
    })
    ## Libera o dispositivo
  dev.off()