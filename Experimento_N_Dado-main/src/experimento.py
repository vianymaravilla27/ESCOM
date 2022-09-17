import random
from bokeh.plotting import figure, output_file, show

def main():
    results = results_experiment()
    for result in results: 
        print(f'{result[0]}: {result[1]}')
    generate_graphic(results)
    generate_document(results)


def results_experiment():
    dices = int(input('¿Cuántos dados quieres? '))
    new_results = []
    for i in range(dices, (dices * 6) + 1):
        result = [i, 0]
        new_results.append(result)
    print(new_results)
    n_experiments = int(input('¿Cuántas veces quieres realizar el experimento? '))
    for i in range(0, n_experiments):
        faces = []
        result_faces = 0
        for i in range(0, dices):
            faces.append(random.randint(1, 6))
        for face in faces:
            result_faces = result_faces + face
        modification = new_results[result_faces - dices]
        modification[1] = modification[1] + 1
        new_results[result_faces - dices] = modification
    return new_results


def generate_graphic(results):
    x_values = []
    y_values = []
    output_file("./../generated_files/graphic.html")
    fig = figure()
    for result in results:
        x_values.append(result[0])
        y_values.append(result[1])
    fig.line(x_values, y_values, width=5)
    show(fig)


def generate_document(results):
    new_file = open("./../generated_files/results.txt", "w")
    for result in results:
        new_file.write(str(result[0]) + ", " + str(result[1]) + "\n")
    new_file.close()


if __name__ == '__main__':
    main()