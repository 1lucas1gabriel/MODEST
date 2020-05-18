# MODEST
MODEST é um pacote com equacionamento cinemático de uma esteira com comunicação
via Robot Operation System – ROS. Foi desenvolvido com o intuito de modelar o comportamento
de uma esteira para integração e representação em um modelo 3D.
Este pacote **depende de outros 3 pacotes (ou bibliotecas) que devem ser baixados e
adicionados ao ambiente para seu pleno funcionamento.** A Biblioteca 3 é uma dependência para
correto funcionamento da 2 (para algumas funções são requisitadas operações de sincronização e
tempo).
1. [ROS_Bridge](https://github.com/ModROS/ROS_Bridge)
2. [Modelica_DeviceDrivers](https://github.com/modelica-3rdparty/Modelica_DeviceDrivers)
3. [Modelica_Synchronous](https://github.com/modelica/Modelica_Synchronous)

Este contém: **Examples, Componentes e Icons.** Tem-se como componentes: **Esteira,
ControladorEsteira, Controlador2Step e Kinematic.** Informações detalhadas sobre cada bloco
estão disponibilizados em cada um destes (visualize Documentation View).
