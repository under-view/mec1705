// SPDX-License-Identifier: GPL-2.0

/*
 * MEC1705 eSPI Controller Driver
 */
#include <linux/module.h>
#include <linux/of.h>
#include <linux/of_platform.h>
#include <linux/of_address.h>
#include <linux/platform_device.h>
#include <linux/spi/spi.h>

/*
 * struct mec1705_espi (MEC1705 Intel Enhanced Serial Peripheral Interface)
 *
 * @dev  - Pointer to MEC1705 (struct device info)
 * @regs -
 */
struct mec1705_espi {
	struct device *dev;
	void __iomem *regs;
};

static int mec1705_espi_probe(struct platform_device *mec1705)
{
	struct spi_master *master;
	//struct mec1705_espi *mec1705_espi;
	struct device *dev = &mec1705->dev;

	const char *compatible_propery;
	device_property_read_string(dev, "compatible", &compatible_propery);
	dev_warn(dev, "compatible: %s", compatible_propery);

	dev_warn(dev, "Allocating MEC1705 eSPI master for serial communications");
	master = devm_spi_alloc_master(dev, sizeof(struct mec1705_espi));
	if (!master) {
		dev_err(dev, "spi_alloc_master: Failed to allocate MEC1705 eSPI master");
		return -ENOMEM;
	}

	dev_set_drvdata(dev, master);

	return 0;
}

static int mec1705_espi_remove(struct platform_device *mec1705)
{
	dev_warn(&mec1705->dev, "ENTER mec1705_espi_remove function driver bound to ACPI table");
	return 0;
}

static const struct of_device_id of_mec1705_espi_match[] = {
	{ .compatible = "microchip,mec1705-espi" },
	{}
};

MODULE_DEVICE_TABLE(of, of_mec1705_espi_match);

static const struct platform_device_id mec1705_platform_devid[] = {
	{ "mec1705-espi", 0 },
	{ }
};

static struct platform_driver mec1705_espi_driver = {
	.driver = {
		.name = "mec1705_espi",
		.of_match_table = of_mec1705_espi_match,
	},
	.id_table   = mec1705_platform_devid,
	.probe      = mec1705_espi_probe,
	.remove	    = mec1705_espi_remove,
};

module_platform_driver(mec1705_espi_driver);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Vincent Davis (vince@underview.tech)");
MODULE_DESCRIPTION("Microchip MEC1705 eSPI Controller Driver");
